# Game-of-MIDI
A musical implementation of John Conway's 'Game of Life'. Game of MIDI generates and plays MIDI notes based on the game of life simulation.

**Usage: **
Usage: 
Click on the axes (127 * 127) to 'seed' the simulation. Each pixel represents a cell in the game of life. 
Start - Begin simulation.
Stop/Reset  - Stop stimulation (one press), reset the grid (two press).
Iterations - Number of iterations that the simulation will run. Resets when Stop is pressed. 
Wave type - Sound wave to synthesise. 
Wait for note - Wait for the current note to stop playing before starting next iteration.
Sample rate - Rate at which waveform is sampled to play audio . 
Polyphony - Max number of notes which can play at once.
Note length - Note duration in seconds. 
Write MIDI - Write a MIDI file based on the current simulation. The MIDI data is rewritten every time Start is pressed.
Channel - MIDI channel specified in MIDI file. 
Tempo - Tempo in BPM specified in MIDI file. Time signature is 4/4 and ticks per 1/4 note is 300. 

Rules: 
If a cell is in a live state (i.e white) it will remain alive if there are 2 or 3 alive cells orthogonal to it. 
If a cell is in a dead state (i.e. black) it will become alive if there are 3 alive cells orthogonal to it. 

Version 1.0

**Acknowledgements: **
