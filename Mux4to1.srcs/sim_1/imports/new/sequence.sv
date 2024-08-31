`ifndef SEQUENCE 
`define SEQUENCE 

`include "uvm_macros.svh"
`include "mux_transaction.sv"
import uvm_pkg::*;

class mux_sequence extends uvm_sequence#(mux_transaction);
    `uvm_object_utils(mux_sequence);

    function new(string name = "mux_sequence");
        super.new(name);
    endfunction: new

    virtual task body();
        for(int i = 0; i < 100; i++) begin
            mux_transaction req;
            req = mux_transaction::type_id::create("req");
            start_item(req);
            assert(req.randomize());
            finish_item(req);
            get_response(rsp);
        end
    endtask
    
endclass

`endif