`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer: Prajwal H N
// 
// Create Date: 19.04.2023 22:49:43
// Module Name: Transmitter
// Project Name: UART Implementation using Verilog HDL
// Description: 
//////////////////////////////////////////////////////////////////////////////////

module Transmitter(
    input clk, start,
    input [7:0] txIn,
    output reg tx,
    output txDone,
    output reg bitDone,
    output [3:0] waitCount
    );
    
reg [9:0] txData;
integer txIndex;
reg startBit = 0;
reg stopBit = 1;


//----------------------- Defining States of the Transmitter ---------------------
parameter IDLE = 0,
          SEND = 1,
          CHECK = 2;

//Variable to hold the value of state:
reg [1:0] state = IDLE;


//---------------------------- Trigger Generator Logic ---------------------------    
parameter clkVal = 100_000;
parameter baudRate = 9600;
parameter waitVal = clkVal/baudRate; 

assign waitCount = waitVal;

integer count = 0;

always @(posedge clk)
begin
    if(state == IDLE)
        count <= 0;
    else
        if(count == waitCount)
        begin
            bitDone <= 1;
            count <= 0;
        end
        else
        begin
            count <= count + 1;
            bitDone <= 0;
        end
end


//-------------------------------- Transmitter Logic -------------------------------
always @(posedge clk)
begin
    case(state)
    
        IDLE:
        begin
            tx <= 1;       //Transmission line held idle, i.e. No data transmission
            txData <= 0;   //No data to be transmitted
            txIndex <= 0;  //No bits sent
            
            if(start == 1)
            begin
                txData <= {stopBit, txIn, startBit};
                state <= SEND;
            end
            
            else
                state <= IDLE;
        end
        
        SEND:
        begin
            tx <= txData[txIndex];
            state <= CHECK;
        end
        
        CHECK:
        begin 
            if(txIndex <= 9)
            begin
                if(bitDone == 1)
                begin
                    txIndex <= txIndex + 1;
                    state <= SEND;
                end                 
            end
            
            else
            begin
                txIndex <= 0;
                state <= IDLE;
            end
        end
        
        default: state <= IDLE;
        
    endcase    
end

assign txDone = (txIndex == 9 && bitDone == 1)? 1:0;

endmodule
