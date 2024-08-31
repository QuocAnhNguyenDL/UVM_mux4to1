`ifndef AGENT
`define AGENT

//  Class: mux_agent
//
class mux_agent extends uvm_monitor;
    `uvm_component_utils(mux_agent);

    mux_driver d0;
    mux_sequencer s0;
    mux_monitor m0;

    function new(string name = "mux_agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        d0 = mux_driver::type_id::create("d0", this);
        s0 = mux_sequencer::type_id::create("s0", this);
        m0 = mux_monitor::type_id::create("mo", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        d0.seq_item_port.connect(s0.seq_item_export);
        
    endfunction: connect_phase
    
endclass: mux_agent


`endif