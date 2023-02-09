module  WIR_update_Register (WRSTN,wir_update,WRCK,wir_ir_decoding,wir_ctrl_output);
input WRSTN;
input wir_update;
input WRCK;
input wir_ir_decoding;
output wir_ctrl_output;

wire D;
mux mux(wir_ctrl_output,wir_ir_decoding,wir_update,D);
DFF DFF(WRSTN,~WRCK,D,wir_ctrl_output);

endmodule