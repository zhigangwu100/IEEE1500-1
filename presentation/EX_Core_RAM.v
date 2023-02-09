module EX_Core_RAM(Read,Write,CoreIN_ADDR,CoreIN_DIN,CoreIN_DOUT);

input  Read;//CoreIn_RX
input  Write;//CoreIn_TX
input  [5:0]CoreIN_ADDR;
input  [7:0]CoreIN_DIN;
output [7:0]CoreIN_DOUT;
/*2、reg变量在always块中有两种情况：

(1)、always后的敏感表中是（a or b or c）形式的，也就是不带时钟边沿的，综合出来还是组合逻辑

(2)、always后的敏感表中是（posedge clk）形式的，也就是带边沿的，综合出来一般是时序逻辑，会包含触发器（Flip－Flop）
*/
reg[7:0]CoreIN_DOUT;
reg[7:0]SRAM[0:255];//SRAM存储容量

 integer i; 
 initial 
 begin 
 for(i=0;i<=8'b11111111;i=i+1) 
 SRAM[i]= 8'b00000000; 
 end

always@(Read,Write,CoreIN_ADDR,CoreIN_DIN)
begin
 /* 
  if(!CoreIN_RESET ) //reset
    begin:rst
        integer i ;
       for(i=0 ;i< 256;i=i+1)
         SRAM[i] <=0 ;
      end
	  
else */
   if(Write==1'b1)//写数据,高电平写入，低电平读
   begin 
        if(Read==1'b1)
		SRAM[CoreIN_ADDR]<=CoreIN_DIN;
   end
   
   else if(Read==1'b0)//读数据
   begin
   if(Write==1'b0)
   CoreIN_DOUT<=SRAM[CoreIN_ADDR];
   end
   
   
end

endmodule