module systolic_array#(parameter REG_WIDTH = 8, OUT_WIDTH = REG_WIDTH*2)(A0, A1, A2, A3, B0, B1, B2, B3, C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, clk, reset, count, done);

//inout output ports
input [REG_WIDTH-1:0] A0, A1, A2, A3, B0, B1, B2, B3;
input clk, reset;
output [OUT_WIDTH-1:0] C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15;

output reg [5:0] count;
output reg done;

initial begin
count = 0; done = 0;
end

// internal wires
wire [REG_WIDTH-1:0] a0, a1, a2, a3;
wire [REG_WIDTH-1:0] a4, a5, a6, a7;
wire [REG_WIDTH-1:0] a8, a9, a10, a11;
wire [REG_WIDTH-1:0] a12, a13, a14, a15;

wire [REG_WIDTH-1:0] b_out0, b_out1, b_out2, b_out3;
wire [REG_WIDTH-1:0] b_out4, b_out5, b_out6, b_out7;
wire [REG_WIDTH-1:0] b_out8, b_out9, b_out10, b_out11;
wire [REG_WIDTH-1:0] b_out12, b_out13, b_out14, b_out15;

// PE Instantiation for 4x4
wire rd;
assign rd = reset | done;
pe P0(clk, rd, A0, B0, a0, b_out0, C0);
pe P1(clk, rd, a0, B1, a1, b_out1, C1);
pe P2(clk, rd, a1, B2, a2, b_out2, C2);
pe P3(clk,rd, a2, B3, a3, b_out3, C3);

pe P4(clk, rd,A1, b_out0, a4, b_out4, C4);
pe P5(clk,rd,a4, b_out1, a5, b_out5, C5);
pe P6(clk, rd,a5, b_out2, a6, b_out6, C6);
pe P7(clk, rd,a6, b_out3, a7, b_out7, C7);

pe P8(clk, rd,A2, b_out4, a8, b_out8, C8);
pe P9(clk, rd,a8, b_out5, a9, b_out9, C9);
pe P10(clk, rd,a9, b_out6, a10, b_out10, C10);
pe P11(clk, rd,a10, b_out7, a11, b_out11, C11);

pe P12(clk, rd,A3, b_out8, a12, b_out12, C12);
pe P13(clk, rd,a12, b_out9, a13, b_out13, C13);
pe P14(clk, rd,a13, b_out10, a14, b_out14, C14);
pe P15(clk, rd,a14, b_out11, a15, b_out15, C15);

always @(posedge clk)begin
    
if(reset)begin

    count <= 0;
    done <= 0;
end

else begin
    if(count == 'd11) begin
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
