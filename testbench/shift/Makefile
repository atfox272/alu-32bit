# Makefile for Verilog simulation

# Define the source files
SRCS = shift_tb.sv ../../rtl/shift.sv

# Define the name of the simulation executable
SIM = simulation

# Define the default target
all: $(SIM)

# Rule to build the simulation executable
$(SIM): $(SRCS)
	cp ../../rtl/shift_define.h ./
	iverilog -o $(SIM) $(SRCS)

# Rule to run the simulation
run: $(SIM)
	vvp $(SIM)

# Rule to clean up generated files
clean:
	rm shift_define.h
	rm -f $(SIM)

.PHONY: all run clean

