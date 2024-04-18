# Makefile for Verilog simulation

# Define the source files
SRCS = and_bitwise_tb.sv ../../rtl/and_bitwise.sv

# Define the name of the simulation executable
SIM = simulation

# Define the default target
all: $(SIM)

# Rule to build the simulation executable
$(SIM): $(SRCS)
	cp ../../rtl/and_bitwise_define.h ./
	iverilog -o $(SIM) $(SRCS)

# Rule to run the simulation
run: $(SIM)
	vvp $(SIM)
	rm and_bitwise_define.h

# Rule to clean up generated files
clean:
	rm -f $(SIM)

.PHONY: all run clean

