class afifo_environment extends uvm_env;
  `uvm_component_utils(afifo_environment)
  
  afifo_w_agent w_agent;
  afifo_r_agent r_agent;
  afifo_scoreboard scoreboard;
  afifo_subscriber coverage;
  
    virtual_sequencer v_seqr;
  
  function new(string name="afifo_environment",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    w_agent=afifo_w_agent::type_id::create("afifo_w_agent",this);
    r_agent=afifo_r_agent::type_id::create("afifo_r_agent",this);
    scoreboard=afifo_scoreboard::type_id::create("afifo_scoreboard",this);
    coverage=afifo_subscriber::type_id::create("afifo_coverage",this);
     v_seqr = virtual_sequencer::type_id::create("v_seqr",this);
    endfunction
    
  virtual function void connect_phase(uvm_phase phase);
    w_agent.mon.mon_wport.connect(scoreboard.sco_wport.analysis_export);
    w_agent.mon.mon_wport.connect(coverage.cov_wport.analysis_export);
    r_agent.mon.mon_rport.connect(scoreboard.sco_rport.analysis_export);
    r_agent.mon.mon_rport.connect(coverage.cov_rport.analysis_export);
    
    v_seqr.wr_seqr = w_agent.seqr;
    v_seqr.rd_seqr = r_agent.seqr;
  endfunction
  
endclass
