module WBR2_test();

//reg resetn
reg wse_inputs;
reg hold_inputs;
reg CLK;
reg MBISTDLOG;
reg MBISTRUN;
reg [5:0]ADDR;
reg resetn;
//reg RESET;
reg WPSI2;
wire WPSO2;
wire CoreIN_MBISTDLOG;
wire CoreIN_MBISTRUN;
wire [5:0]CoreIN_ADDR;
wire CoreIN_RESET;

parameter FAST_PERIOD=20;
initial 
begin
#0 CLK=0;
forever
#(FAST_PERIOD/2)CLK=~CLK;
end

initial 
begin
#0 WPSI2=0;
forever
#(FAST_PERIOD)WPSI2=~WPSI2;
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







WBR2 WBR2(resetn,wse_inputs,hold_inputs,CLK,MBISTDLOG,MBISTRUN,ADDR,resetn,WPSI2,WPSO2,//输入
CoreIN_MBISTDLOG,CoreIN_MBISTRUN,CoreIN_ADDR,CoreIN_RESET,CoreIN_MBISTRUN,CoreIN_MBISTDLOG);//输出







endmodule
