module WBR3(WPSI3,DIN,resetn,CLK,READY,wse_inputs,hold_inputs,Core_READY,WPSO3,CoreIN_DIN);
input WPSI3;
input [7:0]DIN;
input resetn;
input CLK;
input READY;
//input ScanEnable;
//input HoldEnable;
input wse_inputs;
input hold_inputs;
output Core_READY;
output WPSO3;
output [7:0]CoreIN_DIN;//对应[7:0]DIN
wire [7:0]connect;
//wire CTO_READY;

//WC_SD1_COI ready(resetn,CLK,READY,WPSI3,wse_inputs,hold_inputs,Core_READY,CTO_READY);
WC_SD1_COI ready(resetn,CLK,READY,WPSI3,wse_inputs,hold_inputs,Core_READY,connect[0]);
/*
WC_SD1_COI ready(resetn,CLK,CFI,CTI,ScanEnable,HoldEnable,CFO,CTO);*/
               //WC_SF1_CII(resetn,CLK,CFI,   CTI,       ScanEnable,HoldEnable,CFO,CTO);

WC_SF1_CII DIN0(resetn,CLK,DIN[0],connect[0],wse_inputs,hold_inputs,CoreIN_DIN[0],connect[1]);
WC_SF1_CII DIN1(resetn,CLK,DIN[1],connect[1],wse_inputs,hold_inputs,CoreIN_DIN[1],connect[2]);
WC_SF1_CII DIN2(resetn,CLK,DIN[2],connect[2],wse_inputs,hold_inputs,CoreIN_DIN[2],connect[3]);
WC_SF1_CII DIN3(resetn,CLK,DIN[3],connect[3],wse_inputs,hold_inputs,CoreIN_DIN[3],connect[4]);
WC_SF1_CII DIN4(resetn,CLK,DIN[4],connect[4],wse_inputs,hold_inputs,CoreIN_DIN[4],connect[5]);
WC_SF1_CII DIN5(resetn,CLK,DIN[5],connect[5],wse_inputs,hold_inputs,CoreIN_DIN[5],connect[6]);
WC_SF1_CII DIN6(resetn,CLK,DIN[6],connect[6],wse_inputs,hold_inputs,CoreIN_DIN[6],connect[7]);
WC_SF1_CII DIN7(resetn,CLK,DIN[7],connect[7],wse_inputs,hold_inputs,CoreIN_DIN[7],WPSO3);
endmodule


