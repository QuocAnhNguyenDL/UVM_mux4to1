`ifndef SEQUENCER 
`define SEQUENCER

//  Class: mux_sequencer
//
class mux_sequencer extends uvm_component;
    `uvm_component_utils(mux_sequencer);

    function new(string name = "mux_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction: new

endclass: mux_sequencer

`endif