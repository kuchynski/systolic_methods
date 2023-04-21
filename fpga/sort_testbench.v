`timescale 1ns / 1ps



module sort_testbench #(
    parameter integer SIZE = 1024,
    parameter integer WIDTH = 12
    )( );

    reg clk = 0;
    reg[WIDTH-1:0]d = 10;
    reg[7:0] st = 0;
    wire[WIDTH-1:0]q;
    reg rst_n = 0;
    wire active_input, active_output;

    always begin
        #10 clk = !clk;
    end
    always@(posedge clk) begin
        rst_n <= 1;
        st <= st + 1;
        if (st[0] && active_input)
            d <= $urandom%4000;//st[1]? d + 8 : d - 3;
    end

    sort # (
        .SIZE(SIZE),
        .WIDTH(WIDTH)
        ) sort_instance (
        .clk(clk),
        .rst_n(rst_n),
        .d(d),
        .q(q),
        .active_input(active_input),
        .active_output(active_output)
    );

endmodule
