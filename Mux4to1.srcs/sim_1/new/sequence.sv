`ifndef SEQUENCE 
`define SEQUENCE 

//  Class: mux_sequence
//
class mux_sequence extends uvm_component;
    `uvm_component_utils(mux_sequence);

    function new(string name = "mux_sequence", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual task body();
        for(int i = 0; i < 100; i++) begin
            req = seq_item::type_id::create("req");
            start_item(req);
            assert(req.randomize());
            finish_item(req);
            get_response(rsp);
        end
    
endclass: mux_sequence

`endif