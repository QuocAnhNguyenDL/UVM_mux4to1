`ifndef ENV
`define ENV

//  Class: mux_env
//
class mux_env extends uvm_env;
    `uvm_component_utils(mux_env);

    mux_agent a0;
    mux_scoreboard sb0;
    mux_ref_model rm0;

    function new(string name = "mux_env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        a0 = mux_agent::type_id::create("a0", this);
        sb0 = mux_agent::type_id::create("sb0", this);
        rm0 = mux_ref_model::type_id:create("rm0", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        a0.d0.dr2rm_port.connect(rm0.rm_export);
        a0.m0.mon2sb_port.connect(sb0.mon2sb_export);
        rm0.rm2sb_port.connect(sb0.rm2sb_export);
    endfunction: connect_phase
    
    

    
endclass: mux_env


`endif