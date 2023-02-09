module WIR_test();
parameter size=12;
reg [size:1]data_in;
reg load;
reg CLK;
reg clr;
reg shift_en;


reg resetn;
reg WRSTN;
reg wir_update;
reg wir_shift;
reg wir_capture;


wire data_out;
wire wir_so;

wire wir_wpc;
wire wir_hold_outputs;
wire wir_hold_inputs;
wire wir_intest;
wire wir_extest;
wire wir_shift_outputs;
wire wir_shift_inputs;
wire wir_scanmode;
wire wir_mbistmode;
wire wir_bus_disable;
wire wir_wbr_concat;
wire wir_wpp_bypass;



///////////////////统一移位寄存器和WIR的时钟为CLK,同时不对wir_si进行定义,直接用data_out代替wir_si来进行两个模块的连接///////////////////
parameter FAST_PERIOD=20;
initial 
begin
CLK=0;
forever
#(FAST_PERIOD/2)CLK=~CLK;
end
//////////////////////////////////////

initial
begin
#0  
data_in=12'b010010010010;
load=0;
clr=0;
shift_en=0;

WRSTN=0;
resetn=0;
wir_capture=0;
wir_update=0;
    //全方位清零复位

#40
data_in=12'b010010010010;
load=1;
clr=1;
shift_en=0;

WRSTN=1;
resetn=1;
wir_capture=0;
wir_shift=0;
wir_update=0;//对移位寄存器进行并行置数,读取指令操作码

#40
data_in=12'b010010010010;
load=0;
clr=1;
shift_en=1;

WRSTN=1;
resetn=1;
wir_capture=0;
wir_shift=1;
wir_update=0;//使用寄存器的移位功能,将指令逐步输送给WIR
  ////////////////到此为止,以上是移位寄存器准备就绪,已经读入操作码,准备开始移位输出至WIR,以上激励的定义分为两部分,第一部分是移位寄存器输入信号定义,第二部分是WIR的输入信号的定义,由于是12bit需要的读取时间至少为bit数*时钟周期长度/////////////////////
  
  #240
data_in=12'b010010010010;
load=0;
clr=1;
shift_en=0;

WRSTN=1;
resetn=1;
wir_capture=0;
wir_shift=0;
wir_update=1;
end
////////////////////////////////////

shifter_serial_input_parallel_output s1(data_in,load,CLK,clr,shift_en,data_out);
WIR w1(data_out,wir_so,CLK,wir_shift,wir_update,wir_capture,WRSTN,resetn,wir_wpc,wir_hold_outputs,wir_hold_inputs,wir_intest,wir_extest,wir_shift_outputs,wir_shift_inputs,wir_scanmode,wir_mbistmode,wir_bus_disable,wir_wbr_concat,wir_wpp_bypass);


////////////////////////////////////
endmodule