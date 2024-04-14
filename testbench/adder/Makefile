# Makefile for Verilog simulation

# Define the source files
SRCS = adder_tb.sv ../../rtl/adder.sv ../../rtl/full_adder.sv ../../rtl/half_adder.sv 


# Define the name of the simulation executable
SIM = simulation

# Define the default target
all: $(SIM)

# Rule to build the simulation executable
$(SIM): $(SRCS)
	cp ../../rtl/adder_define.h ./
	iverilog -o $(SIM) $(SRCS)

# Rule to run the simulation
run: $(SIM)
	vvp $(SIM)

# Rule to clean up generated files
clean:
	rm adder_define.h
	rm -f $(SIM)

.PHONY: all run clean

