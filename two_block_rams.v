module two_bram_uart(input clk,reset,i_uart_rx);

wire clk_out1, clk_out2;

localparam  N_DATA_BITS = 8,
                OVERSAMPLE = 13;
                
    localparam integer UART_CLOCK_DIVIDER = 64;
    localparam integer MAJORITY_START_IDX = 4;
    localparam integer MAJORITY_END_IDX = 8;
    localparam integer UART_CLOCK_DIVIDER_WIDTH = $clog2(UART_CLOCK_DIVIDER);
    
    wire reset;
    
    wire uart_clk;
    reg uart_en;
    reg [UART_CLOCK_DIVIDER_WIDTH:0] uart_divider_counter;
    
    wire [N_DATA_BITS-1:0] uart_rx_data;
    wire uart_rx_data_valid;
    
    reg [N_DATA_BITS-1:0] uart_rx_data_buf;
    reg uart_rx_data_valid_buf;
    
     uart_rx #(
        .OVERSAMPLE(OVERSAMPLE),
        .N_DATA_BITS(N_DATA_BITS),
        .MAJORITY_START_IDX(MAJORITY_START_IDX),
        .MAJORITY_END_IDX(MAJORITY_END_IDX)
    ) rx_data (
        .i_clk(uart_clk),
        .i_en(uart_en),
        .i_reset(reset),
        .i_data(i_uart_rx),
        
        .o_data(uart_rx_data),
        .o_data_valid(uart_rx_data_valid)
    );

always @(posedge uart_clk) begin
        if(uart_divider_counter < (UART_CLOCK_DIVIDER-1))
            uart_divider_counter <= uart_divider_counter + 1;
       else
            uart_divider_counter <= 'd0;
    end
    
always @(posedge uart_clk) begin
    uart_en <= (uart_divider_counter == 'd10); 
end

clk_wiz_0 clk_gen(
   .clk_out1(uart_clk),     // output clk_out1
   .clk_in1(clk));      // input clk_in1


// BRAM A inst and variables
reg wea_a=1;
reg [3:0] addra_r, addra_w;
reg [7:0] din_a, buff_a; 
wire [7:0] data_a;


blk_mem_gen_0 bram_a (
  .clka(uart_clk),    // input wire clka
  .wea(wea_a),      // input wire [0 : 0] wea
  .addra(addra_w),  // input wire [3 : 0] addra
  .dina(din_a),    // input wire [7 : 0] dina
  .douta(0),  // output wire [7 : 0] douta
  .clkb(clk),    // input wire clkb
  .web(0),      // input wire [0 : 0] web
  .addrb(addra_r),  // input wire [3 : 0] addrb
  .dinb(0),    // input wire [7 : 0] dinb
  .doutb(data_a)  // output wire [7 : 0] doutb
);

// BRAM B inst and variables
reg wea_b=1;
reg [3:0] addrb_r, addrb_w;
reg [7:0] din_b, buff_b;
wire [7:0] data_b; 

blk_mem_gen_0 bram_b (
  .clka(uart_clk),    // input wire clka
  .wea(wea_b),      // input wire [0 : 0] wea
  .addra(addrb_w),  // input wire [3 : 0] addra
  .dina(din_b),    // input wire [7 : 0] dina
  .douta(0),  // output wire [7 : 0] douta
  .clkb(clk),    // input wire clkb
  .web(0),      // input wire [0 : 0] web
  .addrb(addrb_r),  // input wire [3 : 0] addrb
  .dinb(0),    // input wire [7 : 0] dinb
  .doutb(data_b)  // output wire [7 : 0] doutb
);

//debugging writing to BRAM uart_clk

ila_0 ila_uart (
	.clk(uart_clk), // input wire clk
	.probe0(wea_a), // input wire [0:0]  probe0  
	.probe1(addra_w), // input wire [3:0]  probe1 
	.probe2(din_a), // input wire [7:0]  probe2 
	.probe3(wea_b), // input wire [0:0]  probe3 
	.probe4(addrb_w), // input wire [3:0]  probe4 
	.probe5(din_b), // input wire [7:0]  probe5 
	.probe6(b_sel), // input wire [0:0]  probe6 
	.probe7(sysenb), // input wire [0:0]  probe7 
	.probe8(cnt) // input wire [4:0]  probe8
);


ila_1 ila_clk (
	.clk(clk), // input wire clk
	.probe0(addra_w), // input wire [3:0]  probe0  
	.probe1(buff_a), // input wire [7:0]  probe1 
	.probe2(addra_r), // input wire [3:0]  probe2 
	.probe3(buff_b), // input wire [7:0]  probe3 
	.probe4(addrb_w), // input wire [3:0]  probe4 
	.probe5(din_a), // input wire [7:0]  probe5 
	.probe6(addrb_r), // input wire [3:0]  probe6 
	.probe7(din_b), // input wire [7:0]  probe7 
	.probe8(cnt_data_a), // input wire [4:0]  probe8 
	.probe9(cnt_data_b), // input wire [4:0]  probe9 
	.probe10(flag_2) // input wire [0:0]  probe10
);



//writing to BRAM from UART

reg [4:0] cnt = 0, cnt_data_a = 0, cnt_data_b =0;
reg flag_1=0, flag_2=0, flag_3=0, flag_4=0;
reg sysenb;
reg b_sel;

always @(posedge uart_clk)begin

    if(uart_rx_data_valid && uart_en && !b_sel)begin 
    
        if(cnt == 15)begin
            b_sel <= 1;
            wea_a <= 0;
        end   
        else begin
            flag_1 = 1;
            din_a <= uart_rx_data;
            addra_w <= addra_w + 'b00001;
            cnt <= cnt + 'b00001;
        end
    end
    
    if(uart_rx_data_valid && uart_en && b_sel)begin 
    
        if(cnt == 31)begin
            sysenb <= 1;
            cnt <= 0;
            addra_r <= 0;
            wea_b <= 0;        
        end
       
        else begin
            //flag_3 = 1;
            din_b <= uart_rx_data;
            addrb_w <= addrb_w + 'b00001;
            cnt <= cnt + 'b00001;
        end
    end
    
end

//reading from BRAM 
always @(posedge clk)begin

    if(sysenb)begin
    
        if(cnt_data_a == 15)begin
        
            addra_r <= 0;
            flag_2 <= 0;
            cnt_data_a<=0;
        
        end
        
        else begin
            flag_2 = 1;
            buff_a <= data_a;
            addra_r <= addra_r + 'b00001;
            cnt_data_a <= cnt_data_a + 'b00001;
        end
    end
    
    if(sysenb)begin
    
        if(cnt_data_b == 15)begin
        
            addrb_r <= 0;
            flag_3 <= 0;
            cnt_data_b <= 0;
        
        end
        
        else begin
            flag_3 = 1;
            buff_b <= data_b;
            addrb_r <= addrb_r + 'b00001;
            cnt_data_b <= cnt_data_b + 'b00001;
        end

    end
end

endmodule
