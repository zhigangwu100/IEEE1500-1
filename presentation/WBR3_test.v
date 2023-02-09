module WBR3_test();
reg WPSI3;
reg [7:0]DIN;
reg resetn;
reg CLK;
reg  READY;
reg wse_inputs;
reg hold_inputs;
wire Core_READY;
wire WPSO3;
wire [7:0]CoreIN_DIN;//对应[7:0]DIN


parameter FAST_PERIOD=20;
initial 
begin
#0 CLK=0;
forever
#(FAST_PERIOD/2)CLK=~CLK;
end

initial 
begin
#0 WPSI3=0;
forever
#(FAST_PERIOD)WPSI3=~WPSI3;
end


initial 
begin
#0
resetn=0;
wse_inputs=1;
hold_inputs=1;
#60
resetn=1;
end

WBR3 WBR3(WPSI3,DIN,resetn,CLK,READY,wse_inputs,hold_inputs,Core_READY,WPSO3,CoreIN_DIN);




endmodule
