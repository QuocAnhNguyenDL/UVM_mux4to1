`ifndef DRIVER
`define DRIVER

//  Class: mux_driver
//
class mux_driver extends uvm_component;
    `uvm_component_utils(mux_driver)

    virtual mux_interface m_if;
    uvm_analysis_port#(virtual mux_interface) dr2rm_port;

    function new(string name = "mux_driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void driver::build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!(uvm_config_db(virtual mux_interface)::get(this,"","m_if",m_if)));
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
                seq_item_port.put(rsp);
        end
    endtask: run_phase

    task reset();
        m_if.D0 <= 0;
        m_if.D1 <= 0;
        m_if.D2 <= 0;
        m_if.D3 <= 0;
        m_if.M <= 0;
    endtask

    task drive();
        wait(!reset);
        @(m_if.dr_cb);
            m_if.D0 <= req.D0;
            m_if.D1 <= req.D1;
            m_if.D2 <= req.D2;
            m_if.D3 <= req.D3;
            m_if.M <= req.M;
    endtask
    
    
    
endclass: mux_driver


`endif