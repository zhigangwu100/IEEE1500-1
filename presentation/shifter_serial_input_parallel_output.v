module shifter_parallel_input_serial_output(data_in,load,clk,clr,shift_en,data_out);
parameter size=12;
input[size:1]data_in;
input load;
input clk;
input clr;
input shift_en;
output data_out;
reg data_out;
reg[size:1]shift_reg;


always@(posedge clk)
begin

if(!clr)
shift_reg=12'b0;
else if(load)
shift_reg=data_in;
else if(shift_en)
begin
shift_reg=shift_reg>>1;
shift_reg[size]=0;
end


data_out=shift_reg[1];

end 
endmodule