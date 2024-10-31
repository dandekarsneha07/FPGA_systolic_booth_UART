`include "PE_booth.v"
module systolic_array(A0, A1, A2, A3, B0, B1, B2, B3, C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, clk, reset);

//inout output ports
input [3:0] A0, A1, A2, A3, B0, B1, B2, B3;
input clk, reset;
output [7:0] C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15;

// internal wires
wire [3:0] a0, a1, a2, a3;
wire [3:0] a4, a5, a6, a7;
wire [3:0] a8, a9, a10, a11;
wire [3:0] a12, a13, a14, a15;

wire [3:0] b0, b1, b2, b3;
wire [3:0] b4, b5, b6, b7;
wire [3:0] b8, b9, b10, b11;
wire [3:0] b12, b13, b14, b15;

// PE Instantiation for 4x4

PE P0(A0, B0, a0, b0, clk, reset, C0);
PE P1(a0, B1, a1, b1, clk, reset, C1);
PE P2(a1, B2, a2, b2, clk, reset, C2);
PE P3(a2, B3, a3, b3, clk, reset, C3);

PE P4(A1, b0, a4, b4, clk, reset, C4);
PE P5(a4, b1, a5, b5, clk, reset, C5);
PE P6(a5, b2, a6, b6, clk, reset, C6);
PE P7(a6, b3, a7, b7, clk, reset, C7);

PE P8(A2, b4, a8, b8, clk, reset, C8);
PE P9(a8, b5, a9, b9, clk, reset, C9);
PE P10(a9, b6, a10, b10, clk, reset, C10);
PE P11(a10, b7, a11, b11, clk, reset, C11);

PE P12(A3, b8, a12, b12, clk, reset, C12);
PE P13(a12, b9, a13, b13, clk, reset, C13);
PE P14(a13, b10, a14, b14, clk, reset, C14);
PE P15(a14, b11, a15, b15, clk, reset, C15);

always @(posedge clk)begin
    
if(reset)begin

    count <= 0;
    done <= 0;
end

else begin
    if(count == 9) begin
    count <= 0;
    done <= 1;
    

    end

    else begin
    count <= count + 1;
    done <= 0;
    
    end
end 


end
  
endmodule
