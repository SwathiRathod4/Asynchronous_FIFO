`include "defines.svh"
interface afifo_interface(input bit wclk,rclk,wrst_n,rrst_n);
  
  logic [`data_width-1:0]wdata;
  logic [`data_width-1:0]rdata;
  logic winc,rinc;
  logic wfull,rempty;
  
  clocking dri_r_cb @(posedge rclk);
    default input #0 output #0;
    output rinc;
  endclocking
  
  clocking mon_r_cb @(posedge rclk);
    default input #0 output #0;
    input rdata,rinc,rempty;
  endclocking
  
  clocking dri_w_cb @(posedge wclk);
    default input #0 output #0;
    output wdata,winc;
  endclocking
  
  clocking mon_w_cb @(posedge wclk);
    default input #0 output #0;
    input wdata,winc,wfull;
  endclocking
  
  modport DRV_W(clocking dri_w_cb);
    modport MON_W(clocking mon_w_cb);
      modport DRV_R(clocking dri_r_cb);
        modport MON_R(clocking mon_r_cb);
  
endinterface
