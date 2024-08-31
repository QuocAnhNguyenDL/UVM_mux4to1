`ifndef AGENT
`define AGENT

`include "uvm_macros.svh"
`include "driver.sv"
`include "sequencer.sv"
`include "monitor.sv"
import uvm_pkg::*;
class mux_agent extends uvm_agent;
    `uvm_component_utils(mux_agent);

    mux_driver d0;
    mux_sequencer s0;
    mux_monitor m0;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        d0 = mux_driver::type_id::create("d0", this);
        s0 = mux_sequencer::type_id::create("s0", this);
        m0 = mux_monitor::type_id::create("mo", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        d0.seq_item_port.connect(s0.seq_item_export);
        
    endfunction
    
endclass: mux_agent

`endif