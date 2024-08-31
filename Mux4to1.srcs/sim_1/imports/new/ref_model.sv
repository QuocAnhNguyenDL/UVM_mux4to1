`ifndef REF_MODEL 
`define REF_MODEL

`include "uvm_macros.svh"
`include "mux_transaction.sv"
import uvm_pkg::*;
class mux_ref_model extends uvm_component;
    `uvm_component_utils(mux_ref_model);

    uvm_analysis_export#(mux_transaction) rm_export;
    uvm_analysis_port#(mux_transaction) rm2sb_port;
    uvm_tlm_analysis_fifo#(mux_transaction) rm_exp_fifo;
    mux_transaction rm_trans, exp_trans;

    function new(string name = "mux_ref_model", uvm_component parent );
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        rm_export = new("rm_export", this);
        rm2sb_port = new("rm2sb_port", this);
        rm_exp_fifo = new("rm_exp_fifo", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        rm_export.connect(rm_exp_fifo.analysis_export);
    endfunction
    
    task run_phase(uvm_phase phase);
        forever begin
            //`uvm_info("rm", $sformatf("a"), UVM_LOW)
            rm_exp_fifo.get(rm_trans);
            get_expected_transaction();
        end
    endtask

    task get_expected_transaction();
        rm_exp_fifo.get(rm_trans);
        this.exp_trans = rm_trans;
        if(exp_trans.M == 2'b00) exp_trans.Y = exp_trans.D0;
        else if(exp_trans.M == 2'b01) exp_trans.Y = exp_trans.D1;
        else if(exp_trans.M == 2'b10) exp_trans.Y = exp_trans.D2;
        else if(exp_trans.M == 2'b11) exp_trans.Y = exp_trans.D3;
        //rm_trans.print();
        rm2sb_port.write(exp_trans);
    endtask

endclass: mux_ref_model

`endif