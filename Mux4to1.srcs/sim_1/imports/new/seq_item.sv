`ifndef SEQ_TRANSACTION
`define SEQ_TRANSACTION

`include "macros.svh"
import uvm_pkg::*;

class mux_transaction extends uvm_sequence_item;

    rand bit D0, D1, D2, D3;
    rand bit [1:0] Y;
    bit M;

    `uvm_component_utils_begin(mux_transaction)
        `uvm_field_int(D0, UVM_ALL_ON)
        `uvm_field_int(D1, UVM_ALL_ON)
        `uvm_field_int(D2, UVM_ALL_ON)
        `uvm_field_int(D3, UVM_ALL_ON)
        `uvm_field_int(M, UVM_ALL_ON)
        `uvm_field_int(Y, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "mux_transaction", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    constraint D0 {D0 inside {0;1};}
    constraint D1 {D1 inside {0;1};}
    constraint D2 {D2 inside {0;1};}
    constraint D3 {D3 inside {0;1};}
    constraint M  {M  inside {[2'b00:2'b11]};}
endclass: seq_item


`endif