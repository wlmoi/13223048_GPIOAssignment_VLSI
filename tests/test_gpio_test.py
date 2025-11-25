"""
Unit test for `gpio_test.py` using the simulate mode.

This test doesn't require PYNQ and can be run on the host.
"""
import sys
import os
import importlib.util

SCRIPT_PATH = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'scripts', 'gpio_test.py'))


def test_simulate_run():
    # Import the script as a module to call main() with simulate flag
    spec = importlib.util.spec_from_file_location('gpio_test', SCRIPT_PATH)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)

    # Call main with simulate flag
    rc = mod.main(['--simulate'])
    assert rc == 0
