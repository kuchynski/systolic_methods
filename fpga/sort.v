`timescale 1ns / 1ps

module sort #(
    parameter integer SIZE = 8,
    parameter integer WIDTH = 32
)
(
    input clk,
    input rst_n,
    input[WIDTH-1:0] d,

    output reg[WIDTH-1:0] q,
    output reg active_input = 0,
    output reg active_output
);

    reg[WIDTH-1:0] registers[SIZE-1:0];
    reg[SIZE-1:1] active;
    reg[31:0] st = 0;
    integer i;

    always @(posedge clk) begin
        if (rst_n == 0) begin
            st <= 0;
            q <= 0;
            active_input <= 0;
            active_output <= 0;
            active <= 1;
            for(i = 0; i < SIZE; i = i + 1)
                registers[i] <= 0;
        end else begin
            st <= st + 1;
            active_input <= st < SIZE*2;

            if (st < 2) begin
            end else if (st < SIZE*2 + 2) begin                
                if (st[0] == 0) begin
                    registers[0] <= (d > registers[0])? d : registers[0];
                    for(i = 2; i < SIZE; i = i + 2) begin
                        registers[i-1] <= (registers[i] > registers[i-1])? registers[i-1] : registers[i];
                        registers[i]   <= (registers[i] > registers[i-1])? registers[i] : registers[i-1];
                    end
                end else begin
                    for(i = 1; i < SIZE; i = i + 2) begin
                        registers[i-1] <= (registers[i] > registers[i-1])? registers[i-1] : registers[i];
                        registers[i]   <= (registers[i] > registers[i-1])? registers[i] : registers[i-1];
                    end
                end
            end else if (st < SIZE*3 + 2) begin
                active_input <= 0;
                if (st[0] == 0) begin
                    for(i = 2; i < SIZE; i = i + 2) begin
                        registers[i-1] <= (registers[i] > registers[i-1])? registers[i-1] : registers[i];
                        registers[i]   <= (registers[i] > registers[i-1])? registers[i] : registers[i-1];
                        active[i] <= registers[i] < registers[i-1];
                    end
                    if (active == 0)
                        st <= SIZE*3 + 2;
                end else begin
                    for(i = 1; i < SIZE; i = i + 2) begin
                        registers[i-1] <= (registers[i] > registers[i-1])? registers[i-1] : registers[i];
                        registers[i]   <= (registers[i] > registers[i-1])? registers[i] : registers[i-1];
                        active[i] <= registers[i] < registers[i-1];
                    end
                end
            end else if (st < SIZE*4 + 2) begin
                active_output <= 1;
                for(i = 1; i < SIZE; i = i + 1)
                    registers[i] <= registers[i-1];
                q <= registers[SIZE-1];
            end else begin
                q <= 0;
                active_output <= 0;
                st <= st;
            end
        end
    end
endmodule
