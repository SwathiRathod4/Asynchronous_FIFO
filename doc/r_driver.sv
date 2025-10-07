class afifo_r_driver extends uvm_driver#(afifo_rseq_item);
virtual afifo_interface intf;

`uvm_component_utils(afifo_r_driver)

function new(string name="afifo_r_driver",uvm_component parent);
  super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(virtual afifo_interface)::get(this,"","vif",intf))
`uvm_fatal("NO VIF",{ "virtual interface must be set for",get_full_name(),".vif"});
endfunction

virtual task run_phase(uvm_phase phase);
super.run_phase(phase);
//   #16;
forever begin

seq_item_port.get_next_item(req);
drive();
seq_item_port.item_done();
end
endtask


task drive();
  @(posedge intf.dri_r_cb)
  intf.dri_r_cb.rinc <= req.rinc;
 // intf.dri_r_cb.rempty <=rempty;
`uvm_info("READ_DRIVER",$sformatf("Driving from read driver"),UVM_LOW);
    req.print();
  repeat(2)@(posedge intf.dri_r_cb);
endtask
endclass

