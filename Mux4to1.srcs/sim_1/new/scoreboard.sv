`ifndef SCOREBOARD
`define SCOREBOARD

//  Class: mux_scoreboard
//
class mux_scoreboard extends uvm_component;
    `uvm_component_utils(mux_scoreboard);

    uvm_tlm_analysis_fifo#(virtual mux_interface) rm2sb_fifo, mon2sb_fifo;
    uvm_analysis_export#(virtual mux_interface) rm2sb_export, mon2sb_export;
    mux_transaction act_trans_fifo[$], exp_trans_fifo[$];
    mux_transaction act_trans, exp_trans;
    bit error;

    function new(string name = "mux_scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction: new

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
    endfunction: connect_phase

    task scoreboard::run_phase(uvm_phase phase);
        forever begin
            rm2sb_fifo.get(exp_trans);
            (exp_trans == null) $stop;
            exp_trans_fifo.push_back(exp_trans);
            mon2sb_fifo.get(act_trans);
            if(act_trans == null) $stop;
            act_trans_fifo.push_back(act_trans);
            compare();
        end
    endtask: run_phase

    task compare();
        mux_transaction act_trans, exp_trans;
        if(act_trans.size() != 0) begin
            act_trans = act_trans_fifo.pop_front();
            if(exp_trans.size() != 0) begin
                exp_trans = exp_trans_fifo.pop_front();
                
                if(act_trans.Y == exp_trans.Y) this.error = 0;
                else this.error = 1;
                print_result();
            end
        end
    endtask: compare

    task print_result();
        if(this.error == 0) `uvm_info("Scoreboard", "DUNG", UVM_LOW)
        else  `uvm_info("Scoreboard", "DUNG", UVM_LOW)
    endtask : print_result
    
endclass: mux_scoreboard


`endif