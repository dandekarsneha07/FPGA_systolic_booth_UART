module sys_tb;

reg [7:0] A0 = 0, A1 = 0, A2 = 0, A3 = 0, B0 = 0, B1 = 0, B2 = 0, B3 = 0;
//wire [5:0] C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15;
reg clk, reset;
wire [3:0]count;
wire done;

initial begin
clk = 0;reset = 1;

end

always #5 clk = ~clk;

initial begin

    
  clk = 0;
  
   #105;
  reset = 0;
  #11
  

  A0 = 2'd1; A1 = 2'd0; A2 = 2'd0; A3 = 2'd0;
  B0 = 2'd1; B1 = 2'd0; B2 = 2'd0; B3 = 2'd0;
  
  #11;
  A0 = 2'd1; A1 = 2'd1; A2 = 2'd0; A3 = 2'd0;
  B0 = 2'd1; B1 = 2'd1; B2 = 2'd0; B3 = 2'd0;

  #11;
  A0 = 2'd1; A1 = 2'd1; A2 = 2'd1; A3 = 2'd0;
  B0 = 2'd1; B1 = 2'd1; B2 = 2'd1; B3 = 2'd0;

  #11;
  A0 = 2'd1; A1 = 2'd1; A2 = 2'd1; A3 = 2'd1;
  B0 = 2'd1; B1 = 2'd1; B2 = 2'd1; B3 = 2'd1;

  #11;
  A0 = 2'd0; A1 = 2'd1; A2 = 2'd1; A3 = 2'd1;
  B0 = 2'd0; B1 = 2'd1; B2 = 2'd1; B3 = 2'd1;

  #11;
  A0 = 2'd0; A1 = 2'd0; A2 = 2'd1; A3 = 2'd1;
  B0 = 2'd0; B1 = 2'd0; B2 = 2'd1; B3 = 2'd1;

  #11;
  A0 = 2'd0; A1 = 2'd0; A2 = 2'd0; A3 = 2'd1;
  B0 = 2'd0; B1 = 2'd0; B2 = 2'd0; B3 = 2'd1;

  #11;
  A0 = 2'd0; A1 = 2'd0; A2 = 2'd0; A3 = 2'd0;
  B0 = 2'd0; B1 = 2'd0; B2 = 2'd0; B3 = 2'd0;  

end

top UUT(clk, reset, A0, A1, A2, A3, B0, B1, B2, B3);

//systolic_array sys_uut(A0, A1, A2, A3, B0, B1, B2, B3, C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, clk, reset, count, done);
endmodule
