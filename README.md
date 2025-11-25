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

## How to run (concise)

- Run the simulate unit test locally (Windows PowerShell):

```powershell
cd D:\13223048_GPIOAssignment_VLSI
.\run_tests.ps1
```

- This script will check `python` is on PATH, install `pytest` for the current user if missing, and run `pytest -q tests/test_gpio_test.py` which exercises `gpio_test.py` in `--simulate` mode. The simulate mode does not require PYNQ or the board.

- To run the helper script on the PYNQ board (after uploading your files to `/home/xilinx`):

```bash
# on the PYNQ board shell
python3 /home/xilinx/scripts/gpio_test.py --bit /home/xilinx/design_1.bit --ip-hint axi_gpio
```

## How to run the notebook on the board

1. Copy `design_1.bit`, `design_1.hwh`, and `design_1.tcl` to `/home/xilinx/` on the board (use WinSCP or `scp`).
2. Start the board and open the Jupyter server in a browser: `http://<board-ip>:9090` (default user/password often `xilinx`/`xilinx`).
3. Open `notebooks/PYNQ_Tutorial1_BoardSetup_and_GPIO.ipynb` and run the cells in order. Cells that use `pynq` must be executed on the board.

## Uploading files (WinSCP quick steps)

- Start WinSCP and create a session to `192.168.2.99` (or your board IP). Username: `xilinx`, Password: `xilinx`.
- On the left pane navigate to your local Vivado project folder and find `design_1.bit`, `design_1.hwh`, and `design_1.tcl`.
- Drag these three files into `/home/xilinx/` on the right pane.

## If the AXI GPIO IP name differs

- In the notebook and `gpio_test.py` we try to auto-detect an IP whose name contains `axi_gpio` or `gpio`. If Vivado exported a specific name (for example `axi_gpio_0`) you can either:
	- Pass `--ip-hint axi_gpio_0` to `gpio_test.py`, or
	- Edit the notebook cell and replace the `GPIO_IP_NAME_HINT` string with the exact IP name, or
	- In a notebook cell run `print(list(ol.ip_dict.keys()))` after loading the overlay to see exact names and then update code accordingly.

## Flashing the MicroSD (reminder)

- On Windows use Win32DiskImager to write the `.img` file to the MicroSD card: select the `.img` file, select the MicroSD device, click `Write` and wait.
- Safely eject the card and insert it into your board.

## Troubleshooting

- If `python` is not found on Windows, install Python 3 from python.org and enable "Add Python to PATH" during installation or enable the App Execution Alias in Settings.
- If the notebook fails to import `pynq` on the board, verify you are using the correct PYNQ image and that the overlay bitstream matches the HWH.

---
If you'd like, I will now commit the current files to git with a clear message (I will not push). Say "commit" and I'll create the local commit for you.
