module WBR_bypass_segment(WPSI,WPSE,wir_wpc,resetn,WRCK,WPSO);
input WPSI;
input WPSE;
input wir_wpc;
input WRCK;
input resetn;
output WPSO;
wire WPSO;
wire and_out;
wire D;
mux mux_for_bypass(WPSO,WPSI,and_out,D);
DFF DFF_for_bypass(resetn,WRCK,D,WPSO);
and AND(and_out,WPSE,wir_wpc);
endmodule
