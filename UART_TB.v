`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer: Prajwal H N
// 
// Create Date: 21.04.2023 15:43:17
// Module Name: UART_TB
// Project Name: UART Implementation using Verilog HDL
// Description: 
//////////////////////////////////////////////////////////////////////////////////

module UART_TB();

//---------------- Signals to drive input and output ports of DUT -----------------

//Signals to drive Inputs: 
reg clk, start;
reg [7:0] txIn;

//Signals for Outputs:
wire rxDone;
wire [7:0] rxOut;

//Intermediate Nets:
wire bitDone, txDone, txrx;
wire [3:0] waitCount;

//Instantiating DUTs:
Transmitter Tx(clk, start, txIn, txrx, txDone, bitDone, waitCount);
Receiver Rx(clk, txrx, bitDone, waitCount, rxDone, rxOut);


//Initialisations:
initial clk = 0;
initial start = 0;


//Generating Clock Signal:
always #5 clk = ~clk;


//Driving the ports:
integer i = 0;
 
initial 
begin
    start = 1;
    
    for(i = 0; i < 10; i = i + 1) 
    begin
        txIn = $urandom_range(10,200);
        @(posedge rxDone);
        @(posedge txDone);
        $display(waitCount);
       
    end
    
    $stop; 
end
 
endmodule
