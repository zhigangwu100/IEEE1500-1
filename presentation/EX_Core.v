module EX_Core(ScanChainIN,ScanChainOut,SCANMODE,CLK,CoreIN_RESET,Address,DataOut);
//module CDR(ScanChainIN,ScanChainOut,SCANMODE,CLK,CoreIN_RESET);
input [5:0]Address;
input [7:0]DataOut;
/////////////////////////////////////
input  [3:0]ScanChainIN;
output [3:0]ScanChainOut;
input SCANMODE;
input CLK;
input CoreIN_RESET;


CDR CDR0(ScanChainIN[0],ScanChainOut[0],SCANMODE,CLK,CoreIN_RESET);
CDR CDR1(ScanChainIN[1],ScanChainOut[1],SCANMODE,CLK,CoreIN_RESET);
CDR CDR2(ScanChainIN[2],ScanChainOut[2],SCANMODE,CLK,CoreIN_RESET);
CDR CDR3(ScanChainIN[3],ScanChainOut[3],SCANMODE,CLK,CoreIN_RESET);
/////////////////////////////////////

EX_Core_ROM EX_Core_ROM(Address,DataOut);
//input [7:0]Address;
//output[7:0]DataOut;
/////////////////////////////////////


/////////////////////////////////////
endmodule
