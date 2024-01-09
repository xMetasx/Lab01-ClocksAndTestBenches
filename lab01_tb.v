//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: 
// Email: 
// 
// Assignment name: 
// Lab section: 
// TA: 
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

`timescale 1ns / 1ps

module lab01_tb;
    // Inputs
    reg clk;
    reg reset;

    // Outputs


    // -------------------------------------------------------
    // Setup output file for possible debugging uses
    // -------------------------------------------------------
    initial
    begin
        $dumpfile("lab01.vcd");
        $dumpvars(0);
    end

    // Declare wires for each unit under test
    wire tick_100_2;
    wire tick_100_5;
    wire tick_100_50;

    // -------------------------------------------------------
    // Instantiate at least 3 Units Under Test (UUTs)
    // -------------------------------------------------------
    gen_tick #(.SRC_FREQ(100), .TICK_FREQ(2)) uut_100_2 (
        .src_clk(clk),
        .enable(1'b1) ,  
        .tick(tick_100_2)
    );

    // -------------------------------------------------------
    // Instantiate at least 2 more units here 
    // -------------------------------------------------------

    initial begin 
    
        clk = 0; reset = 1; #50; 
        clk = 1; reset = 1; #50; 
        clk = 0; reset = 0; #50; 
        clk = 1; reset = 0; #50; 
         
        forever begin 
            clk = ~clk; #50; 
        end 
    end 
    
    integer totalTests = 0;
    integer failedTests = 0;

    integer count = 0;
    integer high_count = 0;
    reg last_tick = 0;
    integer transition_count = 0;

    initial begin // Test suite
        // Reset
        @(negedge reset); // Wait for reset to be released (from another initial block)
        @(posedge clk);   // Wait for first clock out of reset 
        #10; // Wait 10 cycles 

        // Initial test cases
        // ---------------------------------------------
        // Testing Source clock 100Hz, Tick 2Hz 
        // --------------------------------------------- 
        $write("Test Source clock 100Hz, Tick 2Hz ... ");
        totalTests <= 1;
        while(count < 1000) begin
            @(posedge clk);
            if (last_tick == 0 & tick_100_2 != last_tick) begin
                transition_count <= transition_count + 1;
            end
            count = count + 1;
            if (tick_100_2 == 1) begin
                high_count <= high_count + 1;
            end
            last_tick <= tick_100_2;
        end

        if (high_count == 500 & transition_count == 20) begin
            $display("PASSED");
        end else begin
            $display("FAILED");
            failedTests = failedTests + 1;
        end
        $display("Load (%d/%d): %0.2f", high_count, count, 1.0 * high_count / count);
        $display("Transition count: %d", transition_count);
        
		// Add more tests here

        // Re-initialize counters for each test
        last_tick = 0;
        transition_count = 0;
        count = 0;
        high_count = 0;

        // Copy the test case above at least 2 more times to test each unit under test
        // Be sure to change the expected counts to match the configuration of the UUT

        $finish;
    end
endmodule