class afifo_w_agent extends uvm_agent;
  `uvm_component_utils(afifo_w_agent)
  
  afifo_w_driver dri;
  afifo_w_monitor mon;
  afifo_w_sequencer seqr;
  
  function new(string name="afifo_w_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active()==UVM_ACTIVE)
      begin
    dri=afifo_w_driver::type_id::create("afifo_w_driver",this);
    seqr=afifo_w_sequencer::type_id::create("afifo_w_sequencer",this);
    end
    
    mon=afifo_w_monitor::type_id::create("afifo_w_monitor",this);
    
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    if(get_is_active()==UVM_ACTIVE)
      dri.seq_item_port.connect(seqr.seq_item_export);
    
  endfunction
endclass

