# PYNQ Tutorial 1 — Board Setup and GPIO

Nama : William Anthony
NIM : 13223048
EL4013

This folder contains a Jupyter Notebook and a small helper script to run through "PYNQ Tutorial 1: Board Setup and GPIO" (Hello World with AXI GPIO).

Files added:
- `notebooks/PYNQ_Tutorial1_BoardSetup_and_GPIO.ipynb` — step-by-step tutorial and example code cells for the board setup, Vivado export, and testing the GPIO from PYNQ.
- `scripts/gpio_test.py` — small helper script with a PYNQ GPIO example you can run on the board.

Quick start (on the PYNQ board):

1. Copy `design_1.bit`, `design_1.hwh`, and `design_1.tcl` to `/home/xilinx/` on the board (per tutorial).
2. Start the Jupyter server on the board and open the notebook at `http://<board-ip>:9090`.
3. In the notebook, run the cells in order. The example cells attempt to import `pynq` and will show detected GPIO IPs.

If you want, I can also:
- run a quick validation of the notebook contents, or
- adjust the example code to match the exact IP name in your Vivado block design.

Notes:
- The example code uses PYNQ APIs (pynq.Overlay and pynq.lib). Run it on the PYNQ board (not on your host PC) because it needs access to the bitstream and device registers.
- When powering off the board, use `sudo shutdown -h now` to avoid MicroSD corruption.

---
Created by GitHub Copilot (assistant).
