module WIR (
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
input wir_si;
input resetn;
input wir_shift;
input wir_update;
input wir_capture;
input WRCK;
input WRSTN;
output wir_wpc;
output wir_hold_outputs;
output wir_hold_inputs;
output wir_intest;
output wir_extest;
output wir_shift_outputs;
output wir_shift_inputs;
output wir_scanmode;
output wir_mbistmode;
output wir_bus_disable;
output wir_wbr_concat;
output wir_wpp_bypass;
output wir_so;
wire[11:1]connect;
WIRBuilding w1   (wir_si         ,wir_capture,wir_shift,wir_update,WRCK,resetn,WRSTN,connect[1],wir_wpc);
WIRBuilding w2   (connect[1] ,wir_capture,wir_shift,wir_update,WRCK,resetn,WRSTN,connect[2] ,   wir_hold_outputs);
WIRBuilding w3   (connect[2] ,wir_capture,wir_shift,wir_update,WRCK,resetn,WRSTN,connect[3] ,   wir_hold_inputs);
WIRBuilding w4   (connect[3] ,wir_capture,wir_shift,wir_update,WRCK,resetn,WRSTN,connect[4] ,   wir_intest);
WIRBuilding w5   (connect[4] ,wir_capture,wir_shift,wir_update,WRCK,resetn,WRSTN,connect[5] ,   wir_extest);
WIRBuilding w6   (connect[5] ,wir_capture,wir_shift,wir_update,WRCK,resetn,WRSTN,connect[6] ,   wir_shift_outputs);
WIRBuilding w7   (connect[6] ,wir_capture,wir_shift,wir_update,WRCK,resetn,WRSTN,connect[7] ,   wir_shift_inputs);
WIRBuilding w8   (connect[7] ,wir_capture,wir_shift,wir_update,WRCK,resetn,WRSTN,connect[8] ,   wir_scanmode);
WIRBuilding w9   (connect[8] ,wir_capture,wir_shift,wir_update,WRCK,resetn,WRSTN,connect[9] ,   wir_mbistmode);
WIRBuilding w10  (connect[9] ,wir_capture,wir_shift,wir_update,WRCK,resetn,WRSTN,connect[10],   wir_bus_disable);
WIRBuilding w11  (connect[10],wir_capture,wir_shift,wir_update,WRCK,resetn,WRSTN,connect[11],   wir_wbr_concat);
WIRBuilding w12  (connect[11],wir_capture,wir_shift,wir_update,WRCK,resetn,WRSTN,wir_so        ,wir_wpp_bypass);
endmodule