`include "uvm_macros.svh"
`include "interface.sv"
`include "test.sv"
import uvm_pkg::*;

module top;

    bit clk;
    bit reset;

    initial begin
        #0 reset = 1;
        #20 reset = 0;
    end

    initial begin
        #0 clk = 0;
        forever #5 clk = ~clk;
    end

    mux_interface m_if(clk, reset);

    DUT D0(
        .D0(m_if.D0),
        .D1(m_if.D1),
        .D2(m_if.D2),
        .D3(m_if.D3),
        .M(m_if.M),
        .Y(m_if.Y)
    );

    initial begin
        run_test("mux_test");
    end

    initial begin
       uvm_config_db#(virtual mux_interface)::set(uvm_root::get(),"*","m_if", m_if);
    end
    
endmodule
    