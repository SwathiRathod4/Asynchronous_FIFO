class afifo_r_sequencer extends uvm_sequencer#(afifo_rseq_item);
`uvm_component_utils(afifo_r_sequencer)

function new(string name="afifo_r_sequencer",uvm_component parent);
super.new(name,parent);
endfunction

endclass
