module WIR_Final(
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
output wir_extest;
output wir_wpc_for_figure103;








//以下是WIR.v的输入，WIRCircuitry.v的输出。      
wire wir_update;                                 
wire wir_shift;                                  
wire wir_capture;
//以下用来连接WIR.v
wire wir_hold_outputs;
wire wir_hold_inputs;
wire wir_wpc;
assign wir_wpc_for_figure103=wir_wpc;
wire wir_intest;
wire wir_extest;
wire wir_shift_outputs;
wire wir_shift_inputs;
wire wir_scanmode;
wire wir_mbistmode;
wire wir_bus_disable;
wire wir_wbr_concat;
wire wir_wpp_bypass;
//以上用来连接WIR.v

//其余信号汇总
input WRCK;
input WRSTN;
input resetn;
input wir_si;
output wir_so;


//以下是关于WIRCircuitry.v
input SelectWIR;
input UpdateWR;
input ShiftWR;
input CaptureWR;
input WPSE;
////////////////////////////////////////
//input wir_hold_outputs;
//input wir_hold_inputs;
//input wir_wpc;
//input wir_intest;
//input wir_extest;
//input wir_shift_outputs;
//input wir_shift_inputs;
//input wir_scanmode;
//input wir_mbistmode;
//input wir_bus_disable;
//input wir_wbr_concat;
//input wir_wpp_bypass;
//output wir_update;
//output wir_shift;
//output wir_capture;
output wby_shift;
output hold_outputs;
output hold_inputs;
output extest;
output se;
output wse_outputs;
output wse_inputs;
output scanmode;
output mbistmode;
output bus_disable;
output wbr_concat;
output wpp_bypass;
WIRcircuitry WIRcircuitry(SelectWIR,UpdateWR,ShiftWR,CaptureWR,WPSE,wir_hold_outputs,wir_hold_inputs,wir_wpc,wir_intest,wir_extest,wir_shift_outputs,wir_shift_inputs,wir_scanmode,wir_mbistmode,wir_bus_disable,wir_wbr_concat,wir_wpp_bypass,wir_update,wir_shift,wir_capture,wby_shift,hold_outputs,hold_inputs,extest,se,wse_outputs,wse_inputs,scanmode,mbistmode,bus_disable,wbr_concat,wpp_bypass);


WIR WIR(
wir_si,
wir_so,
WRCK,
wir_shift,
wir_update,
wir_capture,
WRSTN,
resetn,
wir_wpc,
wir_hold_outputs,
wir_hold_inputs,
wir_intest,
wir_extest,
wir_shift_outputs,
wir_shift_inputs,
wir_scanmode,
wir_mbistmode,
wir_bus_disable,
wir_wbr_concat,
wir_wpp_bypass);






//以下是为了SAFE指令而特意增加
output SAFE;
assign SAFE=(~wir_wpc)&(wir_hold_outputs)&(wir_hold_inputs)&(~wir_intest)&(~wir_extest)&(~wir_shift_outputs)&(~wir_shift_inputs)&(~wir_scanmode)&(~wir_mbistmode)&(wir_bus_disable)&(~wir_wbr_concat)&(~wir_wpp_bypass);
//以上是为了SAFE指令而特意增加

endmodule
