`timescale 1ns/1ps
module clock_tb;
logic clk;
clock_if vif();
assign vif.clk = clk;
digital_clock DUT (
.clk(vif.clk),
.rst(vif.rst),
.sec(vif.sec),
.min(vif.min)
);
clock_test test(vif);
initial clk = 0;
always #5 clk = ~clk;
initial begin
$dumpfile("dump.vcd");
$dumpvars;
end
endmodule
