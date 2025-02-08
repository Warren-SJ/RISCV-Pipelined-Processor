# RISCV-Pipelined-Processor
This is an implementation of a pipelined RISC-V CPU. It consists of 5 stages as:

1. Instruction Fetch (IF)
2. Instruction Decode (ID)
3. Execute (EX)
4. Memory Access (ME)
5. Write Back (WB)

### Instructions for use: Simulation

1. Clone the repository using the following command:
```bash
git clone https://github.com/Warren-SJ/RISCV-Pipelined-Processor.git
```

2. Create a new project in your preferred FPGA development environment (e.g., Vivado, Quartus, etc.)

3. Add all the `.sv` files to the project

4. Set the top simulation module to `RISCV_Processor_Top_Tb.sv`

5. Run the simulation

To view the simulation waveform, it is recommended that you use gtkwave or any other waveform viewer. To use gtkwave on Windows, you must use the Windows Subsystem for Linux (WSL). Instructions can be found [here](https://learn.microsoft.com/en-us/windows/wsl/install).

Next, run the following command in the Linux terminal:
```bash
sudo apt-get install gtkwave
```

After installing gtkwave, run the following command to open the waveform:
```bash
cd /mnt/path_to_your_project_folder
gtkwave RISC_V_Processor_Top.vcd
```

Note: To change the instructions, change them in `Instruction_Memory.sv`. To obtain instructions, refer to [this](https://luplab.gitlab.io/rvcodecjs/).

![Image of the simulation](Simulation.png)

### Instructions for use: FPGA Implementation

1. Clone the repository using the following command:
```bash
git clone https://github.com/Warren-SJ/RISCV-Pipelined-Processor.git
```

2. Create a new project in your preferred FPGA development environment (e.g., Vivado, Quartus, etc.)

3. Add all the `.sv` files to the project

4. Set the top module to `RISCV_Processor_Top.sv`

5. Run the synthesis and implementation process

6. Map the ports as required. This was implemented on a DE2-115 FPGA board and the port mappings are found in ```Pipelined.qsf```. You may import this file into your Quartus project to use the same port mappings.

7. Program the FPGA

Notes:
- The clock is mapped to `KEY0`, and reset is mapped to `KEY3`. The clock is mapped to a button so that the results can be observed on the 7-segment display.
- To reset, press `KEY3` and while pressing it, press `KEY0`.
- The 7-segment display will show the output of the ALU operation or the value being written to register. This may be changed by using `SW17`.

Improvements:
- The processor is not fully pipelined. The processor is stalled when a branch instruction is executed. This can be improved by implementing branch prediction.
- Hazard detection is not implemented. This can be improved by implementing forwarding and stalling.

  The initial design which was a single cycle design can be found [here](https://github.com/Warren-SJ/RISCV-Single-Cycle-Processor).
