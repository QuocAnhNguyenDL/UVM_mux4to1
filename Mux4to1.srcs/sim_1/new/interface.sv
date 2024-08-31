`ifndef INTERFACE 
`define INTERFACE 

interface mux_interface(input logic clk, reset);
    logic D0, D1, D2, D3;
    logic [1:0] Y;
    logic M;

    clocking dr_cb@(posedge clk);
        output D0;
        output D1;
        output D2;
        output D3;
        output Y;
        input M;
    endclocking

    modport DRV (clocking dr_cb, input clk, reset);

    clocking rc_cb@(negedge clk);
        output D0;
        output D1;
        output D2;
        output D3;
        output Y;
        input M;
    endclocking

    modport RCV (clocking rc_cb, input clk, reset);

`endif