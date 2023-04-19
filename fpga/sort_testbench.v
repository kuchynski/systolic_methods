`timescale 1ns / 1ps



module sort_testbench(
    );

    reg clk = 0;
    reg[31:0]d = 10;
    reg[7:0] st = 0;
    wire[31:0]q;
    reg rst_n = 0;
    wire active_input, active_output;

    always begin
        #10 clk = !clk;
    end
    always@(posedge clk) begin
        rst_n <= 1;
        st <= st + 1;
        if (st[0])
            d <= st[1]? d + 5 : d - 3;
    end

    sort # (
        .SIZE(8),
        .WIDTH(32)
        ) sort_instance (
        .clk(clk),
        .rst_n(rst_n),
        .d(d),
        .q(q),
        .active_input(active_input),
        .active_output(active_output)
    );

endmodule
