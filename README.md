# PYNQ Tutorial 1 — Board Setup and GPIO

Nama : William Anthony
NIM : 13223048
EL4013

This folder contains a Jupyter Notebook and a small helper script to run through "PYNQ Tutorial 1: Board Setup and GPIO" (Hello World with AXI GPIO).

## How to run (concise)

- Run the simulate unit test locally (Windows PowerShell):

```powershell
cd D:\13223048_GPIOAssignment_VLSI
.\run_tests.ps1
```

## How to run the notebook on the board

1. Copy `design_1.bit`, `design_1.hwh`, and `design_1.tcl` to `/home/xilinx/` on the board (use WinSCP or `scp`).
2. Start the board and open the Jupyter server in a browser: `http://<board-ip>:9090` (default user/password often `xilinx`/`xilinx`).
3. Open `notebooks/PYNQ_Tutorial1_BoardSetup_and_GPIO.ipynb` and run the cells in order. Cells that use `pynq` must be executed on the board.

## Troubleshooting

- If `python` is not found on Windows, install Python 3 from python.org and enable "Add Python to PATH" during installation or enable the App Execution Alias in Settings.
- If the notebook fails to import `pynq` on the board, verify you are using the correct PYNQ image and that the overlay bitstream matches the HWH.