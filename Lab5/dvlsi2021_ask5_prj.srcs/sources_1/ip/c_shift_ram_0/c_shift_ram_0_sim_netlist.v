// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Tue May 31 22:39:28 2022
// Host        : DESKTOP-5VPD5I3 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               e:/VLSI/Lab5/Lab5.srcs/sources_1/ip/c_shift_ram_0/c_shift_ram_0_sim_netlist.v
// Design      : c_shift_ram_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "c_shift_ram_0,c_shift_ram_v12_0_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_shift_ram_v12_0_12,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module c_shift_ram_0
   (D,
    CLK,
    SCLR,
    Q);
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME d_intf, LAYERED_METADATA undef" *) input [0:0]D;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:sinit_intf:sset_intf:d_intf:a_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef" *) output [0:0]Q;

  wire CLK;
  wire [0:0]D;
  wire [0:0]Q;
  wire SCLR;

  (* C_AINIT_VAL = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_SYNC_ENABLE = "0" *) 
  (* C_SYNC_PRIORITY = "1" *) 
  (* C_WIDTH = "1" *) 
  (* c_addr_width = "4" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "32" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_a = "0" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_opt_goal = "0" *) 
  (* c_parser_type = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_last_bit = "1" *) 
  (* c_shift_type = "0" *) 
  (* c_verbosity = "0" *) 
  (* c_xdevicefamily = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  c_shift_ram_0_c_shift_ram_v12_0_12 U0
       (.A({1'b0,1'b0,1'b0,1'b0}),
        .CE(1'b1),
        .CLK(CLK),
        .D(D),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADDR_WIDTH = "4" *) (* C_AINIT_VAL = "0" *) (* C_DEFAULT_DATA = "0" *) 
(* C_DEPTH = "32" *) (* C_ELABORATION_DIR = "./" *) (* C_HAS_A = "0" *) 
(* C_HAS_CE = "0" *) (* C_HAS_SCLR = "1" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_MEM_INIT_FILE = "no_coe_file_loaded" *) (* C_OPT_GOAL = "0" *) 
(* C_PARSER_TYPE = "0" *) (* C_READ_MIF = "0" *) (* C_REG_LAST_BIT = "1" *) 
(* C_SHIFT_TYPE = "0" *) (* C_SINIT_VAL = "0" *) (* C_SYNC_ENABLE = "0" *) 
(* C_SYNC_PRIORITY = "1" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "1" *) 
(* C_XDEVICEFAMILY = "zynq" *) (* ORIG_REF_NAME = "c_shift_ram_v12_0_12" *) (* downgradeipidentifiedwarnings = "yes" *) 
module c_shift_ram_0_c_shift_ram_v12_0_12
   (A,
    D,
    CLK,
    CE,
    SCLR,
    SSET,
    SINIT,
    Q);
  input [3:0]A;
  input [0:0]D;
  input CLK;
  input CE;
  input SCLR;
  input SSET;
  input SINIT;
  output [0:0]Q;

  wire CLK;
  wire [0:0]D;
  wire [0:0]Q;
  wire SCLR;

  (* C_AINIT_VAL = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_SYNC_ENABLE = "0" *) 
  (* C_SYNC_PRIORITY = "1" *) 
  (* C_WIDTH = "1" *) 
  (* c_addr_width = "4" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "32" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_a = "0" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_opt_goal = "0" *) 
  (* c_parser_type = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_last_bit = "1" *) 
  (* c_shift_type = "0" *) 
  (* c_verbosity = "0" *) 
  (* c_xdevicefamily = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  c_shift_ram_0_c_shift_ram_v12_0_12_viv i_synth
       (.A({1'b0,1'b0,1'b0,1'b0}),
        .CE(1'b0),
        .CLK(CLK),
        .D(D),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
PkyhyBb59EPgq8kANKUgNUvJSxwVgcYTKLlfXroHeM6zPnPHm+ATuJPY2OmCojZnDY2A6SHiMUmx
ylnsx6jVAA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
XgKClVpS+h3z22aTgNZepCZW5Yffl4m6nNLRjY88G0b6Og6dF7wA3of30X3Vr2BKX5GVSe+jeu6a
q3D7Qa0T3sEnO1qnWdbom/P31G6nS7/pQCPaLh+suxznQX2imRfhfTkmY1B9wExxZtZBbss2GPfs
EFGX8a+efiUiZLAKaSE=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
LYMHL9qwz9VPPAbHAyLFK1YM6t0YBJUbhdak6y3IQta7KscLfLakFo9QXv7rXKj3R5WEjx6Vg+9K
QUgoa/uCYy+n2t004DDpVeDamNuGIrJU3WXV9mo6tEi21Rm+kIG+CFgVuqLY9JSjwI3dhmEqYYtS
wC2GIO6hKaV0keq1ldvsRFBu71kLY+jczboTe6EddpUktWp3UM/RqnrSfHPMlZWhHp1k3YC0SDq9
gvcPn9DB3vIjXgn+xRbyzZOt/j+s8RfjF446i2RalkF5p/den9o/OMG5jmv4rZKHj9S1V3Z2UuL1
c2fxe26sNIvZ7tpz8RHVWRMloPfcPVakam2zhg==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BACIRg239ZSAZHpsLobWk7IZyWSAM1rsaZq5LesIgnba07iijhvT5s8WIOIIgHZs1XEDKelSnU1J
+5cyEbU9WgPZsja6FQEw6J0GuN3L/1QyrvmNIJKsNXINx7R+xaY/n0uby2eFsFE9luplvdOyrCEw
eK82BghXwPdasTT1ZUgKiycyGYtNsp5ZaPIWXI9ezN9oHowcWp7Mn6v2jrdDl4lzJuoHgqRtkZvG
7GqevJFheGfXkRPuQGkNK2Pk6XN9woSB1a9C+FUsQBM5MlIE7zrBQAjONIQj/nd82Hlp1H4PRxBW
1mmFP7PskMeNR2hH5xwkvg4Q3IfYBlw8gdzneg==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2017_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
vUWbACu3JL9XeVH21XChN1bLnACIM0U/dLRQNf2LGaDFNW9CL0o3SY9pOtV226o71+9Eal6i7P4l
ht62RU2AHTweJsgWkXtQBI0/jHIw4/gxbBebNbqZM6m3qjEE5blPsuzJ1njoX2JWCJElO3p9FfRu
uHpC+4hYoccdFayGku3vk1gwz9lLJ4FcYG9mi1vLIY+tzs0o83THQ8dLrg50Rr/r2n0Xf4hxWe4U
tJ6iUOYBQUYjeOwNQOOxfjv5PKfLIgGA2WC8sJb2GFe9MkTDoMAo40nBLK0Y8+klDIJTyx079Bx0
wdRg2JxUF3+TGlXW98+2/iWy94H1CPEVRm18FQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VX8rVAT0l4oniSvb1X0sblwaqcWh2XE0oCAZbC0SVv8fCy8dLmmtqBzFq3w2V/7nyMmJzWKNP/yV
0GW7ICEfrGaBejU3VpwaHA69xE56Y/8NSHGlZOhr390/5/UqELcFOknZEPJXMLpeKjUn2ijACn/u
O0myDIvGFiUyRGWWYKM=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
dlKAt52rb1rebbUvCxUw/pmWR03F+be3vApC1VuekYTvk7BFt7xopdHrqsvoU8rgaCBc2wuCudx5
nUcu7bKEyHKFc6bcbp6J84c2uG0ZckyqBn/OHRMbmq4Vbar8C3ERI2YmcbL0Q0fBLzMosVarF9eM
+c6VfE9hA5lx9qpwFJhgk5v/yx6kjgu+kEnG+xsdWrpKrj8LIxxh6gkrPOn+jQtKQSX3o7q35Rcv
W3vWLRYdH+pHsfJqCdT0wL4oBTLa7ozdsufX9l6UDgT4ECxLf7R1TtNj7XA1jaaefThL0F1AUCjF
5WuhMqBOotpDZUmvB91yVtbXLMm0r85tK9b/iA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
HJULnjLhR2pOqNBdYK80SVr+kn45JlGP9vbEUSPvjfGfREah31heWLU+CYpKo0X+j5TsvBJJd50L
iq0JVWbDWJaHr73dRa2iuk3+QSSzJ1zOHPyyyUavo2CjJxbfwhJ7vm9xdpnPDurAnm6KBNk5sDEh
SdcP+ugojE2noIBbJ5Bm+vi5Ll4TlUWqapTRr8Azm0iwQnYNNp4WvLs5mv3mVN1raj9+B3qCcuGj
VBiDvrgRq2jZXKmfpIYFetEzRXfFyig+pYy3icBt895a7M2Uw/+o5n3xo6EIv+6g0ILLoJscg7U9
VeLBIL1L2NoSR2EGREgixEWFjqcNuQDiML8Juw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
v+/zuhF8danyCsTo1wjDAww52z/g169/OFbN14aVQM8YBZkkNGGdoonH5JHFWMBhtYqJUpeblvY5
tuQgzpREazbEUXCzShA3ygJ+APMlRzQIaFPPtwt+lM6YYDSodjAD6/A2IRVMnJXPckPOzr9+aihR
x22ISx6mstC0ngFLeJrcQv0vTq2bE9zstWnjSG9/Z2kh9jk5pbposHIDiXQLqwO9W4/vAXvvIhij
Cvc0YzmacQxDHGvSfEbeQ/qazBt+yDtj6u9ApL+amAz9zvAxR02zwvDcBm2BQYrP2u2jXPsCuRGD
3X7+boqJQl7AprRaFmcIJc6ksvRAeTOdFdnQOA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 5552)
`pragma protect data_block
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
96qMqnCEQkI/hm30xKTpXKZIlE6ZOJ4=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
