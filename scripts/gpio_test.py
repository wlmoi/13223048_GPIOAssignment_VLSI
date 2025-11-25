"""
Simple helper script for testing AXI GPIO on a PYNQ board.

Nama : William Anthony
NIM : 13223048
EL4013

Run this on the PYNQ board (not on your host PC). Adjust the `BITFILE_PATH`
and the IP name if your AXI GPIO instance has a different name.

Usage on the board:
    python3 /home/xilinx/scripts/gpio_test.py

"""
from __future__ import print_function

import argparse
import logging
import sys

BITFILE_PATH_DEFAULT = "/home/xilinx/design_1.bit"
GPIO_IP_NAME_HINT_DEFAULT = "axi_gpio"

logging.basicConfig(level=logging.INFO, format="[%(levelname)s] %(message)s")
logger = logging.getLogger(__name__)


class MockAxiGPIO:
    """Simple mock for AxiGPIO to allow simulation on host."""

    def __init__(self):
        self._regs = {}

    def write(self, index, value):
        logger.info("(mock) write index=%s value=%s", index, value)
        self._regs[index] = value

    def read(self, index):
        val = self._regs.get(index, 0)
        logger.info("(mock) read index=%s => %s", index, val)
        return val


class MockOverlay:
    """Mock Overlay object exposing the minimal attributes used by the script."""

    def __init__(self, bitfile_path):
        logger.info("(mock) loading overlay from %s", bitfile_path)
        # fake an ip_dict with a single gpio entry
        self.ip_dict = {"axi_gpio_0": {}}
        self.bitfile_name = bitfile_path


def run_overlay_and_gpio(bitfile_path, ip_hint, simulate=False):
    """Load overlay and perform a simple write/read to the first matching AXI GPIO.

    Returns the read value (or raises on error).
    """
    if simulate:
        ol = MockOverlay(bitfile_path)
        gpio_impl = MockAxiGPIO()
        ip_names = list(ol.ip_dict.keys())
    else:
        try:
            from pynq import Overlay
            from pynq.lib import AxiGPIO
        except Exception as e:
            logger.error("PYNQ import failed: %s", e)
            raise

        logger.info("Loading overlay: %s", bitfile_path)
        ol = Overlay(bitfile_path)
        logger.info("Overlay loaded: %s", getattr(ol, "bitfile_name", "unknown"))
        ip_names = [k for k in ol.ip_dict.keys() if ip_hint in k.lower() or "gpio" in k.lower()]

    logger.info("Detected GPIO IPs: %s", ip_names)
    if not ip_names:
        raise RuntimeError("No AXI GPIO detected. Verify your bitstream and HWH file on the board.")

    ip_name = ip_names[0]
    logger.info("Using GPIO IP: %s", ip_name)

    if simulate:
        gpio = gpio_impl
    else:
        try:
            gpio = AxiGPIO(ol.ip_dict[ip_name])
        except Exception as e:
            logger.error("Failed to create AxiGPIO object: %s", e)
            raise

    # Example: write 168 and read back
    gpio.write(0, 168)
    val = gpio.read(0)
    logger.info("Wrote 168, read back: %s", val)
    return val


def parse_args(argv=None):
    p = argparse.ArgumentParser(description="PYNQ AXI GPIO test helper")
    p.add_argument("--bit", default=BITFILE_PATH_DEFAULT, help="Path to .bit file on the board")
    p.add_argument("--ip-hint", default=GPIO_IP_NAME_HINT_DEFAULT, help="Substring to match AXI GPIO IP name")
    p.add_argument("--simulate", action="store_true", help="Run a simulate mode on the host (no PYNQ required)")
    return p.parse_args(argv)


def main(argv=None):
    args = parse_args(argv)
    try:
        val = run_overlay_and_gpio(args.bit, args.ip_hint, simulate=args.simulate)
        logger.info("Final read value: %s", val)
        return 0
    except Exception as e:
        logger.error("Error: %s", e)
        return 2


if __name__ == "__main__":
    sys.exit(main())
