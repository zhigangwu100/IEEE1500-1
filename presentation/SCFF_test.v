module SCFF_test();
reg LogicIN;
reg ScanIN;
reg se;
reg CLK;
reg resetn;

parameter FAST_PERIOD=20;
initial 
begin
#0 CLK=0;
forever
#(FAST_PERIOD/2)CLK=~CLK;
end


initial 
begin
#0 ScanIN=0;
forever
#(FAST_PERIOD)ScanIN=~ScanIN;
end


initial 
begin
#0 LogicIN=0;
forever
#(FAST_PERIOD*2)LogicIN=~LogicIN;
end


initial 
begin
#0
resetn=0;

#60
resetn=1;
se=0;

#600
se=1;
end


SCFF SCFF(LogicIN,ScanIN,se,CLK,resetn,Q);
endmodule