#!/bin/bash
#########################################################################
# File Name: ../verilog.sh
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.github.io
# Created Time: Wed 11 Apr 2018 05:35:13 PM DST
#########################################################################

iverilog -o "test"  *.v
vvp -n "test" -lxt2

