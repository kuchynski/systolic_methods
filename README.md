
Sort with Systolic array, verilog or c implementation

1. verilog implementation - fpga/sort.v

    parameter integer SIZE = 65565,   - number of input values
    parameter integer WIDTH = 32      - number of binary digits

    input[WIDTH-1:0] d                - input data
    output reg[WIDTH-1:0] q,          - sorted data
    output reg active_input,          - input progress indicator
    output reg active_output          - output progress indicator

Implementation requires (WIDTH * SIZE) D flip-flops

Usage: see sort_testbench.v for an example


