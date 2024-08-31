`ifndef MONITOR
`define MONITOR

`include "uvm_macros.svh"
`include "mux_transaction.sv"
`include "interface.sv"
import uvm_pkg::*;

class mux_monitor extends uvm_monitor;
    `uvm_component_utils(mux_monitor);

    virtual mux_interface m_if;

    mux_transaction act_trans;

    uvm_analysis_port#(mux_transaction) mon2sb_port;

    function new(string name = "mux_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        act_trans = new("act_trans");
        mon2sb_port = new("mon2sb_port", this);

        if(!uvm_config_db#(virtual mux_interface)::get(this,"","m_if", m_if))
            `uvm_fatal("Monitor", "Could not get interface")
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        forever begin
            collect_trans();
            //act_trans.print();
            mon2sb_port.write(act_trans);
        end
    endtask: run_phase
    

    task collect_trans();
        wait(!m_if.reset)
        @(m_if.rc_cb);
            act_trans.D0 = m_if.rc_cb.D0;
            act_trans.D1 = m_if.rc_cb.D1;
            act_trans.D2 = m_if.rc_cb.D2;
            act_trans.D3 = m_if.rc_cb.D3;
            act_trans.M = m_if.rc_cb.M;
            act_trans.Y = m_if.rc_cb.Y;
    endtask

endclass: mux_monitor

`endif