module Wrapped_Core_WIR_WBY_WSEXTEST_test();
parameter FAST_PERIOD=20;
parameter size=12;
reg SelectWIR;
reg UpdateWR;
reg ShiftWR;
reg CaptureWR;
reg WPSE;
reg resetn;
reg WRCK;
reg CLK;
reg[3:0]WPSI;
reg WRSTN;
reg RX;
reg TX;
reg MBISTDLOG;
reg MBISTRUN;
reg[5:0]ADDR;
reg RESET;
reg[7:0]DIN;
reg READY;
reg clr;
reg load;
reg shift_en;
reg [size-1:0]data_in;

wire [7:0]Dout;
wire [3:0]WPSO;


/////////////////////////////////以下是时钟定义//////////////////////
initial
begin
#0 CLK=0;
WPSE=1;
forever
#(FAST_PERIOD/2)CLK=~CLK;
end

initial 
begin
#0 WRCK=0;
WPSI=4'b0000;
forever
#(FAST_PERIOD/2)WRCK=~WRCK;
end
/////////////////////////////////以上是时钟定义//////////////////////


/*/////////////////////////以下是WPSI输入信号定义//////////////////
initial 
begin
#0 WPSI[3]=0;
forever
#(FAST_PERIOD)WPSI[3]=~WPSI[3];
end


initial 
begin
#0 WPSI[2]=0;
forever
#(FAST_PERIOD*2)WPSI[2]=~WPSI[2];
end

initial 
begin
#0 WPSI[1]=0;
forever
#(FAST_PERIOD*4)WPSI[1]=~WPSI[1];
end

initial 
begin
#0 WPSI[0]=0;
forever
#(FAST_PERIOD*8)WPSI[0]=~WPSI[0];
end

*//////////////////////////以上是WPSI输入信号定义//////////////////

initial
begin
#0
//以下是EX_EXTEST执行过程中不变化的信号
CaptureWR=0;
WPSE=0;
//WRCK前面已经定义
//CLK前面已经定义
//WPSI前面已经定义
RX=0;
TX=0;
MBISTDLOG=0;
MBISTRUN=0;
//ADDR=6'b110101;
//DIN=8'b10000101;
ADDR=6'b000000;
DIN=8'b00000000;
READY=0;
data_in=12'b010010010010;//WS_EXTEST的控制码

//以上是EX_EXTEST执行过程中不变化的信号

//以下是EX_EXTEST执行过程中变化的信号
SelectWIR=1;
UpdateWR=0;
ShiftWR=0;
//CaptureWR前面已经定义
resetn=0;
RESET=0;
WRSTN=0;
clr=0;
load=0;
shift_en=0;

#60
SelectWIR=1;
UpdateWR=0;
ShiftWR=1;
//CaptureWR前面已经定义
resetn=1;
//RESET=0;
WRSTN=0;
clr=1;
load=1;
shift_en=0;

#40
SelectWIR=1;
UpdateWR=0;
ShiftWR=1;
//CaptureWR前面已经定义
resetn=1;
//RESET=0;
WRSTN=0;
clr=1;
load=0;
shift_en=1;
#240

SelectWIR=1;
UpdateWR=1;
ShiftWR=0;
//CaptureWR前面已经定义
resetn=1;
//RESET=0;
WRSTN=1;
clr=1;
load=0;
shift_en=0;//至此，控制码传递完毕，接下来禁止WIR的更新，并且由WSI传递数据给WBY和WBR
#40
SelectWIR=0;
UpdateWR=0;
ShiftWR=0;
clr=1;
load=1;
shift_en=0;//再次读取数据，这里不一定要读取指令码，也可以是别的数据，这里只是为了验证数据的流通路径。

#40
SelectWIR=0;
UpdateWR=0;
ShiftWR=1;
clr=1;
load=0;
shift_en=1;//到此为止，数据应该可以通过WBR和WBY了。
//以上是EX_EXTEST执行过程中变化的信号

//下面开始测试互联
#1000
CaptureWR=1;
ShiftWR=0;//壳单元Capture模式
ADDR=6'b100001;
DIN=8'b10000001;
#40
CaptureWR=0;
ShiftWR=1;
#340
CaptureWR=1;
ShiftWR=1;
//壳单元Apply/Hold模式，把激励传送给下一个Core


end
//以下是调用子模块细节
Wrapped_Core_WIR_WBY w1(//以Figure76和Figure110作为信号对照
SelectWIR,
UpdateWR,
ShiftWR,
CaptureWR,
WPSE,
resetn,
CLK,
WRCK,
WPSI,
WPSO,
WRSTN,
MBISTDLOGOUT,
MBISTFAIL,         
MBISTDONE,         
BC,
ACK,                
RX,              
TX,     
Dout,
MBISTDLOG,
MBISTRUN,
ADDR,
RESET,
DIN,
READY, 
WSO,
WSI
);
shifter_serial_input_parallel_output s1(data_in,load,WRCK,clr,shift_en,WSI);
//以上是调用子模块细节

endmodule
