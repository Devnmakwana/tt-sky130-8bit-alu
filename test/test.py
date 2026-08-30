import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_alu_operations(dut):
    dut._log.info("Starting ALU operations test")

    # 10 MHz clock (100ns period)
    clock = Clock(dut.clk, 100, unit="ns")
    cocotb.start_soon(clock.start())

    # Reset
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)

    # Test cases: (op_name, opcode, a, b_4bit, expected_result)
    test_cases = [
        ("ADD",         0b000, 10, 5, (10 + 5) & 0xFF),
        ("SUB",         0b001, 10, 5, (10 - 5) & 0xFF),
        ("AND",         0b010, 0xF0, 0x0F, 0xF0 & 0x0F),
        ("OR",          0b011, 0xF0, 0x05, 0xF0 | 0x05),
        ("XOR",         0b100, 0xAA, 0x0A, 0xAA ^ 0x0A),
        ("SHIFT_LEFT",  0b101, 3, 2, (3 << 2) & 0xFF),
        ("SHIFT_RIGHT", 0b110, 16, 2, 16 >> 2),
        ("COMPARE_EQ",  0b111, 4, 4, 1),
        ("COMPARE_NEQ", 0b111, 4, 5, 0),
    ]

    for name, opcode, a_val, b_val, expected in test_cases:
        # ui_in is operand A
        dut.ui_in.value = a_val
        # uio_in: [7:5] = opcode, [3:0] = operand B
        dut.uio_in.value = (opcode << 5) | (b_val & 0x0F)

        await ClockCycles(dut.clk, 1)

        result = int(dut.uo_out.value)
        dut._log.info(f"[{name}] a={a_val}, b={b_val}, opcode={bin(opcode)} -> result={result} (expected {expected})")
        assert result == expected, f"{name} failed: got {result}, expected {expected}"

    dut._log.info("All ALU operations passed successfully!")
