`include "sys_array_4x4.v"

module systolic_array_tb();
reg clk, reset;
reg [3:0] A0, A1, A2, A3, B0, B1, B2, B3;
wire [7:0] C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15;

initial begin
  clk = 0;
  reset = 1;
end

always #5 clk = ~clk;

initial begin
  clk = 1;
  #10
  reset = 0;

  A0 = 4'd1; A1 = 4'd0; A2 = 4'd0; A3 = 4'd0;
  B0 = 4'd1; B1 = 4'd0; B2 = 4'd0; B3 = 4'd0;
  
  #10;
  A0 = 4'd2; A1 = 4'd2; A2 = 4'd0; A3 = 4'd0;
  B0 = 4'd2; B1 = 4'd1; B2 = 4'd0; B3 = 4'd0;

  #10;
  A0 = 4'd3; A1 = 4'd3; A2 = 4'd3; A3 = 4'd0;
  B0 = 4'd3; B1 = 4'd2; B2 = 4'd1; B3 = 4'd0;

  #10;
  A0 = 4'd4; A1 = 4'd4; A2 = 4'd4; A3 = 4'd4;
  B0 = 4'd4; B1 = 4'd3; B2 = 4'd2; B3 = 4'd1;

  #10;
  A0 = 4'd0; A1 = 4'd5; A2 = 4'd5; A3 = 4'd5;
  B0 = 4'd0; B1 = 4'd4; B2 = 4'd3; B3 = 4'd2;

  #10;
  A0 = 4'd0; A1 = 4'd0; A2 = 4'd6; A3 = 4'd6;
  B0 = 4'd0; B1 = 4'd0; B2 = 4'd4; B3 = 4'd3;

  #10;
  A0 = 4'd0; A1 = 4'd0; A2 = 4'd0; A3 = 4'd7;
  B0 = 4'd0; B1 = 4'd0; B2 = 4'd0; B3 = 4'd4;

  #10;
  A0 = 4'd0; A1 = 4'd0; A2 = 4'd0; A3 = 4'd0;
  B0 = 4'd0; B1 = 4'd0; B2 = 4'd0; B3 = 4'd0;  

end

systolic_array uut (
.A0(A0), .A1(A1), .A2(A2), .A3(A3),
.B0(B0), .B1(B1), .B2(B2), .B3(B3),
.clk(clk),
.reset(reset),
.C0(C0), .C1(C1), .C2(C2), .C3(C3), .C4(C4), .C5(C5), .C6(C6), .C7(C7),
.C8(C8), .C9(C9), .C10(C10), .C11(C11), .C12(C12), .C13(C13), .C14(C14), .C15(C15)
);

initial begin
	$dumpfile("sys_booth.vcd");
	$dumpvars(0, systolic_array_tb);

  #1000
  $finish();
end

endmodule