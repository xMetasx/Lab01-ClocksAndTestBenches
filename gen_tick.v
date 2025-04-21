// Digital
//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: Johncarlo Jalomo
// Email: jjalo004@ucr.edu
// 
// Assignment name: Lab 1- Clocks and Test Benches
// Lab section: 1
// TA: Sakshar Chakravarty
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

`timescale 1ns / 1ps

module gen_tick #(
    parameter SRC_FREQ = 5000,
    parameter TICK_FREQ = 1
)(
    input src_clk,
    input enable,
    output reg tick
);

    // Internal counter
    reg [31:0] counter = 0;

    // Calculate how many source clock cycles are needed for one tick cycle
    // (Assuming we want a 50% duty cycle: half high, half low)
    localparam integer COUNT_MAX = SRC_FREQ / (2 * TICK_FREQ);

    always @(posedge src_clk) begin
        if (!enable) begin
            tick <= 0;
            counter <= 0;
        end else begin
            if (counter == COUNT_MAX - 1) begin
                tick <= ~tick; // Toggle the tick
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule

