module CDR(ScanChainIN,ScanChainOut,se,CLK,CoreIN_RESET);
input ScanChainIN;
output ScanChainOut;
input se;
//input SCANMODE;
input CLK;
input CoreIN_RESET;
wire [7:0]Q;
/*
SCFF scff0 (1'b0,ScanChainIN,SCANMODE,CLK,CoreIN_RESET,Q[0]);
SCFF scff1 (1'b0,Q[0],       SCANMODE,CLK,CoreIN_RESET,Q[1]);
SCFF scff2 (1'b0,Q[1],       SCANMODE,CLK,CoreIN_RESET,Q[2]);
SCFF scff3 (1'b0,Q[2],       SCANMODE,CLK,CoreIN_RESET,Q[3]);
SCFF scff4 (1'b0,Q[3],       SCANMODE,CLK,CoreIN_RESET,Q[4]);
SCFF scff5 (1'b0,Q[4],       SCANMODE,CLK,CoreIN_RESET,Q[5]);
SCFF scff6 (1'b0,Q[5],       SCANMODE,CLK,CoreIN_RESET,Q[6]);
SCFF scff7 (1'b0,Q[6],       SCANMODE,CLK,CoreIN_RESET,Q[7]);
*/
SCFF scff0 (1'b0,ScanChainIN,se,CLK,CoreIN_RESET,Q[0]);
SCFF scff1 (1'b0,Q[0],       se,CLK,CoreIN_RESET,Q[1]);
SCFF scff2 (1'b0,Q[1],       se,CLK,CoreIN_RESET,Q[2]);
SCFF scff3 (1'b0,Q[2],       se,CLK,CoreIN_RESET,Q[3]);
SCFF scff4 (1'b0,Q[3],       se,CLK,CoreIN_RESET,Q[4]);
SCFF scff5 (1'b0,Q[4],       se,CLK,CoreIN_RESET,Q[5]);
SCFF scff6 (1'b0,Q[5],       se,CLK,CoreIN_RESET,Q[6]);
SCFF scff7 (1'b0,Q[6],       se,CLK,CoreIN_RESET,Q[7]);
assign ScanChainOut=Q[7];
endmodule