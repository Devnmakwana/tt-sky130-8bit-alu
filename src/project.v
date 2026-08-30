`default_nettype none

module tt_um_dev_makwana_alu8 (
    input  wire [7:0] ui_in,    // Dedicated inputs (Operand A)
    output wire [7:0] uo_out,   // Dedicated outputs (Result)
    input  wire [7:0] uio_in,   // IOs: Input path (Operand B & Opcode)
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    assign uio_oe  = 8'b0000_0000;
    assign uio_out = 8'b0000_0000;

    wire [7:0] a = ui_in;
    wire [7:0] b = {4'b0000, uio_in[3:0]}; 
    wire [2:0] opcode = uio_in[7:5];

    alu8 my_alu (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(uo_out)
    );

endmodule
