module WBR2(resetn,wse_inputs,hold_inputs,CLK,MBISTDLOG,MBISTRUN,ADDR,RESET,WPSI2,WPSO2,CoreIN_MBISTDLOG,CoreIN_MBISTRUN,CoreIN_ADDR,CoreIN_RESET,CoreIN_MBISTRUN,CoreIN_MBISTDLOG);
input wse_inputs;
input hold_inputs;
input CLK;
input MBISTDLOG;
input MBISTRUN;
input [5:0]ADDR;
input RESET;
input WPSI2;
input resetn;
output WPSO2;
output CoreIN_MBISTDLOG;
output CoreIN_MBISTRUN;
output [5:0]CoreIN_ADDR;
output CoreIN_RESET;
wire [7:0]WBR2_connect;
WC_SD1_COI     WBR_MBISTDLOG(resetn,CLK,MBISTDLOG,WBR2_connect[7],wse_inputs,hold_inputs,CoreIN_MBISTDLOG,WPSO2          );
WC_SD1_COI      WBR_MBISTRUN(resetn,CLK,MBISTRUN, WBR2_connect[6],wse_inputs,hold_inputs,CoreIN_MBISTRUN, WBR2_connect[7]);
WC_SF1_CII             ADDR5(resetn,CLK,ADDR[5],  WBR2_connect[5],wse_inputs,hold_inputs,CoreIN_ADDR[5],       WBR2_connect[6]);
WC_SF1_CII             ADDR4(resetn,CLK,ADDR[4],  WBR2_connect[4],wse_inputs,hold_inputs,CoreIN_ADDR[4],       WBR2_connect[5]);
WC_SF1_CII             ADDR3(resetn,CLK,ADDR[3],  WBR2_connect[3],wse_inputs,hold_inputs,CoreIN_ADDR[3],       WBR2_connect[4]);
WC_SF1_CII             ADDR2(resetn,CLK,ADDR[2],  WBR2_connect[2],wse_inputs,hold_inputs,CoreIN_ADDR[2],       WBR2_connect[3]);
WC_SF1_CII             ADDR1(resetn,CLK,ADDR[1],  WBR2_connect[1],wse_inputs,hold_inputs,CoreIN_ADDR[1],       WBR2_connect[2]);
WC_SF1_CII             ADDR0(resetn,CLK,ADDR[0],  WBR2_connect[0],wse_inputs,hold_inputs,CoreIN_ADDR[0],       WBR2_connect[1]);
WC_SD1_CII_O  WBR_cell_RESET(resetn,CLK,RESET,    WPSI2,          wse_inputs,hold_inputs,CoreIN_RESET,    WBR2_connect[0]);


endmodule


