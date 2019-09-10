// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Aug 24 19:09:01 2019
// Host        : luca running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top blk_mem_gen_0 -prefix
//               blk_mem_gen_0_ blk_mem_gen_0_stub.v
// Design      : blk_mem_gen_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_3,Vivado 2019.1" *)
module blk_mem_gen_0(clka, rsta, ena, wea, addra, dina, douta, clkb, rstb, enb, 
  web, addrb, dinb, doutb, rsta_busy, rstb_busy)
/* synthesis syn_black_box black_box_pad_pin="clka,rsta,ena,wea[0:0],addra[14:0],dina[6:0],douta[6:0],clkb,rstb,enb,web[0:0],addrb[14:0],dinb[6:0],doutb[6:0],rsta_busy,rstb_busy" */;
  input clka;
  input rsta;
  input ena;
  input [0:0]wea;
  input [14:0]addra;
  input [6:0]dina;
  output [6:0]douta;
  input clkb;
  input rstb;
  input enb;
  input [0:0]web;
  input [14:0]addrb;
  input [6:0]dinb;
  output [6:0]doutb;
  output rsta_busy;
  output rstb_busy;
endmodule
