`include "defines.svh"
class afifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(afifo_scoreboard)
  virtual afifo_interface vif;
  
  uvm_tlm_analysis_fifo#(afifo_wseq_item)sco_wport;
  uvm_tlm_analysis_fifo#(afifo_rseq_item)sco_rport;
  
  bit [7:0] w_fifo[$];
  bit [7:0] r_fifo[$];
  
  afifo_wseq_item wseq;
  afifo_rseq_item rseq;
  
  function new(string name="afifo_scoreboard",uvm_component parent);
    super.new(name,parent);
    sco_wport=new("sco_wport",this);
    sco_rport=new("sco_rport",this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    
    fork
      forever begin
        sco_wport.get(wseq);

        // Check if FIFO is full
        if (r_fifo.size() == `depth) begin
          $display("fifo size=%d",r_fifo.size());
          if (wseq.wfull==0) begin
            `uvm_error("SCOREBOARD", $sformatf("DUT did not assert wfull when FIFO is full wfull=%d",wseq.wfull));
          end else begin
            `uvm_info("SCOREBOARD", "WRITE blocked due to FIFO full (as expected)", UVM_LOW);
          end
        end 
        
        else begin
          w_fifo.push_back(wseq.wdata);
          `uvm_info("SCOREBOARD", $sformatf("Collected WDATA = %0d", wseq.wdata), UVM_LOW);
        end

        //compare_if_possible();
      end

      
      forever begin
        sco_rport.get(rseq);

        // Check if FIFO is empty
        if (w_fifo.size() == 0) begin
          if (!rseq.rempty) begin
            `uvm_error("SCOREBOARD", "DUT did not assert rempty when FIFO is empty");
          end else begin
            `uvm_info("SCOREBOARD", "READ blocked due to FIFO empty (as expected)", UVM_LOW);
          end
        end else begin
          r_fifo.push_back(rseq.rdata);
          `uvm_info("SCOREBOARD", $sformatf("Collected RDATA = %0d", rseq.rdata), UVM_LOW);
        end
 $display("fifo size=%d",r_fifo.size());
        //compare_if_possible();
      end
    join
  endtask
  
    virtual function void check_phase(uvm_phase phase);
       int w_size = w_fifo.size();
    int r_size = r_fifo.size();
    super.check_phase(phase);

 

//     if (w_size != r_size) begin
//       `uvm_error("SCOREBOARD", $sformatf("Mismatch in transaction count: write=%0d, read=%0d", w_size, r_size));
//       return;
//     end

      for (int i = 0; i < `no_of_transactions; i++) begin
        
      bit [7:0] wdata = w_fifo[i];
      bit [7:0] rdata = r_fifo[i];
        

      if (wdata === rdata) begin
        `uvm_info("SCOREBOARD", $sformatf("MATCH: index=%0d, wdata=%0d, rdata=%0d", i, wdata, rdata), UVM_LOW);end
      else begin
        `uvm_error("SCOREBOARD", $sformatf("MISMATCH: index=%0d, wdata=%0d, rdata=%0d", i, wdata, rdata));end
    end
  endfunction
endclass
