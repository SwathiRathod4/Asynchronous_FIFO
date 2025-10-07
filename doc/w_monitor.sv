class afifo_w_monitor extends uvm_monitor;
  `uvm_component_utils(afifo_w_monitor)
  
virtual afifo_interface intf;
afifo_wseq_item seq;

  uvm_analysis_port#(afifo_wseq_item)mon_wport;



function new(string name="afifo_w_monitor",uvm_component parent);
super.new(name,parent);
  seq=new;
  mon_wport=new("mon_wport",this);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(virtual afifo_interface)::get(this,"","vif",intf))
`uvm_fatal("no vif",{"interface must be set for",get_full_name(),".vif"});
endfunction

virtual task run_phase(uvm_phase phase);
  super.run_phase(phase);
//    repeat(1)@(posedge intf.mon_w_cb);
//   #16;
  forever begin
    repeat(2)@(posedge intf.mon_w_cb);
  seq.wdata = intf.mon_w_cb.wdata;
  seq.winc = intf.mon_w_cb.winc;
  //seq.wrst_n = intf.mon_w_cb.wrst_n;
  seq.wfull = intf.mon_w_cb.wfull;
  `uvm_info("W_MON", $sformatf("Collected transaction: %s", seq.convert2string()), UVM_LOW)
        seq.print();
  
  mon_wport.write(seq);
    repeat(2)@(posedge intf.mon_w_cb);
  end
endtask
endclass
