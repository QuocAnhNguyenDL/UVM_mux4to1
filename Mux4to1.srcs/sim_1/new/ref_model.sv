`ifndef REF_MODEL 
`define REF_MODEL

//  Class: mux_ref_model
//
class mux_ref_model extends uvm_component;
    `uvm_component_utils(mux_ref_model);

    uvm_analysis_export#(virtual mux_interface) rm_export;
    uvm_analysis_port#(virtual mux_interface) rm2sb_port;
    uvm_tlm_analysis_fifo#(virtual mux_interface) rm_exp_fifo;
    mux_transaction act_trans, exp_trans;

    function new(string name = "mux_ref_model", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        rm_export = new("rm_export", this);
        rm2sb_port = new("rm2sb_port", this);
        rm_exp_fifo = new("rm_exp_fifo", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        rm_export.connect(rm_exp_fifo.analysis_export);
    endfunction: connect_phase
    
    task run_phase(uvm_phase phase);
        forever begin
            get_expected_transaction();
        end
    endtask: run_phase

    task get_expected_transaction();
        rm_exp_fifo.get(act_trans);
        this.exp_trans = act_trans;
        if(exp_trans.M = 2'b00) exp_trans.Y = D0;
        else if(exp_trans.M = 2'b01) exp_trans.Y = D1;
        else if(exp_trans.M = 2'b10) exp_trans.Y = D2;
        else if(exp_trans.M = 2'b11) exp_trans.Y = D3;
        rm2sb_port.write(exp_trans);
    endtask

endclass: mux_ref_model

`endif