module WIR_shift_Register(wir_shift,wir_si,WRCK,resetn,wir_ir_decoding,wir_so);
input wir_shift;
input wir_si;
input WRCK;
input resetn;

output wir_ir_decoding;
output wir_so;

wire wir_so;
wire D;

mux mux(wir_so,wir_si,wir_shift,D);
DFF DFF (resetn,WRCK,D,wir_so);
assign wir_ir_deconding=wir_so;
endmodule
