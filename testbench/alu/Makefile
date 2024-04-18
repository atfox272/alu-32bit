# Makefile for Verilog simulation

# Define the source files
SRCS = alu_tb.sv ../../rtl/alu.sv ../../rtl/adder.sv ../../rtl/full_adder.sv ../../rtl/half_adder.sv ../../rtl/and_bitwise.sv ../../rtl/or_bitwise.sv ../../rtl/decoder.sv ../../rtl/multiplexer_16to1.sv ../../rtl/shift.sv  


# Define the name of the simulation executable
SIM = simulation

# Define the default target
all: $(SIM)

# Rule to build the simulation executable
$(SIM): $(SRCS)
	cp ../../rtl/*.h ./
	iverilog -o $(SIM) $(SRCS)

# Rule to run the simulation
run: $(SIM)
	vvp $(SIM)

# Rule to clean up generated files
clean:
	rm *.vcd
	rm *.h
	rm -f $(SIM)
	
.PHONY: all run clean

