module DFF_test();
reg CLK,resetn;
reg CLK_input;
wire Q;

parameter FAST_PERIOD=20;

initial 
begin
CLK=0;
forever
#(FAST_PERIOD/2)CLK=~CLK;
end

initial 
begin
CLK_input=0;
forever
#(FAST_PERIOD)CLK_input=~CLK_input;
end
/////////////////////////////////////////////////////

initial
begin
#0
resetn=0;
#50
resetn=1;
end


 DFF D1(resetn,CLK,CLK_input,Q);
 
 
 
 endmodule
