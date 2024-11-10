module pe #(parameter REG_WIDTH = 8, OUT_WIDTH = REG_WIDTH*2)(
input clk, reset,
input [REG_WIDTH-1:0] A, B,
output reg [REG_WIDTH-1:0] a_out,b_out,
output reg [OUT_WIDTH-1:0] C
    );
    
    reg [1:0] temp_a = 0, temp_b = 0;
    
//    always@(posedge clk) begin
//        {a_out, temp_a} <= {temp_a, A};
//        {b_out, temp_b} <= {temp_b, B};
//    end
    
    initial begin
        a_out = 0; b_out = 0; C = 0;
    end
    
    booth_multiplier uut(A, B, mul);
    
    wire [ REG_WIDTH-1:0] mul;
//    assign mul = A*B;
    always@(posedge clk) begin
        if(reset) begin
            C <= 0;
        end
        else begin
            C <= C + mul;
           
        end
    end
    always@(posedge clk) begin
    if(reset) begin
        a_out <=0;
            b_out <= 0;
    end else begin
        a_out <=  A;
       b_out<= B;
 end
    end
endmodule


module booth_multiplier #(parameter REG_WIDTH = 8, OUT_WIDTH = REG_WIDTH*2)(
    input [REG_WIDTH-1:0] A, B,
    output reg [OUT_WIDTH-1:0] P
);

    reg [OUT_WIDTH-1:0] partial_sum;
    reg [REG_WIDTH:0] booth_reg; // Extended by 1 bit for Booth encoding
    integer i;
//    reg temp;
    
    initial begin
    
    P=0;  booth_reg=0; partial_sum=0;
    end

    always @(*) begin
        booth_reg = {B, 1'b0}; // Extend B by appending a zero at the LSB for Booth encoding
        partial_sum = 0;

        // Radix-4 Booth Encoding Loop
       for (i = 0; i < REG_WIDTH / 2; i = i + 1) begin
            case (booth_reg[2:0])
                3'b000, 3'b111: partial_sum = partial_sum;            // No addition
                3'b001, 3'b010: partial_sum = partial_sum + (A << (i<<1)); // Add A shifted by 2*i
                3'b011:          partial_sum = partial_sum + (A << ((i<<1) + 1)); // Add 2 * A shifted
                3'b100:          partial_sum = partial_sum - (A << ((i<<1)+ 1)); // Subtract 2 * A shifted
                3'b101, 3'b110:  partial_sum = partial_sum - (A << (i<<1)); // Subtract A shifted
            endcase
            booth_reg = booth_reg >> 2; // Shift booth_reg by 2 for next pair
        end
        // Assign the final product
        P = partial_sum;
    end
    
   

endmodule
