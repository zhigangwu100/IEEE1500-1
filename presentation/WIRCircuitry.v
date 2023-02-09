module WIRcircuitry(SelectWIR,UpdateWR,ShiftWR,CaptureWR,WPSE,wir_hold_outputs,wir_hold_inputs,wir_wpc,wir_intest,wir_extest,wir_shift_outputs,wir_shift_inputs,wir_scanmode,wir_mbistmode,wir_bus_disable,wir_wbr_concat,wir_wpp_bypass,wir_update,wir_shift,wir_capture,wby_shift,hold_outputs,hold_inputs,extest,se,wse_outputs,wse_inputs,scanmode,mbistmode,bus_disable,wbr_concat,wpp_bypass);
input SelectWIR;
input UpdateWR;
input ShiftWR;
input CaptureWR;
input WPSE;
////////////////////////////////////////
input wir_hold_outputs;
input wir_hold_inputs;

input wir_wpc;

input wir_intest;
input wir_extest;
input wir_shift_outputs;
input wir_shift_inputs;

input wir_scanmode;
input wir_mbistmode;
input wir_bus_disable;
input wir_wbr_concat;
input wir_wpp_bypass;
//////////////////////////////////
output wir_update;
output wir_shift;
output wir_capture;
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
////////////////////////////////////////
assign wir_update  =  SelectWIR & UpdateWR;
assign wir_shift      =  SelectWIR & ShiftWR;
assign wir_capture =  SelectWIR & CaptureWR;
assign wby_shift    =~SelectWIR & ShiftWR;
wire wby_shift;
wire m1_out;
wire m4_out;
wire nor1_out;
wire nor2_out;

wire wir_scanmode;
wire wir_mbistmode;
wire wir_bus_disable;
wire wir_wbr_concat;
wire wir_wpp_bypass;
wire hold_inputs_connect;
assign hold_inputs=hold_inputs_connect|((~wir_wpc)&(~wir_hold_outputs)&(wir_hold_inputs)&(wir_intest)&(wir_extest)&(~wir_shift_outputs)&(~wir_shift_inputs)&(wir_scanmode)&(~wir_mbistmode)&(wir_bus_disable)&(wir_wbr_concat)&(~wir_wpp_bypass));

mux m1 (~CaptureWR,       WPSE,  wir_wpc,   m1_out        );
mux m2 (wir_hold_outputs,m1_out,wir_intest,hold_outputs);
//mux m3 (wir_hold_inputs  ,m1_out,wir_extest,hold_inputs  );
mux m3 (wir_hold_inputs  ,m1_out,wir_extest,hold_inputs_connect);
mux m4 (wby_shift,            WPSE,   wir_wpc,   m4_out        );



assign nor1_out      = m4_out | wir_shift_outputs;
assign nor2_out      = m4_out | wir_shift_inputs;

assign extest =wir_extest;
assign se                = m4_out & ~wir_extest;
assign wse_outputs = nor1_out & wir_scanmode;
assign wse_inputs   = nor2_out & wir_scanmode;
assign scanmode    = wir_scanmode;
assign mbistmode  = wir_mbistmode;
assign bus_disable  = wir_bus_disable;
assign wbr_concat  = wir_wbr_concat;
assign wpp_bypass = wir_wpp_bypass;
 
endmodule