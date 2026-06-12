`timescale 1ns/1ps
interface clock_if;
logic clk,rst;
logic [5:0] sec;
logic [5:0] min;
modport DUT (input clk,rst,
output sec,min);
modport TB (input clk,sec,min,
output rst);
endinterface
