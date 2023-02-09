module mux (a0,a1,s,y);
input a0,a1;
input s;
output y;
assign       y=s?a1:a0;
endmodule
