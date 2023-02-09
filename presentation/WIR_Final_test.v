module WIR_Final_test();
parameter size=12;
reg clr;
reg load;
reg shift_en;
reg resetn;
reg [size-1:0]data_in;
reg WRCK;
reg WRSTN;
reg SelectWIR;
reg UpdateWR;
reg ShiftWR;
reg CaptureWR;
reg WPSE;
wire wir_so;
wire hold_outputs;
wire hold_inputs;
wire extest;
wire se;
wire wse_outputs;
wire wse_inputs;
wire scanmode;
wire mbistmode;
wire bus_disable;
wire wbr_concat;
wire wpp_bypass;
wire data_out;


parameter FAST_PERIOD=20;
initial 
begin
WRCK=0;
forever
#(FAST_PERIOD/2)WRCK=~WRCK;
end


initial
begin
#0
WRSTN=0;                   //WIR的同步复位
resetn=0;                  //WIR的异步复位
clr=0;                     //移位寄存器的复位信号
SelectWIR=1;               //移位寄存器的复位信号
UpdateWR=1;                //移位寄存器的复位信号
ShiftWR=0;                 //移位寄存器的复位信号
CaptureWR=0;               //移位寄存器的复位信号
WPSE=1;                   
load=0;                   
shift_en=0;               
data_in=12'b010010010010;  //全局复位


#60
WRSTN=1;                  
resetn=1;                 
clr=1;                    
SelectWIR=1; 
UpdateWR=1;               
ShiftWR=0;                
CaptureWR=0;              
WPSE=1; //随意设置，此处只是为了确保WIRCircuitry输出正确
load=1;
shift_en=0;
data_in=12'b010010010010;//读取指令码


#40
//WRSTN=1;                  
//resetn=1;                 
//clr=1;                    
SelectWIR=1; 
UpdateWR=0;               
ShiftWR=1;  
shift_en=1;              
CaptureWR=0;              
WPSE=1; 
load=0; 
//data_in=12'b010010010010;

#240
SelectWIR=1; 
UpdateWR=1;         
CaptureWR=0;              
WPSE=1; 
load=0;
shift_en=0;
ShiftWR=0;
end







shifter_serial_input_parallel_output s1(data_in,load,WRCK,clr,shift_en,data_out);
WIR_Final w1(
WRCK,WRSTN,resetn,data_out,wir_so,SelectWIR,UpdateWR,ShiftWR,CaptureWR,WPSE,//输入
hold_outputs,hold_inputs,extest,se,wse_outputs,wse_inputs,scanmode,mbistmode,bus_disable,wbr_concat,wpp_bypass//输出
);


endmodule
