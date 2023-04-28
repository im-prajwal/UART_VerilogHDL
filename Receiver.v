`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer: Prajwal H N
// 
// Create Date: 21.04.2023 10:49:56
// Module Name: Receiver
// Project Name: UART Implementation using Verilog HDL
// Description: 
//////////////////////////////////////////////////////////////////////////////////

module Receiver(
    input clk, rx, bitDone,
    input [3:0] waitCount,
    output rxDone,
    output [7:0] rxOut
    );
        
reg [9:0] rxData;
integer rxIndex;
integer rxCount = 0;

//Defining States of the Receiver:
parameter IDLE = 0,
          WAIT = 1,
          RECEIVE = 2;
          
//Variable to hold the value of state:
reg [1:0] state = IDLE;

always @(posedge clk)
begin
    case(state)
    
        IDLE:
        begin
            rxData <= 0;
            rxIndex <= 0;
            rxCount <= 0;
            
            if(rx == 0)
                state <= WAIT;    //Start bit = 0 received, hence reception starts.
            else
                state <= IDLE;    //Line is held idle, hence no reception.
        end
        
        WAIT:
        begin
            if(rxCount < waitCount/2)
            begin
                rxCount <= rxCount + 1;
                state <= WAIT;
            end
            
            else
            begin
                rxCount <= 0;
                rxData = {rx, rxData[9:1]};
                state <= RECEIVE;
            end
        end
        
        RECEIVE:
        begin
            if(rxIndex <= 9)
            begin
                if(bitDone == 1)
                begin
                    rxIndex <= rxIndex + 1;
                    state <= WAIT;
                end
            end
               
            else
            begin
                rxIndex <= 0;
                state <= IDLE;
            end
        end
        
        default: state <= IDLE;
        
    endcase
end

assign rxDone = (rxIndex == 9 && bitDone == 1)? 1:0;

assign rxOut = rxData[8:1];

endmodule
