class afifo_r_agent extends uvm_agent;
  `uvm_component_utils(afifo_r_agent)
  
  afifo_r_driver dri;
  afifo_r_monitor mon;
  afifo_r_sequencer seqr;
  
  function new(string name="afifo_r_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active()==UVM_ACTIVE)
      begin
    dri=afifo_r_driver::type_id::create("afifo_r_driver",this);
    seqr=afifo_r_sequencer::type_id::create("afifo_r_sequencer",this);
    end
    
    mon=afifo_r_monitor::type_id::create("afifo_r_monitor",this);
    
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    if(get_is_active()==UVM_ACTIVE)
      dri.seq_item_port.connect(seqr.seq_item_export);
    
  endfunction
endclass
