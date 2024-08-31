`ifndef INTERFACE 
`define INTERFACE 

interface mux_interface(input logic clk, reset);
    logic D0, D1, D2, D3;
    logic [1:0] M;
    logic Y;

    clocking dr_cb@(posedge clk);
        output D0;
        output D1;
        output D2;
        output D3;
        output M;
        input Y;
    endclocking

    modport DRV (clocking dr_cb, input clk, reset);

    clocking rc_cb@(negedge clk);
        input D0;
        input D1;
        input D2;
        input D3;
        input M;
        input Y;
    endclocking

    modport RCV (clocking rc_cb, input clk, reset);
endinterface

`endif