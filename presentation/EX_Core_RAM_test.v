module EX_Core_RAM_test();
reg CLK;
reg CoreIN_RESET;

parameter FAST_PERIOD=20;
initial 
begin
#0 CLK=0;
forever
#(FAST_PERIOD/2)CLK=~CLK;
end


reg Read;//CoreIn_RX
reg Write;//CoreIn_TX
reg [5:0]CoreIN_ADDR;
reg [7:0]CoreIN_DIN;
wire[7:0]CoreIN_DOUT;

initial
begin
#0
CoreIN_RESET=1;
Read=1;
Write=1;
CoreIN_ADDR=6'b101101;
CoreIN_DIN=8'b110010;
#100
Read =0;
Write=0;
#100
CoreIN_RESET=0;
CoreIN_ADDR=6'b101101;
CoreIN_ADDR=6'b101111;

end


EX_Core_RAM EX_Core_RAM(CoreIN_RESET,Read,Write,CoreIN_ADDR,CoreIN_DIN,CoreIN_DOUT);


endmodule
