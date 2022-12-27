#!/bin/bash

configs=("imx8mm_ddr4_maaxboard_defconfig")
configs+=("imx8mq_maaxboard_defconfig")

devices=("imx8mm-ddr4-maaxboard")
devices+=("imx8mq-maaxboard")

device=${devices[0]}
config=${configs[0]}
clean=0

printusage() {
    echo "Usage: $0" >&2
    echo
    echo "    -d, --devicetree                DEVICE_TREE"
    for i in ${!devices[@]}; do
        echo "        ${devices[$i]}"
    done
    echo "    -c, --distclean                 enable make distclean"
    echo
    echo "Example:"
    echo "$0 -d imx8mq-maaxboard"
    echo "$0 -d imx8mm-ddr4-maaxboard -c"
    echo
    # echo some stuff here for the -a or --add-options 
    exit 1
}

run_check(){
    for i in ${!devices[@]}; do
        if [ ${devices[$i]} = $device ]; then
            config=${configs[$i]}
            echo "selected: $config"
            break
        fi
    done
}

run_build() {
    export CROSS_COMPILE=~/toolchain/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
    export ARCH=arm64
    if [ $clean -eq 1 ]; then
        make distclean
    fi
    echo "1. make $config"
    make $config
    echo "2. make"
    make flash.bin
}

parse_arguments() {
    while :
    do
        case "$1" in
        -d | --devicetree)
            device="$2"
            shift 2
            ;;
    
        -c | --distclean)
            clean=1
            shift
            ;;

        --) # End of all options
            shift
            break
            ;;

        -*)
            echo "Error: Invalid option: $1" >&2
            printusage
            ## or call function printusage
            exit 1 
            ;;

        *)  # No more options
            break
            ;;
        esac
    done
}


# main
if [ $# -eq 0 ]; then
    printusage
else
    parse_arguments $*
    run_check
    run_build
fi
