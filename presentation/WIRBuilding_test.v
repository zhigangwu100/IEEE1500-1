module WIRBuilding_test();
reg wir_capture;
reg wir_shift;
reg wir_update;
reg WRCK;
reg resetn;
reg WRSTN;
reg WRCK_input;
wire wir_so;
wire wir_ctrl_output;

parameter FAST_PERIOD=20;
initial 
begin
WRCK=0;
forever
#(FAST_PERIOD/2)WRCK=~WRCK;
end


initial 
begin
WRCK_input=0;
forever
#(FAST_PERIOD)WRCK_input=~WRCK_input;
end


/////////////////////////////////////////////////////////////////

initial
begin
#20
WRSTN=1;
resetn=1;
wir_capture=0;
wir_shift=0;
wir_update=0;

#60
WRSTN=1;
resetn=1;
wir_capture=0;
wir_shift=1;
wir_update=1;
end

WIRBuilding w1(WRCK_input,wir_capture,wir_shift,wir_update,WRCK,resetn,WRSTN,wir_so,wir_ctrl_output);


endmodule
