# Game-of-MIDI
A musical implementation of John Conway's 'Game of Life'. Game of MIDI generates and plays MIDI notes based on the game of life simulation.
[What is the game of life?](https://www.youtube.com/watch?v=R9Plq-D1gEk)


**Usage:**




Click on the axes (127 * 127) to 'seed' the simulation. Each pixel represents a cell in the game of life.<br>
Start - Begin simulation.<br>
Stop/Reset  - Stop stimulation (one press), reset the grid (two press).<br>
Iterations - Number of iterations that the simulation will run. Resets when Stop is pressed.<br>
Wave type - Sound wave to synthesise.<br>
Wait for note - Wait for the current note to stop playing before starting next iteration.<br>
Sample rate - Rate at which waveform is sampled to play audio.<br>
Polyphony - Max number of notes which can play at once.<br>
Note length - Note duration in seconds.<br>
Write MIDI - Write a MIDI file based on the current simulation. The MIDI data is rewritten every time Start is pressed.<br>
Channel - MIDI channel specified in MIDI file.<br>
Tempo - Tempo in BPM specified in MIDI file. Time signature is 4/4 and ticks per 1/4 note is 300.<br>

**Rules:** 
If a cell is in a live state (i.e white) it will remain alive if there are 2 or 3 alive cells orthogonal to it.<br>
If a cell is in a dead state (i.e. black) it will become alive if there are 3 alive cells orthogonal to it. 

Version 1.0

**Acknowledgements:**
Thanks for the writemidi and matrix2midi MATLAB functions written by [Ken Schutte](https://kenschutte.com/midi#Writing%20MIDI).

