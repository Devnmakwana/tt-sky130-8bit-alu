module alu8 (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire [2:0] opcode,
    output reg  [7:0] out,
    output reg        carry,
    output reg        zero
);

    always @(*) begin
        carry = 1'b0;
        case (opcode)
            3'b000: {carry, out} = a + b;   // ADD
            3'b001: {carry, out} = a - b;   // SUB
            3'b010: out = a & b;            // AND
            3'b011: out = a | b;            // OR
            3'b100: out = a ^ b;            // XOR
            3'b101: out = ~a;               // NOT A
            3'b110: out = a << 1;           // Left Shift
            3'b111: out = a >> 1;           // Right Shift
            default: out = 8'h00;
        endcase
        zero = (out == 8'h00);
    end

endmodule
