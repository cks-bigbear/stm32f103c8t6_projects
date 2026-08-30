# Introduction
Implement serial loop printing of "running...".

# Usage  
1. Open the .ioc project in CubeMX and click "Generate Code".  

2. Modify the toolchain paths (CMake, Ninja, LLVM-ET-Arm) in the options.env section of .vscode/tasks.json, then press Ctrl + Shift + B​ to build the project.  

3. After connecting the programmer/debugger, press Ctrl + P​ to open the Command Palette, select "Tasks: Run Task", then choose the Download​ task to flash the firmware to the MCU.  

4. Connect the board to the computer via a TTL-to-USB serial adapter, open a serial terminal, reset the MCU to start the program, and you should see "running..." printed repeatedly.  

5. If single-step debugging is needed, press F5​ to launch the debug session.  

# Notice
1. CubeMX-generated code includes the line __HAL_AFIO_REMAP_SWJ_DISABLE();. This is typically added only after debugging is complete, so remember to comment it out during the debugging phase.  
