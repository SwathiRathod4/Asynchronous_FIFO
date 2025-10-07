`include "defines.svh"
class afifo_w_sequence extends uvm_sequence #(afifo_wseq_item);
  
  `uvm_object_utils(afifo_w_sequence)
  
  function new(string name = "wr_sequence");
    super.new(name);
  endfunction 
  
  virtual task body();
  // repeat(`no_of_transactions) begin 
    req = afifo_wseq_item::type_id::create("req");
    `uvm_rand_send_with(req,{winc == 1;})
   //end
  endtask
endclass

class afifo_w_sequence2 extends uvm_sequence #(afifo_wseq_item);
  
  `uvm_object_utils(afifo_w_sequence2)
  
  function new(string name = "wr_sequence");
    super.new(name);
  endfunction 
  
  virtual task body();
    req = afifo_wseq_item::type_id::create("req");
    `uvm_rand_send_with(req,{winc == 0;})
  endtask
endclass

class afifo_w_sequence3 extends uvm_sequence #(afifo_wseq_item);
  
  `uvm_object_utils(afifo_w_sequence3)
  
  function new(string name = "wr_sequence");
    super.new(name);
  endfunction 
  
  virtual task body();
    repeat(`no_of_transactions) begin
     req = afifo_wseq_item::type_id::create("req");
    `uvm_rand_send_with(req,{winc == 1;})
    end
  endtask
endclass

class afifo_w_sequence4 extends uvm_sequence #(afifo_wseq_item);
  
  `uvm_object_utils(afifo_w_sequence4)
  
  function new(string name = "wr_sequence");
    super.new(name);
  endfunction 
  
  virtual task body();
    req = afifo_wseq_item::type_id::create("req");
    `uvm_rand_send_with(req,{winc == 0;})
  endtask
endclass
