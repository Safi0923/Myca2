The Myca-II programmable controller is a device that can be programmed to implement a specific state diagram using assembly language.
In this project, a Myca-II programmable controller is designed using VHDL so that it can be programmed to implement a pop machine compute system or a parking lot control system.

Notes:- 

1. Modules in this project are interconnected in order to make more complex modules so deleting even one module may make some of the other modules not work anymore. Furthermore, the "or", "and", "xor" modules were implemented for learning purpose when I started VHDL. Since VHDL already has pre-defined functions for these logical operations, making those modules was not necessary. However, since I made some other circuits using those modules (via port mapping) so deleting them will also cause some of the other circuits to not work. Therefore, if those modules are not present, the program for some of the other circuits need to be altered.
2. The log_function file only serves to define the log function which I have used in some modules.
