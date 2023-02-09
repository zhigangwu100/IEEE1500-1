module WBR_TOP(//此文件的电路属于unwrapped core外，
//一律使用resetn进行复位，不适用CoreIN_RESET信号，将其输出即可。
//此文件具备两路时钟，WBR_CLK和WRCK
wse_inputs,
wse_outputs,
hold_inputs,
hold_outputs,
WBR_CLK,//供WBR使用
wbr_si,
wir_wpp_bypass,
wir_wbr_concat,
WRCK,//仅供内部的bypass_segment（手册Figure 83）使用
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
BusDisable,
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
CoreOut,
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
wbr_so
);

//由于扫描链属于core内部，此代码不包含扫描链，把Figure77分为从上往下分为四个部分，分别实现。
input wse_inputs;
input wse_outputs;
input hold_inputs;
input hold_outputs;

//以下是第0部分需要用到的信号，有些信号是整体定义，后面三个部分也会用到。
input WBR_CLK;
input wir_wbr_concat;
input wir_wpp_bypass;
input WRCK;
input resetn;
input WPSE;
input wir_wpc;
input  [3:0]WPSI;
output [3:0]WPSO;
output wbr_so;
assign wbr_so=WPSO[0];
wire [3:0]mIN_out;
//wire mIN0_out;
//wire mIN1_out;
//wire mIN2_out;
//wire mIN3_out;

input CoreOut_MBISTDLOGOUT;
input CoreOut_MBISTFAIL;
input CoreOut_MBISTDone;
input CoreOut_BC;
input CoreOut_ACK;
/*
input CoreOut_RX;
input CoreOut_TX;
output RX;
output TX;
*/

output CoreIN_RX;
output CoreIN_TX;
input  RX;
input  TX;


input    BusDisable;
input    [5:0]ADDR;
output   [3:0]WBR_out;
output   MBISTDLOGOUT;
output   MBISTFAIL;
output   MBISTDONE;
output   BC;
output   ACK;

input  [3:0]CDR_out;//从Core内部的扫描链输出到外部的WBR_TOP中，因此相对于WBR_TOP而言是input
input  wir_extest;
wire   [3:0]mux_extest_out;
wire   [3:0]WBY_out;
//以上是第0部分需要用到的信号，有些信号是整体定义，后面三个部分也会用到。
input  [7:0]CoreOut;//CoreOut_DOUT
output [7:0]Dout;



//开始第0部分定义,由于TX、RX的关系，此处需要修改
WBR0 WBR0(wse_outputs,hold_outputs,resetn,WBR_CLK,mIN_out[0],CoreOut_MBISTDLOGOUT,CoreOut_MBISTFAIL,CoreOut_MBISTDone,CoreOut_BC,CoreOut_ACK,RX,TX,BusDisable,MBISTDLOGOUT,MBISTFAIL,MBISTDONE,BC,ACK,CoreIN_RX,CoreIN_TX,WBR_out[0]);
mux mIN0                (WPSI[0],          WPSO[1],   wir_wbr_concat,mIN_out[0]         );
mux mOUT0_bypass        (mux_extest_out[0],WBY_out[0],wir_wpp_bypass,WPSO[0]            );
mux mOUT0_extest        (CDR_out[0],       WBR_out[0],wir_extest,    mux_extest_out[0]  );
WBR_bypass_segment wby0 (mIN_out[0],         WPSE,      wir_wpc,resetn,WRCK,WBY_out[0]  );
//第0部分定义完成




//以下是第1部分定义

WBR1 WBR1                (resetn,WBR_CLK,mIN_out[1],wse_outputs,hold_outputs,CoreOut,WBR_out[1],Dout);
mux mIN1                 (WPSI[1],WPSO[2],wir_wbr_concat,mIN_out[1]);
mux mOUT1_bypass        (mux_extest_out[1],WBY_out[1],wir_wpp_bypass,WPSO[1]          );
mux mOUT1_extest        (CDR_out[1],       WBR_out[1],wir_extest,    mux_extest_out[1]);
WBR_bypass_segment wby1  (mIN_out[1],         WPSE,      wir_wpc,resetn,WRCK,WBY_out[1]  );

//以上是第1部分定义，注意每一部分定义中都会出现WBR_CLK和WRCK两路时钟

//以下是第2部分定义，注意每一部分定义中都会出现WBR_CLK和WRCK两路时钟
input MBISTDLOG;
input MBISTRUN;
input RESET;
output CoreIN_MBISTDLOG;
output CoreIN_MBISTRUN;
output [5:0]CoreIN_ADDR;//其实是四分之一条扫描链的ADDR对应的输出端
output CoreIN_RESET;//该信号不在这个文件中使用，用以对Core内电路的复位。
//output CoreIN_MBISTRUN;
WBR2 WBR2                (resetn,wse_inputs,hold_inputs,WBR_CLK,MBISTDLOG,MBISTRUN,ADDR,RESET,mIN_out[2],WBR_out[2],CoreIN_MBISTDLOG,CoreIN_MBISTRUN,CoreIN_ADDR,CoreIN_RESET,CoreIN_MBISTRUN,CoreIN_MBISTDLOG);
mux mIN2                 (WPSI[2],WPSO[3],wir_wbr_concat,mIN_out[2]);
mux mOUT2_bypass        (mux_extest_out[2],WBY_out[2],wir_wpp_bypass,WPSO[2]          );
mux mOUT2_extest        (CDR_out[2],       WBR_out[2],wir_extest,    mux_extest_out[2]);
WBR_bypass_segment wby2  (mIN_out[2],         WPSE,      wir_wpc,resetn,WRCK,WBY_out[2]  );
//以上是第2部分定义,注意每一部分定义中都会出现WBR_CLK和WRCK两路时钟






//以下是第3部分定义
//input WPSI3;
input [7:0]DIN;
input READY;
output Core_READY;
output [7:0]CoreIN_DIN; 
input wbr_si;
WBR3 WBR3(mIN_out[3],DIN,resetn,WBR_CLK,READY,wse_inputs,hold_inputs, Core_READY,WBR_out[3],CoreIN_DIN);
mux mIN3                 (WPSI[3],wbr_si,wir_wbr_concat,mIN_out[3]);
mux mOUT3_bypass        (mux_extest_out[3],WBY_out[3],wir_wpp_bypass,WPSO[3]          );
mux mOUT3_extest        (CDR_out[3],       WBR_out[3],wir_extest,    mux_extest_out[3]);
WBR_bypass_segment wby3  (mIN_out[3],         WPSE,      wir_wpc,resetn,WRCK,WBY_out[3]  );
 //以上是第3部分定义







endmodule
