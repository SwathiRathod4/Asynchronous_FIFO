class afifo_w_sequencer extends uvm_sequencer#(afifo_wseq_item);
`uvm_component_utils(afifo_w_sequencer)

function new(string name="afifo_w_sequencer",uvm_component parent);
super.new(name,parent);
endfunction

endclass
