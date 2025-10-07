`include "defines.svh"
`include "uvm_macros.svh"
  import uvm_pkg::*;
class afifo_rseq_item extends uvm_sequence_item;
  
 
  logic [`data_width-1:0] rdata;
  rand bit rinc,rrst_n;
  bit rempty;
  
  function new(string name ="seq_item");
    super.new(name);
  endfunction
  
  `uvm_object_utils_begin(afifo_rseq_item)
 
  `uvm_field_int(rdata,UVM_ALL_ON)

  `uvm_field_int(rinc,UVM_ALL_ON)
 
  `uvm_field_int(rrst_n,UVM_ALL_ON)

  `uvm_field_int(rempty,UVM_ALL_ON)
  `uvm_object_utils_end
  
  constraint c{rinc == 1;}
  
endclass
