# Game-of-MIDI
A musical implementation of John Conway's *Game of Life* in MATLAB.<br>
Game of MIDI generates and plays MIDI notes based on the game of life simulation.<br>
[What is the game of life?](https://www.youtube.com/watch?v=R9Plq-D1gEk) <br>


[Game of MIDI example 1](https://www.youtube.com/watch?v=GayJycHz04s)
<br>
[Game of MIDI example 2](https://www.youtube.com/watch?v=ss9j2fiBrcU&ab_channel=Kzra)

**Installation:**
<br>
 
Run `Game of MIDI.mlappinstall` to install Game-of-MIDI as a MATLAB app. <br>
Run `Game_of_MIDI_installer.exe` to install Game-of-MIDI as a standalone application on windows (you will be prompted to download the MATLAB runtime if you do not already have it). 


**User guide:**

<img src="https://github.com/Kzra/Game-of-MIDI/blob/master/user_guide.png" alt="User guide" width="850"/>

**Rules:** 
<br>
If a cell is in a live state it will remain alive if there are 2 or 3 alive cells orthogonal to it.<br>
If a cell is in a dead state it will become alive if there are 3 alive cells orthogonal to it. 
<br>


**Happy MIDI'ing!**

**Acknowledgements:**
<br>
The writemidi and matrix2midi MATLAB functions used to write MIDI files were written by [Ken Schutte](https://kenschutte.com/midi#Writing%20MIDI).
Thanks to Mara Uboldi for the logo design. 

*Version 1.0* Last updated 09/09/2020

<img src="https://github.com/Kzra/Game-of-MIDI/blob/master/Game_of_midi.png" alt="Game_of_MIDI" width="650"/>
