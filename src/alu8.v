module alu8 (
    input  [7:0] a,
    input  [7:0] b,
    input  [2:0] opcode,
    output reg [7:0] result
);
    always @(*) begin
        case (opcode)
            3'b000: result = a + b;       // ADD
            3'b001: result = a - b;       // SUB
            3'b010: result = a & b;       // AND
            3'b011: result = a | b;       // OR
            3'b100: result = a ^ b;       // XOR
            3'b101: result = a << b[2:0]; // SHIFT LEFT
            3'b110: result = a >> b[2:0]; // SHIFT RIGHT
            3'b111: result = (a == b) ? 8'd1 : 8'd0; // COMPARE
            default: result = 8'd0;
        endcase
    end
endmodule
