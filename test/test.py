import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_alu(dut):
    dut._log.info("Start ALU test")
    clock = Clock(dut.clk, 100, units="ns")
    cocotb.start_soon(clock.start())

    # Reset
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)

    # Test ADD: 20 + 10 = 30
    # a = 20
    # b = 10, opcode = 000 (ADD). uio_in = (0 << 5) | 10 = 10
    dut.ui_in.value = 20
    dut.uio_in.value = 10 
    await ClockCycles(dut.clk, 1)
    assert int(dut.uo_out.value) == 30, f"ADD Failed: Expected 30, got {int(dut.uo_out.value)}"

    # Test SUB: 20 - 5 = 15
    # a = 20
    # b = 5, opcode = 001 (SUB). uio_in = (1 << 5) | 5 = 32 + 5 = 37
    dut.ui_in.value = 20
    dut.uio_in.value = 37
    await ClockCycles(dut.clk, 1)
    assert int(dut.uo_out.value) == 15, f"SUB Failed: Expected 15, got {int(dut.uo_out.value)}"
    
    dut._log.info("All ALU operations passed successfully!")
