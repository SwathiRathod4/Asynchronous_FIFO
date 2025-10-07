`include "defines.svh"
class afifo_test extends uvm_test;
  `uvm_component_utils(afifo_test)
  afifo_environment env;
  
   virtual_sequence v_seq;
  
  function new(string name="afifo_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env=afifo_environment::type_id::create("env",this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    v_seq = virtual_sequence::type_id::create("v_seq");
    repeat(`no_of_transactions) begin
      v_seq.start(env.v_seqr);
    end
   // #5000;
    repeat(`no_of_transactions -1) @(posedge env.r_agent.dri.intf.dri_r_cb);
    phase.drop_objection(this);
  endtask
  
//   virtual task run_phase(uvm_phase phase);
//       afifo_w_sequence w_seq;
//     afifo_r_sequence r_seq;
//     super.run_phase(phase);
  
    
//     phase.raise_objection(this);
    
//     w_seq=afifo_w_sequence::type_id::create("w_seq");
//     r_seq=afifo_r_sequence::type_id::create("r_seq");
//     //repeat(2)begin
//     fork
//       begin w_seq.start(env.w_agent.seqr);end
//       begin r_seq.start(env.r_agent.seqr);end
//     join
//     repeat(50) @(posedge env.r_agent.dri.intf.dri_r_cb);
// //     end
//     phase.drop_objection(this);
//   endtask
  
endclass
