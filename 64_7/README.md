# Implementation of <64,7> Computation Engine

Function *mac.m* contains the logic for a <Tm,Tn> multiplier and accumalator. Running script *sixfourseven.m* implements the mac in <64,7> config.

The output feature map is an array of size Tm=64 of the value 3.5.

The input feature map is a predefined array of size Tn=7, and static filter weights of the same dimension have been initialised.

## Verilog <64,7> Implementation

The verilog code and testbench can be found in ./verilog

It contains an un-optimized version mac\_fixpt.v and a fully unrolled version mac\_fixpt\_unrolled.v.

Running the top function along with the testbench in Xilinx Vivado resulted in a simulation pass as the expected result of 3.5 was found in each output feature map.
