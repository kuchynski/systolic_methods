
# Sort with Systolic array, verilog or c implementation

<span style="color:yellow">1. verilog implementation - fpga/sort.v</span>

Implementation requires (WIDTH * SIZE) flip-flops.
The end of sorting is determined automatically! Running time depends on input values and takes (3 * SIZE) - (4 * SIZE) clk ticks including serial input/output time.

Usage: see fpga/sort_testbench.v for an example

    - parameter integer SIZE = 65565,   - number of input values    
    - parameter integer WIDTH = 32      - number of binary digits
    - input[WIDTH-1:0] d                - input data
    - output reg[WIDTH-1:0] q,          - sorted data
    - output reg active_input,          - input progress indicator
    - output reg active_output          - output progress indicator

<span style="color:yellow">2. C implementation - systolic_sorting.c </span>
Just c implementation)
There is no connection between verilog and C code, they are independent
