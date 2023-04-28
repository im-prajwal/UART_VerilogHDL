Description:
UART (Universal Asynchronous Receiver/Transmitter) is a type of communication interface used for serial communication between two devices. It converts parallel data to serial data and vice versa. The UART is commonly used to connect microcontrollers, sensors, and other devices to computers or other electronic systems.

The UART uses a start bit, data bits, parity bit (optional), and stop bits to send data between two devices. The start bit indicates the beginning of a data frame, while the stop bit indicates the end of a data frame. The data bits contain the actual information being transmitted, while the parity bit (if used) provides error detection.

The UART communication protocol is asynchronous, meaning that the data is sent without a clock signal, and the timing is determined by the baud rate. The baud rate represents the number of bits transmitted per second, and it must be the same on both devices for proper communication.

UART is a widely used protocol and is supported by most microcontrollers and other electronic devices.

Results:
Implemented UART protocol and verified transmission and reception of data through a serial interface using Verilog Testbench. Designed synthesizable RTL of Transmitter and Receiver.

HDL: Verilog 
EDA Tool: Xilinx Vivado




