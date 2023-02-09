module EX_Core_Final(ScanChainIN,ScanChainOut,se,CoreIN_CLK,CoreIN_RESET,CoreIN_RX,CoreIN_TX,CoreIN_ADDR,CoreIN_DIN,CoreOUT_DOUT);
input  [3:0]ScanChainIN;
output [3:0]ScanChainOut;
//input SCANMODE;
input se;
input CoreIN_CLK;//unwrapped Core“内部的全局时钟”
input CoreIN_RESET;
/*
CDR CDR0(ScanChainIN[0],ScanChainOut[0],SCANMODE,CoreIN_CLK,CoreIN_RESET);
CDR CDR1(ScanChainIN[1],ScanChainOut[1],SCANMODE,CoreIN_CLK,CoreIN_RESET);
CDR CDR2(ScanChainIN[2],ScanChainOut[2],SCANMODE,CoreIN_CLK,CoreIN_RESET);
CDR CDR3(ScanChainIN[3],ScanChainOut[3],SCANMODE,CoreIN_CLK,CoreIN_RESET);
*/

CDR CDR0(ScanChainIN[0],ScanChainOut[0],se,CoreIN_CLK,CoreIN_RESET);
CDR CDR1(ScanChainIN[1],ScanChainOut[1],se,CoreIN_CLK,CoreIN_RESET);
CDR CDR2(ScanChainIN[2],ScanChainOut[2],se,CoreIN_CLK,CoreIN_RESET);
CDR CDR3(ScanChainIN[3],ScanChainOut[3],se,CoreIN_CLK,CoreIN_RESET);


input CoreIN_RX;//Read
input CoreIN_TX;//Write
input [5:0]CoreIN_ADDR;
input [7:0]CoreIN_DIN;
output[7:0]CoreOUT_DOUT;
EX_Core_RAM EX_Core_RAM(CoreIN_RX,CoreIN_TX,CoreIN_ADDR,CoreIN_DIN,CoreOUT_DOUT);
endmodule



