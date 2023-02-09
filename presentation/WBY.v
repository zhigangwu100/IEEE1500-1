module WBY(wby_si,WRCK,wby_shift,resetn,wby_so);
input wby_si;
input WRCK;
input wby_shift;
input resetn;

output wby_so;


wire D;
wire wby_so;
 
mux muxforwby (wby_so,wby_si,wby_shift,D);
DFF DFF(resetn,WRCK,D,wby_so);

endmodule
