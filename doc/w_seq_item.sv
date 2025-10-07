`include "defines.svh"
`include "uvm_macros.svh"
  import uvm_pkg::*;
class afifo_wseq_item extends uvm_sequence_item;
  
  rand logic [`data_width-1:0] wdata;
  rand bit winc,wrst_n;
  bit wfull;
  
  function new(string name ="seq_item");
    super.new(name);
  endfunction
  
  `uvm_object_utils_begin(afifo_wseq_item)
  `uvm_field_int(wdata,UVM_ALL_ON)
  
  `uvm_field_int(winc,UVM_ALL_ON)
 
  `uvm_field_int(wrst_n,UVM_ALL_ON)
 
  `uvm_field_int(wfull,UVM_ALL_ON)
 
  `uvm_object_utils_end
  constraint c{winc == 1;}
endclass
