`include "booth_mult.v"
module PE #(parameter REG_WIDTH = 4, parameter OUT_WIDTH = 8)(
    input [REG_WIDTH-1:0] A, B,
    output reg [REG_WIDTH-1:0] a, b,
    input clk, reset,
    output reg [OUT_WIDTH-1:0] C
    
);

    wire [OUT_WIDTH-1:0] mult;

    // Instantiate the booth_multiplier
    booth_multiplier #(.REG_WIDTH(REG_WIDTH), .OUT_WIDTH(OUT_WIDTH)) booth_mul (
        .A(A),
        .B(B),
        .P(mult)
    );

    always @(posedge clk) begin
        if (reset) begin
            C <= 8'b0;
            a <= 4'b0;
            b <= 4'b0;
        end else begin
            C <= C + mult;
            a <= A;
            b <= B;
        end
    end

endmodule
