module WIRBuilding(wir_si,wir_capture,wir_shift,wir_update,WRCK,resetn,WRSTN,wir_so,wir_ctrl_output);
input wir_si;
input wir_capture;
input wir_shift;
input wir_update;
input WRCK;
input resetn;
input WRSTN;
output wir_so;
output wir_ctrl_output;

wire wir_so;
wire wir_ctrl_output;
wire mx2out;
wire D1;
wire D2;


mux mux1 (mx2out,wir_si,wir_shift,D1);
mux mux2 (wir_so,wir_ctrl_output,wir_capture,mx2out);
mux mux3 (wir_ctrl_output,wir_so,wir_update,D2);
DFF DFF1(resetn,WRCK,D1,wir_so);
DFF2 DFF2(WRSTN,WRCK,D2,wir_ctrl_output);

endmodule