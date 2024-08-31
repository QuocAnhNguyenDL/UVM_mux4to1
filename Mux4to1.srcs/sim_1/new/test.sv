`ifndef test    
`define test

//  Class: mux_test
//
class mux_test extends uvm_component;
    `uvm_component_utils(mux_test);

    mux_env e0;
    mux_sequence sequence0;

    function new(string name = "mux_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void test::build_phase(uvm_phase phase);
        super.build_phase(phase);
        e0 = mux_env::type_id::create("mux_env", this);
        sequence0 = mux_sequence::type_id::create("mux_sequence", this);
    endfunction: build_phase

    task test::run_phase(uvm_phase phase);
        phase.raise_objection(this);
        sequence0.start(e0.a0.squencer);
        phase.drop_objection(this);
    endtask: run_phase
    

endclass: mux_test


`endif