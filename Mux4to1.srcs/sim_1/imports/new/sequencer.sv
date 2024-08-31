`ifndef SEQUENCER 
`define SEQUENCER

`include "uvm_macros.svh"
`include "mux_transaction.sv"
import uvm_pkg::*;
class mux_sequencer extends uvm_sequencer#(mux_transaction);
    `uvm_component_utils(mux_sequencer);

    function new(string name = "mux_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction: new

endclass: mux_sequencer

`endif