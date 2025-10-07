class virtual_sequencer extends uvm_sequencer;
  
  `uvm_component_utils(virtual_sequencer)
  
  afifo_w_sequencer wr_seqr;
  afifo_r_sequencer rd_seqr;
  
  function new(string name = "virtual_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction 
  
endclass
