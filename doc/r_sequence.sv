`include "defines.svh"

class afifo_r_sequence extends uvm_sequence #(afifo_rseq_item);
  
  `uvm_object_utils(afifo_r_sequence)
  
  function new(string name = "r_sequence");
    super.new(name);
  endfunction 
  
  virtual task body();
   // repeat(`no_of_transactions) begin 
    req = afifo_rseq_item::type_id::create("req");
      `uvm_rand_send_with(req,{rinc == 1;})
   // end
  endtask
endclass

class afifo_r_sequence2 extends uvm_sequence #(afifo_rseq_item);
  
  `uvm_object_utils(afifo_r_sequence2)
  
  function new(string name = "r_sequence");
    super.new(name);
  endfunction 
  
  virtual task body();
    req = afifo_rseq_item::type_id::create("req");
    `uvm_rand_send_with(req,{rinc == 0;})
  endtask
endclass

class afifo_r_sequence3 extends uvm_sequence #(afifo_rseq_item);
  
  `uvm_object_utils(afifo_r_sequence3)
  
  function new(string name = "r_sequence");
    super.new(name);
  endfunction 
  
  virtual task body();
    repeat(`no_of_transactions) begin
     req = afifo_rseq_item::type_id::create("req");
      `uvm_rand_send_with(req,{rinc == 1;})
    end
  endtask
endclass

class afifo_r_sequence4 extends uvm_sequence #(afifo_rseq_item);
  
  `uvm_object_utils(afifo_r_sequence4)
  
  function new(string name = "r_sequence");
    super.new(name);
  endfunction 
  
  virtual task body();
    req = afifo_rseq_item::type_id::create("req");
    `uvm_rand_send_with(req,{rinc == 0;})
  endtask
endclass
