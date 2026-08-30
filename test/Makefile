SIM ?= icarus
TOPLEVEL_LANG ?= verilog
SRC_DIR = $(PWD)/../src
PROJECT_SOURCES = project.v alu8.v

ifneq ($(GATES),yes)
VERILOG_SOURCES = $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES))
else
VERILOG_SOURCES = $(PWD)/gate_level_netlist.v
endif

VERILOG_SOURCES += $(PWD)/tb.v
TOPLEVEL = tb
MODULE = test

include $(shell cocotb-config --makefiles)/Makefile.sim
