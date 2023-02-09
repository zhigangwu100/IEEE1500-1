module Wrapped_Core_WIR_WBY(//以Figure76和Figure110作为信号对照
SelectWIR,
UpdateWR,
ShiftWR,
CaptureWR,
WPSE,
resetn,
CLK,
WRCK,
WPSI,
WPSO,
WRSTN,
MBISTDLOGOUT,
MBISTFAIL,         
MBISTDONE,         
BC,
ACK,                
RX,              
TX,     
Dout,
MBISTDLOG,
MBISTRUN,
ADDR,
RESET,
DIN,
READY, 
WSO,
WSI
);
wire bus_disable;

input SelectWIR;

input  WSI;
output WSO;
input  resetn;
wire   wbr_si;//对于这个信号，待会要仔细查下前面的文件，看下是否与WPSI[0]一致。
assign wbr_si=WSI;

wire wbr_so;




//wire wir_wbr_concat;
wire wbr_concat;
input WRCK; 
input CLK;                 
input WPSE;
//wire wir_wpc;
input[3:0]WPSI;
output[3:0]WPSO;
wire wir_extest;              
output MBISTDLOGOUT;
output MBISTFAIL;         
output MBISTDONE;         
output BC;
output ACK;                
input RX;              
input TX;     
output [7:0]Dout;


input  MBISTDLOG;
input  MBISTRUN;
input  [5:0]ADDR;
input  RESET;
input  [7:0]DIN;
//以下是为了SAFE指令而特意增加

wire SAFE;

wire [5:0]ADDR_SAFE;
wire [7:0]DIN_SAFE;
wire [7:0]Dout_SAFE;
assign DIN_SAFE[7]=DIN[7]&(~SAFE);
assign DIN_SAFE[6]=DIN[6]&(~SAFE);
assign DIN_SAFE[5]=DIN[5]&(~SAFE);
assign DIN_SAFE[4]=DIN[4]&(~SAFE);
assign DIN_SAFE[3]=DIN[3]&(~SAFE);
assign DIN_SAFE[2]=DIN[2]&(~SAFE);
assign DIN_SAFE[1]=DIN[1]&(~SAFE);
assign DIN_SAFE[0]=DIN[0]&(~SAFE);

assign ADDR_SAFE[5]= ADDR[5]&(~SAFE);
assign ADDR_SAFE[4]= ADDR[4]&(~SAFE);
assign ADDR_SAFE[3]= ADDR[3]&(~SAFE);
assign ADDR_SAFE[2]= ADDR[2]&(~SAFE);
assign ADDR_SAFE[1]= ADDR[1]&(~SAFE);
assign ADDR_SAFE[0]= ADDR[0]&(~SAFE);

assign Dout[7]=Dout_SAFE[7]&(~SAFE);
assign Dout[6]=Dout_SAFE[6]&(~SAFE);
assign Dout[5]=Dout_SAFE[5]&(~SAFE);
assign Dout[4]=Dout_SAFE[4]&(~SAFE);
assign Dout[3]=Dout_SAFE[3]&(~SAFE);
assign Dout[2]=Dout_SAFE[2]&(~SAFE);
assign Dout[1]=Dout_SAFE[1]&(~SAFE);
assign Dout[0]=Dout_SAFE[0]&(~SAFE);


//以上是为了SAFE指令而特意增加



//DIN
input  READY; 

wire wir_wpc_for_figure103;
wire RESET;
//注意下面的函数调用中，有为WS_SAFE指令做相应的修改
EX_Core_with_Wrapper EX_Core_with_Wrapper(
resetn,
WRCK,
CLK,
WPSE,
WPSI,
WPSO,                
MBISTDLOGOUT,
MBISTFAIL,         
MBISTDONE,         
BC, 
ACK,                
RX,              
TX,     
Dout_SAFE,
MBISTDLOG,
MBISTRUN,
ADDR_SAFE,
RESET,
DIN_SAFE,
READY, //这个ready信号可以是计数器控制串行输入激励，激励准备就绪后输出的信号给READY



/////////以下是ＢＣ使用的信号,也是WBR使用的信号。
wbr_si,
wbr_concat,
wir_wpc_for_figure103,
wir_extest,

wby_shift,   
hold_outputs,
hold_inputs,
extest,
se,
wse_outputs,
wse_inputs,
scanmode,
mbistmode,
bus_disable,
wbr_concat,
wpp_bypass,
////////以上是ＢＣ使用的信号


wbr_so);


wire  wby_si;
assign wby_si=WSI;
//input WRCK;
//wire wby_shift;
//input resetn;
wire wby_so;
WBY WBY(wby_si,WRCK,wby_shift,resetn,wby_so);



wire wir_si;
assign wir_si=WSI;
//resetn;
//wir_shift;
//wir_update;
//wir_capture;
//WRCK;
input WRSTN;
//wire hold_outputs;
//wire hold_inputs;
//wire extest;
//wire se;
//wire wse_outputs;
//wire wse_inputs;
//wire scanmode;

//wire wbr_concat;
//wire wpp_bypass;
wire wir_so;
wire m1_out;
//mux m1(wby_so,wbr_so,wir_wbr_concat,m1_out);
mux m1(wby_so,wbr_so,wbr_concat,m1_out);
mux m2(m1_out,wir_so,SelectWIR,WSO);//根据Figure 110

//assign wir_wbr_concat=wbr_concat;
//input SelectWIR;
input UpdateWR;
input ShiftWR;
input CaptureWR;
//input WPSE;

WIR_Final WIR_Final(
WRCK,
WRSTN,
resetn,
wir_si,
wir_so,
SelectWIR,
UpdateWR,
ShiftWR,
CaptureWR,
WPSE,
wby_shift,
hold_outputs,
hold_inputs,
extest,
se,
wse_outputs,
wse_inputs,
scanmode,
mbistmode,
bus_disable,
wbr_concat,
wir_extest,
wpp_bypass,
wir_wpc_for_figure103,
SAFE
);
endmodule
