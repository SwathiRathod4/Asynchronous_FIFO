class afifo_r_monitor extends uvm_monitor;
virtual afifo_interface intf;
afifo_rseq_item seq;

  uvm_analysis_port#(afifo_rseq_item)mon_rport;

`uvm_component_utils(afifo_r_monitor)

function new(string name="afifo_r_monitor",uvm_component parent);
super.new(name,parent);
  seq=new;
  mon_rport=new("mon_rport",this);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(virtual afifo_interface)::get(this,"","vif",intf))
`uvm_fatal("no vif",{"interface must be set for",get_full_name(),".vif"});
endfunction

virtual task run_phase(uvm_phase phase);
  super.run_phase(phase);
      //afifo_rseq_item seq;
//   #16;
  repeat(1)@(posedge intf.mon_r_cb);
  forever begin
    repeat(2)@(posedge intf.mon_r_cb);

    //seq = afifo_rseq_item::type_id::create("rseq_item");
  seq.rdata = intf.mon_r_cb.rdata;
  seq.rinc = intf.mon_r_cb.rinc;
  //seq.rrst_n = intf.mon_r_cb.rrst_n;
  seq.rempty = intf.mon_r_cb.rempty;
  `uvm_info("R_MON", $sformatf("Collected transaction: %s", seq.convert2string()), UVM_LOW)
        seq.print();

  mon_rport.write(seq);
   repeat(2)@(posedge intf.mon_r_cb);

  end
endtask
endclass
