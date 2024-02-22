The Myca-II programmable controller is a device that can be programmed to implement a specific state diagram using assembly language.

In this project, the following were designed:-

1. Pop machine controller using Moore State Machine (FSM)
2. Pop machine controller using Myca-II
3. Parking lot controller using Myca-II
4. 4-bit ALU

The first two designs were tested on PYNQ-Z1 board with the LEDs showing the relevant input/output details regarding the pop machine. 

Notes:- 

1. Modules in this project are interconnected in order to make more complex modules so deleting even one module may make some of the other modules to not work anymore. Furthermore, the "or", "and", "xor" modules were implemented for learning purposes when I started VHDL. Since VHDL already has pre-defined functions for these logical operations, making those modules was not necessary. However, since I made some other circuits using those modules (via port mapping) so deleting them will also cause some of the other circuits to not work. Therefore, if those modules are not present, the program for some of the other circuits need to be altered.
2. The log_function file only serves to define the log function which I have used in some modules.
3. ROM.vhd contains the specific algorithm for the implementation of the pop machine using Myca-II controller.
4. pop_machine.vhd contains the logic for pop machine controller using FSM (without Myca-II).
5. Test bench for debouncer and pop machine FSM is also included in this repo.
