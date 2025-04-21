Test Case 1 (tick_100_2)
In this test case, the source clock frequency was set to 100 Hz and the output tick frequency was set to 2 Hz. The purpose was to verify that the tick_100_2 output toggled correctly to produce a 2 Hz signal. Over 1000 clock cycles, the test checked that there were exactly 20 transitions of the tick signal and that the tick remained high for approximately 50% of the cycles (500 high cycles). This confirmed that the tick frequency and duty cycle were operating correctly at a low tick frequency.

Test Case 2 (tick_100_5)
In this test case, the source clock frequency remained at 100 Hz while the output tick frequency was changed to 5 Hz. The goal was to check that the tick_100_5 output correctly toggled to create a 5 Hz signal. After running for 1000 clock cycles, the test verified that there were exactly 50 transitions of the tick signal and that the high time remained around 50% (500 high cycles). This validated that the gen_tick module worked properly at a medium tick frequency.

Test Case 3 (tick_100_50)
In this test case, the source clock frequency stayed at 100 Hz, but the output tick frequency was increased to 50 Hz. This tested the system's behavior at a high tick frequency. During the simulation, the test confirmed that there were 500 transitions over 1000 clock cycles, with the tick signal staying high for about 50% of the time (500 high cycles). This showed that the gen_tick module was able to handle high-frequency ticking accurately and maintain a stable duty cycle.

![waveform](<Screenshot 2025-04-20 222145-1.png>)