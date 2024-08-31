`ifndef DRIVER
`define DRIVER

`include "uvm_macros.svh"
`include "mux_transaction.sv"
`include "interface.sv"
import uvm_pkg::*;
class mux_driver extends uvm_driver#(mux_transaction);
    `uvm_component_utils(mux_driver)

    virtual mux_interface m_if;
    uvm_analysis_port#(mux_transaction) dr2rm_port;

    function new(string name = "mux_driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual mux_interface)::get(this,"","m_if",m_if))
            `uvm_fatal("Driver","Could not get interface")
        dr2rm_port = new("dr2rm_port", this);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        reset();
        forever begin
            seq_item_port.get_next_item(req);
            drive();
            @(m_if.dr_cb)
                $cast(rsp, req.clone());
                rsp.set_id_info(req);
                seq_item_port.item_done();
                dr2rm_port.write(rsp);
                seq_item_port.put(rsp);
        end
    endtask: run_phase

    task reset();
        m_if.dr_cb.D0 <= 0;
        m_if.dr_cb.D1 <= 0;
        m_if.dr_cb.D2 <= 0;
        m_if.dr_cb.D3 <= 0;
        m_if.dr_cb.M <= 0;
    endtask

    task drive();
        wait(!m_if.reset);
        @(m_if.dr_cb);
            m_if.dr_cb.D0 <= req.D0;
            m_if.dr_cb.D1 <= req.D1;
            m_if.dr_cb.D2 <= req.D2;
            m_if.dr_cb.D3 <= req.D3;
            m_if.dr_cb.M <= req.M;
    endtask

endclass: mux_driver

`endif