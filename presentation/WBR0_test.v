module WBR0_test();
reg resetn;
reg CLK;
reg WPSI0;
reg CoreOut_MBISTDLOGOUT;
reg CoreOut_MBISTFAIL;
reg CoreOut_MBISTDone;
reg CoreOut_BC;
reg CoreOut_ACK;
//以下是与书本不同的修改的地方
//input CoreOut_RX;
//input CoreOut_TX;
wire CoreIn_RX;
wire CoreIn_TX;
//以上是与书本不同的修改的地方
reg BusDisable;
wire MBISTDLOGOUT;
wire MBISTFAIL;
wire MBISTDONE;
wire BC;
wire ACK;
/////以下是与书本不同的修改的地方
//output RX;
//output TX;
reg RX;
reg TX;
/////以上是与书本不同的修改的地方

//input ScanEnable;
//input HoldEnable;
reg wse_outputs;
reg hold_outputs;
reg [7:0]CoreOut;
wire WPSO0;
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
#0 WPSI0=0;
forever
#(FAST_PERIOD)WPSI0=~WPSI0;
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



initial
begin
#0
CoreOut_MBISTDLOGOUT=1;
CoreOut_MBISTFAIL=1;
CoreOut_MBISTDone=1;
CoreOut_BC=1;
CoreOut_ACK=1;
BusDisable=1;
CoreOut=8'b00000000;
end



WBR0 WBR0(wse_outputs,hold_outputs,resetn,CLK,WPSI0,CoreOut_MBISTDLOGOUT,CoreOut_MBISTFAIL,CoreOut_MBISTDone,CoreOut_BC,CoreOut_ACK,RX,TX,BusDisable,MBISTDLOGOUT,MBISTFAIL,MBISTDONE,BC,ACK,CoreIn_RX,CoreIn_TX,WPSO0);



endmodule
