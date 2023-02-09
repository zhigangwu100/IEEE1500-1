module RAM_for_modify_test();

reg CLK;

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
Read=1;
Write=1;
CoreIN_ADDR=6'b101101;
CoreIN_DIN=8'b110010;
#100
Read =0;//高电平写入，低电平读出
Write=0;
#100
CoreIN_ADDR=6'b101101;
CoreIN_ADDR=6'b111011;
#100
CoreIN_ADDR=6'b100101;
CoreIN_ADDR=6'b110011;
#100
CoreIN_ADDR=6'b101101;


end


RAM_for_modify RAM_for_modify(Read,Write,CoreIN_ADDR,CoreIN_DIN,CoreIN_DOUT);
endmodule
