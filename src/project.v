`default_nettype none

module tt_um_dev_makwana_alu8 (
    input  wire [7:0] ui_in,    
    output wire [7:0] uo_out,   
    input  wire [7:0] uio_in,   
    output wire [7:0] uio_out,  
    output wire [7:0] uio_oe,   
    input  wire       ena,      
    input  wire       clk,      
    input  wire       rst_n     
);

    wire [7:0] a_in;
    wire [7:0] b_in;
    wire [2:0] opcode_in;
    wire [7:0] result_out;
    wire carry_out;
    wire zero_out;

    assign a_in      = ui_in;
    assign b_in      = uio_in[7:0];
    assign opcode_in = 3'b000; 

    alu8 u_alu8 (
        .a(a_in),
        .b(b_in),
        .opcode(opcode_in),
        .out(result_out),
        .carry(carry_out),
        .zero(zero_out)
    );

    assign uo_out = result_out;
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0; 

    wire _unused = &{ena, clk, rst_n, carry_out, zero_out, 1'b0};

endmodule
