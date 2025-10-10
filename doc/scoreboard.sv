`include "defines.svh"
class afifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(afifo_scoreboard)
  virtual afifo_interface vif;
  
  uvm_tlm_analysis_fifo#(afifo_wseq_item)sco_wport;
  uvm_tlm_analysis_fifo#(afifo_rseq_item)sco_rport;
  
  bit [7:0] w_fifo[$];
  bit [7:0] r_fifo[$];
  bit[7:0] wdata,rdata;
  
  afifo_wseq_item wseq;
  afifo_rseq_item rseq;
  
  function new(string name="afifo_scoreboard",uvm_component parent);
    super.new(name,parent);
    sco_wport=new("sco_wport",this);
    sco_rport=new("sco_rport",this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
    sco_wport.get(wseq);
    sco_rport.get(rseq);
    
      compute(wseq,rseq);
      
    end
  endtask
    
  task compute(afifo_wseq_item wseq,afifo_rseq_item rseq);
    if(wseq.winc)begin
      
      if(w_fifo.size()==`depth)begin
        if (wseq.wfull==0) begin
            `uvm_error("SCOREBOARD", $sformatf("DUT did not assert wfull when FIFO is full wfull=%d",wseq.wfull));end
           else begin
             `uvm_info("SCOREBOARD", "WRITE blocked due to FIFO full (as expected)", UVM_LOW);end
          
      end
      else begin
          w_fifo.push_back(wseq.wdata);
        `uvm_info("SCOREBOARD", $sformatf("Collected WDATA = %0d", wseq.wdata), UVM_LOW);
    end
    end
    if(rseq.rinc)begin
      if(w_fifo.size()==0)begin
        if (!rseq.rempty) begin
          `uvm_error("SCOREBOARD", "DUT did not assert rempty when FIFO is empty");end
          
      else begin
        `uvm_info("SCOREBOARD", "READ blocked due to FIFO empty (as expected)", UVM_LOW);end
          
    end
   else begin
          r_fifo.push_back(rseq.rdata);
          `uvm_info("SCOREBOARD", $sformatf("Collected RDATA = %0d", rseq.rdata), UVM_LOW);
        
   
    
    wdata=w_fifo.pop_front();
     rdata=r_fifo.pop_front();
    if(wdata==rdata)
      begin
     `uvm_info("SCOREBOARD", $sformatf("MATCH:, wdata=%0d, rdata=%0d", wdata, rdata), UVM_LOW);end
      else begin
        `uvm_error("SCOREBOARD", $sformatf("MISMATCH: , wdata=%0d, rdata=%0d", wdata, rdata));end
    end
    end
  endtask 
endclass
    

