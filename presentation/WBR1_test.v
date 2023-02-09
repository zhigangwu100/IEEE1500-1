module WBR1_test();

reg resetn;
reg CLK;
reg WPSI1;
//input ScanEnable;
//input HoldEnable;
reg wse_outputs;
reg hold_outputs;
reg [7:0]CoreOut;
wire WPSO1;
wire [7:0]Dout;

parameter FAST_PERIOD=20;
initial 
begin
#0 CLK=0;
forever
#(FAST_PERIOD/2)CLK=~CLK;
end

initial 
begin
#0 WPSI1=0;
forever
#(FAST_PERIOD)WPSI1=~WPSI1;
end

initial 
begin
#0
resetn=0;
 wse_outputs=1;
hold_outputs=1;
#60
resetn=1;
end



WBR1  WBR1(resetn,CLK,WPSI1,wse_outputs,hold_outputs,CoreOut,WPSO1,Dout);


endmodule
