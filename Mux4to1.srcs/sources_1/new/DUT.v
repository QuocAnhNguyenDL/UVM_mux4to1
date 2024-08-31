`timescale 1ns / 1ps

module DUT(
    input D0, D1, D2, D3,
    input [1:0] M,
    output Y
    );
    
    assign Y = (M == 2'b00) ? D0:
               (M == 2'b01) ? D1:
               (M == 2'b10) ? D2:D3;
endmodule
