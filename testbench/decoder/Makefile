# Makefile for Verilog simulation

# Define the source files
SRCS = decoder_tb.sv ../../rtl/decoder.sv

# Define the name of the simulation executable
SIM = simulation

# Define the default target
all: $(SIM)

# Rule to build the simulation executable
$(SIM): $(SRCS)
	cp ../../rtl/decoder_define.h ./
	iverilog -o $(SIM) $(SRCS)

# Rule to run the simulation
run: $(SIM)
	vvp $(SIM)
	rm decoder_define.h

# Rule to clean up generated files
clean:
	rm -f $(SIM)

.PHONY: all run clean

