module EX_Core_with_Wrapper(
resetn,
WRCK,
CLK,
WPSE,
WPSI,
WPSO,                
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
READY, //这个ready信号可以是计数器控制串行输入激励，激励准备就绪后输出的信号给READY



/////////以下是ＢＣ使用的信号,也是WBR使用的信号。
wbr_si,
wir_wbr_concat,
wir_wpc,
wir_extest,

wby_shift,   
hold_outputs,
hold_inputs,
extest,
se,
wse_outputs,
wse_inputs,
scanmode,
mbistmode,
bus_disable,
wbr_concat,
wpp_bypass,
////////以上是ＢＣ使用的信号


wbr_so
);
/////////以下是ＢＣ使用的信号,也是WBR使用的信号。
input RESET;
input wbr_si;
input wir_wbr_concat;
input wir_wpc;
input wir_extest;

input wby_shift;   //理想化处理
input hold_outputs;
input hold_inputs;
input extest;
input se;//注意与scanmode的配合
input wse_outputs;
input wse_inputs;
input scanmode;//注意与se的配合
input mbistmode;
input bus_disable;
input wbr_concat;
input wpp_bypass;


////////以上是ＢＣ使用的信号






//注意这个verilog文件需要加入时钟选择单元，不要忽略！
//这个verilog文件的目的是整合WBR_TOP.v和EX_Core_RAM.v,以便形成最终的顶层文件
//暂时没有设想MBIST的问题。
//另外想清楚不同的复位信号，resetn以及RESET，
//注意MBIST的地方需要添加RAM
//要搞清楚不同的时钟，不要混淆！
////////////////////////WBR_TOP总共40个输入输出信号///以下是WBR_top部分//////////
//这一行需要起名字和修改端口列表，WBR_TOP在此处作为被调用单元
//以下是WBR_top.v的所有输入输出端口，想清楚哪些input和哪些output需要修改为wire，用来和EX_Core_FINal.v确立连接关系。

input resetn;
wire RESET;
//assign RESET=resetn;
//以下是为了调用WBR_TOP.v，对相关的信号的声明和信号性质（wire,input,output）的修改

//input WBR_CLK;//其余信号
//input wbr_si;
//input wir_wbr_concat;
input WRCK;   
input CLK;       
//input resetn;
input WPSE;
//input wir_wpc;
input [3:0]WPSI;           //注意这里的WPSI不是Figure77中的WPSI，而是Figure102的WPSI，Figure102中还有复用器
output [3:0]WPSO;           //注意这里的WPSO不是Figure77中的WPSO，而是Figure102的WPSO，Figure102中还有复用器
output wbr_so;
assign wbr_so=WPSO[0];
wire  [3:0]WBR_out;
wire  [3:0]CDR_out;        //扫描链输出端
//input wir_extest;
//以上是为了调用WBR_TOP.v，对相关的信号的声明和信号性质（wire,input,output）的修改

wire   CoreIN_CLK;
///以下是全局时钟布置
mux muxforClock (CLK,WRCK,wir_wbr_concat,CoreIN_CLK);
///以上是全局时钟布置

///////////以下是为了调用WBR_TOP.v，对相关的信号的声明和信号性质（wire,input,output）的修改
//************************以下是 WBR0的15个相关信号******
//input     BusDisable;           //Figure 77 WBR0左侧，这个作为此verilog文件的输入，作为此文件和指令寄存器之间的wire连接线即可，根据真值表可知，直接由指令寄存器来控制。
wire      CoreOut_MBISTDLOGOUT; //Figure 77 WBR0左侧
wire      CoreOut_MBISTFAIL;    //Figure 77 WBR0左侧
wire      CoreOut_MBISTDone;    //Figure 77 WBR0左侧
wire      CoreOut_BC;           //Figure 77 WBR0左侧
wire      CoreOut_ACK;          //Figure 77 WBR0左侧
wire      CoreIN_RX;            //Figure 77 WBR0左侧
wire      CoreIN_TX;            //Figure 77 WBR0左侧
output    MBISTDLOGOUT;         //Figure 77 WBR0右侧
output    MBISTFAIL;            //Figure 77 WBR0右侧
output    MBISTDONE;            //Figure 77 WBR0右侧
output    BC;                   //Figure 77 WBR0右侧
output    ACK;                  //Figure 77 WBR0右侧
input     RX;                   //Figure 77,ram的读信号, WBR0右侧
input     TX;                   //Figure 77,ram的写信号, WBR0右侧
//**********以上是WBR0的15个相关信号******
//********以下是WBR1的2个相关信号
wire [7:0]CoreOut_DOUT;          //Figure 77 WBR1左侧
output [7:0]Dout;                //Figure 77 WBR1右侧
//*******以上是WBR1的2个相关信号
//********以下是WBR2的8个相关信号
input  MBISTDLOG;                 //Figure 77 WBR2左侧
input  MBISTRUN;                  //Figure 77 WBR2左侧
input  [5:0]ADDR;                 //Figure 77 WBR2左侧
//input  RESET;                     //Figure 77 WBR2左侧
wire   CoreIN_MBISTDLOG;          //Figure 77 WBR2右侧
wire   CoreIN_MBISTRUN;           //Figure 77 WBR2右侧

//以下是对MBIST的理想化处理
assign CoreIN_MBISTDLOG    =1'b0;    //理想化处理
assign CoreIN_MBISTRUN     =1'b0;     //理想化处理
assign CoreOut_MBISTDLOGOUT=1'b0;//理想化处理
assign CoreOut_MBISTFAIL   =1'b0;   //理想化处理
assign CoreOut_MBISTDone   =1'b0;   //理想化处理
assign CoreOut_ACK         =1'b0;         //理想化处理
assign CoreOut_BC          =1'b0; 
//assign CoreOut_BC=(~wby_shift)&(~hold_outputs)&(~extest)&(~se)&(~wse_outputs)&(~wse_inputs)&(~scanmode)&(~mbistmode)&(~bus_disable)&(~wbr_concat)&(~wpp_bypass);

//以上是对MBIST的理想化处理    


wire  [5:0]CoreIN_ADDR;      //Figure 77 WBR2右侧
wire  CoreIN_RESET;          //Figure 77 WBR2右侧
//*********以上是WBR2的8个相关信号

//*******以下是WBR3的4个相关信号
input [7:0]DIN;              //Figure 77 WBR3左侧
input READY;                 //Figure 77 WBR3左侧
wire  Core_READY;            //Figure 77 WBR3右侧
wire  [7:0]CoreIN_DIN;       //Figure 77 WBR3右侧
//*******以上是WBR3的4个相关信号
///////////以上是为了调用WBR_TOP.v，对相关的信号的声明和信号性质（wire,input,output）的修改






WBR_TOP WBR_TOP(
wse_inputs,
wse_outputs,
hold_inputs,
hold_outputs,
CoreIN_CLK,
wbr_si,
wpp_bypass,
wir_wbr_concat,
WRCK,
resetn,
WPSE,
wir_wpc,
WPSI,
WPSO,
CoreOut_MBISTDLOGOUT,
CoreOut_MBISTFAIL,
CoreOut_MBISTDone,
CoreOut_BC,
CoreOut_ACK,
RX,
TX,
bus_disable,
ADDR,
WBR_out,
MBISTDLOGOUT,
MBISTFAIL,
MBISTDONE,
BC,
ACK,
CoreIN_RX,
CoreIN_TX,
CDR_out,
wir_extest,
CoreOut_DOUT,
Dout,
MBISTDLOG,
MBISTRUN,
RESET,
CoreIN_MBISTDLOG,
CoreIN_MBISTRUN,
CoreIN_ADDR,
CoreIN_RESET,
DIN,
READY,
Core_READY,
CoreIN_DIN,
wbr_so);//子模块调用
////////////////////////WBR_TOP总共41个输入输出信号///以上是WBR_top部分的修改//////////
//以下是EX_Core_FINal.v的所有输入输出端口，想清楚哪些INput和哪些output需要修改为wire，用来和WBR_TOP.v确立连接关系。

//wire [3:0]ScanChaININ;
//wire [3:0]ScanChaINOut;






///////////////以下是为了调用EX_Core_Final.v，对相关的信号的声明和信号性质（wire,input,output）的修改
//wire  [3:0]WBR_out;  前面已经定义过，为了提高代码可读性，这里重新以注释形式出现 
//wire  [3:0]CDR_out;  前面已经定义过，为了提高代码可读性，这里重新以注释形式出现 
//input SCANMODE;
//input se;
//wire CoreIN_CLK;     前面已经定义过，为了提高代码可读性，这里重新以注释形式出现
//wire CoreIN_RESET;   前面已经定义过，为了提高代码可读性，这里重新以注释形式出现
//wire CoreIN_RX;      前面已经定义过，为了提高代码可读性，这里重新以注释形式出现
//wire CoreIN_TX;      前面已经定义过，为了提高代码可读性，这里重新以注释形式出现
//wire [7:0]CoreIN_DIN;前面已经定义过，为了提高代码可读性，这里重新以注释形式出现
//wire [7:0]CoreOut_DOUT;
//EX_Core_Final EX_Core_Final (WBR_out,CDR_out,SCANMODE,CoreIN_CLK,CoreIN_RESET,CoreIN_RX,CoreIN_TX,CoreIN_ADDR,CoreIN_DIN,CoreOut_DOUT);//子模块调用
wire [3:0]ScanChainIN;
wire [3:0]ScanChainOut;
assign ScanChainIN[3]=WBR_out[3]&scanmode;
assign ScanChainIN[2]=WBR_out[2]&scanmode;
assign ScanChainIN[1]=WBR_out[1]&scanmode;
assign ScanChainIN[0]=WBR_out[0]&scanmode;
assign CDR_out[3]=scanmode&ScanChainOut[3];
assign CDR_out[2]=scanmode&ScanChainOut[2];
assign CDR_out[1]=scanmode&ScanChainOut[1];
assign CDR_out[0]=scanmode&ScanChainOut[0];

EX_Core_Final EX_Core_Final (ScanChainIN,ScanChainOut,se_and_out,CoreIN_CLK,CoreIN_RESET,CoreIN_RX,CoreIN_TX,CoreIN_ADDR,CoreIN_DIN,CoreOut_DOUT);//子模块调用
assign se_and_out=scanmode&se;
//module EX_Core_Final(ScanChainIN,ScanChainOut,se,CoreIN_CLK,CoreIN_RESET,CoreIN_RX,CoreIN_TX,CoreIN_ADDR,CoreIN_DIN,CoreOUT_DOUT);

///////////////以上是为了调用EX_Core_Final.v，对相关的信号的声明和信号性质（wire,input,output）的修改

endmodule



//想清楚CLK,RESET、resetn、WRSTN的问题，
//对EX_Core_Final以及WBR_TOP进行正确的调用，然后考虑好MBIST问题。


//先设置好MBIST,理想化处理，然后处理WRSTN以及resetn=>RESET=>CoreIN_RESET

// 考虑如下：
// 对于Core内部的复位，一律使用RESET进行低电平异步复位，需要检查的文件RAM CDR、final文件

