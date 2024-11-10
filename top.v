module top#(parameter  REG_WIDTH = 8, OUT_WIDTH = REG_WIDTH*2)(clk, reset, A0, A1, A2, A3, B0, B1, B2, B3);

input [REG_WIDTH-1:0] A0, A1, A2, A3, B0, B1, B2, B3;
input clk, reset;
wire [OUT_WIDTH-1:0] C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15;

wire [3:0] count;
wire done;


(*DONT_TOUCH="YES"*)
systolic_array ssy(A0, A1, A2, A3, B0, B1, B2, B3, C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, clk, reset, count, done);


ila_0 ila_instance (
	.clk(clk), // input wire clk


	.probe0(C0), // input wire [3:0]  probe0  
	.probe1(C1), // input wire [3:0]  probe1 
	.probe2(C2), // input wire [3:0]  probe2 
	.probe3(C3), // input wire [3:0]  probe3 
	.probe4(C4), // input wire [3:0]  probe4 
	.probe5(C5), // input wire [3:0]  probe5 
	.probe6(C6), // input wire [3:0]  probe6 
	.probe7(C7), // input wire [3:0]  probe7 
	.probe8(C8), // input wire [3:0]  probe8 
	.probe9(C9), // input wire [3:0]  probe9 
	.probe10(C10), // input wire [3:0]  probe10 
	.probe11(C11), // input wire [3:0]  probe11 
	.probe12(C12), // input wire [3:0]  probe12 
	.probe13(C13), // input wire [3:0]  probe13 
	.probe14(C14), // input wire [3:0]  probe14 
	.probe15(C15) // input wire [3:0]  probe15
);
endmodule
