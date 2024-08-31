`ifndef SEQ_TRANSACTION
`define SEQ_TRANSACTION

`include "uvm_macros.svh"
import uvm_pkg::*;

class mux_transaction extends uvm_sequence_item;

    rand bit D0, D1, D2, D3;
    rand bit [1:0] M;
    bit Y;

    `uvm_object_utils_begin(mux_transaction)
        `uvm_field_int(D0, UVM_ALL_ON)
        `uvm_field_int(D1, UVM_ALL_ON)
        `uvm_field_int(D2, UVM_ALL_ON)
        `uvm_field_int(D3, UVM_ALL_ON)
        `uvm_field_int(M, UVM_ALL_ON)
        `uvm_field_int(Y, UVM_ALL_ON)
    `uvm_object_utils_end
    
    function new(string name = "mux_transaction");
        super.new(name);
    endfunction

    constraint D0_c {D0 inside {0,1};}
    constraint D1_c {D1 inside {0,1};}
    constraint D2_c {D2 inside {0,1};}
    constraint D3_c {D3 inside {0,1};}
    constraint M_C  {M  inside {[2'b00:2'b11]};}
endclass: mux_transaction


`endif