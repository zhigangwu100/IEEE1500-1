module WBR0(wse_outputs,hold_outputs,resetn,CLK,WPSI0,CoreOut_MBISTDLOGOUT,CoreOut_MBISTFAIL,CoreOut_MBISTDone,CoreOut_BC,CoreOut_ACK,RX,TX,BusDisable,MBISTDLOGOUT,MBISTFAIL,MBISTDONE,BC,ACK,CoreIn_RX,CoreIn_TX,WPSO0);
input wse_outputs;
input hold_outputs;
input resetn;
input CLK;
input WPSI0;
input CoreOut_MBISTDLOGOUT;
input CoreOut_MBISTFAIL;
input CoreOut_MBISTDone;
input CoreOut_BC;
input CoreOut_ACK;
//以下是与书本不同的修改的地方
//input CoreOut_RX;
//input CoreOut_TX;
output CoreIn_RX;
output CoreIn_TX;
//以上是与书本不同的修改的地方
input BusDisable;
output MBISTDLOGOUT;
output MBISTFAIL;
output MBISTDONE;
output BC;
output ACK;
/////以下是与书本不同的修改的地方
//output RX;
//output TX;
input RX;
input TX;
/////以上是与书本不同的修改的地方

output WPSO0;
wire MBISTDLOGOUT_MBISTFAIL;
wire MBISTFAIL_MBISTDONE;
wire MBISTDONE_BC;
wire BC_ACK;
wire ACK_RX;
wire RX_TX;
//WC_SD1_COI   WBR0_MBISTDLOGOUT (resetn,CLK,CoreOut_MBISTDLOGOUT, MBISTDLOGOUT_MBISTFAIL,ScanEnable,HoldEnable,           MBISTDLOGOUT,WPSO0                 );
//WC_SD1_COI   WBR0_MBISTFAIL    (resetn,CLK,CoreOut_MBISTFAIL,    MBISTFAIL_MBISTDONE   ,ScanEnable,HoldEnable,           MBISTFAIL,   MBISTDLOGOUT_MBISTFAIL);
//WC_SD1_COI   WBR0_MBISTDONE    (resetn,CLK,CoreOut_MBISTDone,    MBISTDONE_BC,          ScanEnable,HoldEnable,           MBISTDONE,   MBISTFAIL_MBISTDONE);
//WC_SD1_COI_G WBR0_BC           (resetn,CLK,CoreOut_BC,           BC_ACK,                ScanEnable,HoldEnable,BusDisable,BC,          MBISTDONE_BC);
//WC_SF1_CII   WBR0_ACK          (resetn,CLK,CoreOut_ACK,          ACK_RX,                ScanEnable,HoldEnable,           ACK,         BC_ACK);
//WC_SF1_CII   WBR0_RX           (resetn,CLK,RX,                   RX_TX,                 ScanEnable,HoldEnable,           CoreIn_RX,   ACK_RX);
//WC_SF1_CII   WBR0_TX           (resetn,CLK,TX,                   WPSI0,                 ScanEnable,HoldEnable,           CoreIn_TX,   RX_TX);



WC_SD1_COI   WBR0_MBISTDLOGOUT (resetn,CLK,CoreOut_MBISTDLOGOUT, MBISTDLOGOUT_MBISTFAIL,wse_outputs,hold_outputs,           MBISTDLOGOUT,WPSO0                 );
WC_SD1_COI   WBR0_MBISTFAIL    (resetn,CLK,CoreOut_MBISTFAIL,    MBISTFAIL_MBISTDONE   ,wse_outputs,hold_outputs,           MBISTFAIL,   MBISTDLOGOUT_MBISTFAIL);
WC_SD1_COI   WBR0_MBISTDONE    (resetn,CLK,CoreOut_MBISTDone,    MBISTDONE_BC,          wse_outputs,hold_outputs,           MBISTDONE,   MBISTFAIL_MBISTDONE);//WC_SF1_CII   WBR0_RX          (resetn,CLK,CoreOut_RX,           RX_TX,                 ScanEnable,HoldEnable,           RX,          ACK_RX);
WC_SD1_COI_G WBR0_BC           (resetn,CLK,CoreOut_BC,           BC_ACK,                wse_outputs,hold_outputs,BusDisable,BC,          MBISTDONE_BC);//WC_SF1_CII   WBR0_TX          (resetn,CLK,CoreOut_TX,           WPSI0,                 ScanEnable,HoldEnable,           TX,          RX_TX);
WC_SF1_CII   WBR0_ACK          (resetn,CLK,CoreOut_ACK,          ACK_RX,                wse_outputs,hold_outputs,           ACK,         BC_ACK);
WC_SF1_CII   WBR0_RX           (resetn,CLK,RX,                   RX_TX,                 wse_outputs,hold_outputs,           CoreIn_RX,   ACK_RX);
WC_SF1_CII   WBR0_TX           (resetn,CLK,TX,                   WPSI0,                 wse_outputs,hold_outputs,           CoreIn_TX,   RX_TX);
endmodule