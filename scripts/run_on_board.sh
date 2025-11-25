#!/bin/sh
# Nama : William Anthony
# NIM  : 13223048
# EL4013
#
# Convenience script to run the gpio_test helper on the PYNQ board.
# Usage:
#   ./run_on_board.sh [--bit /home/xilinx/design_1.bit] [--ip-hint axi_gpio] [--simulate]
#

BITFILE="/home/xilinx/design_1.bit"
IPHINT="axi_gpio"
SIM=""

usage() {
    echo "Usage: $0 [--bit PATH] [--ip-hint NAME] [--simulate]"
    exit 1
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        --bit)
            shift
            BITFILE="$1"
            ;;
        --ip-hint)
            shift
            IPHINT="$1"
            ;;
        --simulate)
            SIM="--simulate"
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Unknown arg: $1"
            usage
            ;;
    esac
    shift
done

echo "Running gpio_test with bitfile=$BITFILE ip-hint=$IPHINT simulate=$SIM"
python3 /home/xilinx/scripts/gpio_test.py --bit "$BITFILE" --ip-hint "$IPHINT" $SIM
