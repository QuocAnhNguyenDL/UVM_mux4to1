`ifndef SCOREBOARD
`define SCOREBOARD

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "mux_transaction.sv"
class mux_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(mux_scoreboard);

    uvm_tlm_analysis_fifo#(mux_transaction) rm2sb_fifo, mon2sb_fifo;
    uvm_analysis_export#(mux_transaction) rm2sb_export, mon2sb_export;
    mux_transaction act_trans_fifo[$], exp_trans_fifo[$];
    mux_transaction act_trans, exp_trans;
    bit error;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        rm2sb_export = new("rm2sb_export", this);
        mon2sb_export = new("mon2sb_export", this);
        rm2sb_fifo = new("rm2sb_fifo", this);
        mon2sb_fifo = new("mon2sb", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        rm2sb_export.connect(rm2sb_fifo.analysis_export);
        mon2sb_export.connect(mon2sb_fifo.analysis_export);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            rm2sb_fifo.get(exp_trans);
            if(exp_trans == null) $stop;
            exp_trans_fifo.push_back(exp_trans);
            mon2sb_fifo.get(act_trans);
            if(act_trans == null) $stop;
            act_trans_fifo.push_back(act_trans);
            compare();
        end
    endtask: run_phase

    task compare();
        mux_transaction act_trans, exp_trans;
        if(act_trans_fifo.size != 0) begin
            act_trans = act_trans_fifo.pop_front();
            if(exp_trans_fifo.size != 0) begin
                exp_trans = exp_trans_fifo.pop_front();
                
                if(act_trans.Y == exp_trans.Y) error = 0;
                else error = 1;
                
               `uvm_info("SB",$sformatf("EXP_TRANS"),UVM_LOW);
                exp_trans.print();
               `uvm_info("SB",$sformatf("ACT_TRANS"),UVM_LOW);
                act_trans.print();
            end
        end
      
    endtask: compare

    function void report_phase(uvm_phase phase);
      if(error==0) begin
        $display("-------------------------------------------------");
        $display("---------- INFO : TEST CASE PASSED --------------");
        $display("-------------------------------------------------");
      end else begin
        $display("-------------------------------------------------");
        $display("---------- ERROR : TEST CASE FAILED -------------");
        $display("-------------------------------------------------");
      end
    endfunction 
    
endclass: mux_scoreboard

`endif