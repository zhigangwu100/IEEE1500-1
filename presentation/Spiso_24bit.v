module spiso_24bit(data_in,load,clk,clr,shift_en,data_out);
parameter size=24;
input[size:1]data_in;
input load;
input clk;
input clr;
input shift_en;
output data_out;
reg data_out;
reg[size:1]shift_reg;


always@(posedge clk)

  
if(!clr)
  begin
shift_reg=24'b000000000000000000000000;
data_out=1'b0;
end
else 
begin
if(load)
shift_reg=data_in;

else if(shift_en)
begin
data_out=shift_reg[1];//这句话放在这里是只在允许移位时才对接口进行赋值,缺点是data_out状态不定，不定态会进入Wrapped Core。
shift_reg=shift_reg>>1;
shift_reg[size]=0;
end
end

//data_out=shift_reg[1];//这句话放在这里是只在随时可以对接口进行赋值，缺点是会导致在未准许移位时，数据已经进入wrapped Core

endmodule
