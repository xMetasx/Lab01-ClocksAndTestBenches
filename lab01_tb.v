//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: Johncarlo Jalomo
// Email: jjalo004@ucr.edu
// 
// Assignment name: LAB1 - ClocksandTestBenches
// Lab section: 1
// TA: Sakshar Chakravarty
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

    // -------------------------------------------------------
    // Setup output file for possible debugging uses
    // -------------------------------------------------------
    initial begin
        $dumpfile("lab01.vcd");
        $dumpvars(0);
    end

    // Declare wires for each unit under test
    wire tick_100_2;
    wire tick_100_5;
    wire tick_100_50;

    // -------------------------------------------------------
    // Instantiate 3 Units Under Test (UUTs)
    // -------------------------------------------------------
    gen_tick #(.SRC_FREQ(100), .TICK_FREQ(2)) uut_100_2 (
        .src_clk(clk),
        .enable(1'b1),  
        .tick(tick_100_2)
    );

    gen_tick #(.SRC_FREQ(100), .TICK_FREQ(5)) uut_100_5 (
        .src_clk(clk),
        .enable(1'b1),  
        .tick(tick_100_5)
    );

    gen_tick #(.SRC_FREQ(100), .TICK_FREQ(50)) uut_100_50 (
        .src_clk(clk),
        .enable(1'b1),  
        .tick(tick_100_50)
    );

    // -------------------------------------------------------
    // Clock generation
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
    
    // -------------------------------------------------------
    // Test suite variables
    // -------------------------------------------------------
    integer totalTests = 0;
    integer failedTests = 0;

    integer count = 0;
    integer high_count = 0;
    reg last_tick = 0;
    integer transition_count = 0;

    // -------------------------------------------------------
    // Test suite
    // -------------------------------------------------------
    initial begin 
        // Wait for reset release
        @(negedge reset); 
        @(posedge clk);   
        #10; // Wait extra cycles if needed 

        // -------------------------------------------------------
        // Test 1: Source clock 100Hz, Tick 2Hz
        // Expect: 2 ticks per 100 cycles -> in 1000 cycles, 20 ticks
        // -------------------------------------------------------
        $write("Test Source clock 100Hz, Tick 2Hz ... ");
        totalTests = totalTests + 1;
        while (count < 1000) begin
            @(posedge clk);
            if (last_tick == 0 && tick_100_2 != last_tick) begin
                transition_count = transition_count + 1;
            end
            count = count + 1;
            if (tick_100_2 == 1) begin
                high_count = high_count + 1;
            end
            last_tick = tick_100_2;
        end

        if (high_count == 500 && transition_count == 20) begin
            $display("PASSED");
        end else begin
            $display("FAILED");
            failedTests = failedTests + 1;
        end
        $display("Load (%d/%d): %0.2f", high_count, count, 1.0 * high_count / count);
        $display("Transition count: %d", transition_count);

        // Reset counters for next test
        last_tick = 0;
        transition_count = 0;
        count = 0;
        high_count = 0;

        // -------------------------------------------------------
        // Test 2: Source clock 100Hz, Tick 5Hz
        // Expect: 5 ticks per 100 cycles -> in 1000 cycles, 50 ticks
        // -------------------------------------------------------
        $write("Test Source clock 100Hz, Tick 5Hz ... ");
        totalTests = totalTests + 1;
        while (count < 1000) begin
            @(posedge clk);
            if (last_tick == 0 && tick_100_5 != last_tick) begin
                transition_count = transition_count + 1;
            end
            count = count + 1;
            if (tick_100_5 == 1) begin
                high_count = high_count + 1;
            end
            last_tick = tick_100_5;
        end

        if (high_count == 500 && transition_count == 50) begin
            $display("PASSED");
        end else begin
            $display("FAILED");
            failedTests = failedTests + 1;
        end
        $display("Load (%d/%d): %0.2f", high_count, count, 1.0 * high_count / count);
        $display("Transition count: %d", transition_count);

        // Reset counters for next test
        last_tick = 0;
        transition_count = 0;
        count = 0;
        high_count = 0;

        // -------------------------------------------------------
        // Test 3: Source clock 100Hz, Tick 50Hz
        // Edge case test: High frequency tick generation
        // Expect: 50 ticks per 100 cycles -> in 1000 cycles, 500 ticks
        // -------------------------------------------------------
        $write("Test Source clock 100Hz, Tick 50Hz ... ");
        totalTests = totalTests + 1;
        while (count < 1000) begin
            @(posedge clk);
            if (last_tick == 0 && tick_100_50 != last_tick) begin
                transition_count = transition_count + 1;
            end
            count = count + 1;
            if (tick_100_50 == 1) begin
                high_count = high_count + 1;
            end
            last_tick = tick_100_50;
        end

        if (high_count == 500 && transition_count == 500) begin
            $display("PASSED");
        end else begin
            $display("FAILED");
            failedTests = failedTests + 1;
        end
        $display("Load (%d/%d): %0.2f", high_count, count, 1.0 * high_count / count);
        $display("Transition count: %d", transition_count);

        // -------------------------------------------------------
        // Test suite summary
        // -------------------------------------------------------
        $display("----------------------------------------");
        $display("Total tests: %d, Failed tests: %d", totalTests, failedTests);
        if (failedTests == 0)
            $display("ALL TESTS PASSED!");
        else
            $display("Some tests FAILED!");

        $finish;
    end

endmodule
