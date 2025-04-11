//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: Johncarlo Jalomo
// Email: jjalo004@ucr.edu
// 
// Assignment name: Lab 1
// Lab section: 
// TA: 
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

//===================================================
// <= non blocking
// cnt <= cnt + 1
// tick_cnt = src / 2 / tick_frequency
//===================================================

module gen_tick # ( parameter SRC_FREQ = 5000, parameter TICK_FREQ = 1) (
    input src_clk,
    input enable,
    output tick
);

// Declare registers and wires here

always @(posedge src_clk) begin
    // put your code for the multiplier here
end

// Change this assign statement to the actual tick value
assign tick = src_clk;

endmodule
