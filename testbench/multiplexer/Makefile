# Makefile for Verilog simulation

# Define the source files
SRCS = multiplexer_tb.sv ../../rtl/multiplexer_8to1.sv

# Define the name of the simulation executable
SIM = simulation

# Define the default target
all: $(SIM)

# Rule to build the simulation executable
$(SIM): $(SRCS)
	iverilog -o $(SIM) $(SRCS)

# Rule to run the simulation
run: $(SIM)
	vvp $(SIM)

# Rule to clean up generated files
clean:
	rm -f $(SIM)

.PHONY: all run clean

