%% Game of Midi 
%% Constants 
kernel = [1,1,1;1,0,1;1,1,1]; %2D othogonal kernel
life_matrix = false(127,127); %logical array, these are the possible values midi can take for note (0-127) and amplitude(1-127)
[m,n] = size(life_matrix); %dimensions of the array
bw = [0 0 0; 1 1 1]; %colormap for image function
max_phony = 100; %maximum polyphony (maximum number of voices that can play at once)
active_states = cell(max_phony,1) ; %cell array to store current active states, limit to max_phony
iter_number = 10; %number of iterations of game of life to simulation
channel = 1; %MIDI Channel
midi_notes = NaN(max_phony,iter_number); %array to store midi notes in
midi_vel = NaN(max_phony,iter_number); %array to store midi velocities in
midi_time = NaN(max_phony,iter_number); %array to store midi time stamps in
freq = zeros(max_phony,1); %array to store the frequencies of a single iteration
amp = zeros(max_phony,1); %array to store the amplitude of a a single iteration
fs = 8192; %the sample rate (how many times the waveform is sampled per second) in Hz
note_len = .2; %the note duration in seconds 
samples = linspace(0,note_len,fs*note_len); %each note will play for 2 seconds == 30bpm 
wave_type = 'square'; %wave_type to play, can either be square, triangle or sine
wait_for_note = true; %wait till note has played before starting next iteration


%% Initialise projection 
image(life_matrix,'CDataMapping','direct','ButtonDownFcn',@lineCallback);
ax = gca;
ax.XTick = [];
ax.YTick = [];
colormap(bw)
hold on 

%% Wait for User Input
input('Ready?')
life_matrix = ax.Children.CData; %access the CData to recreate the current_state of the life_matrix
tic 
for iter = 1:iter_number
%% Play the Game of Life and update the life matrix. Save the position of live elements in active states    
ac = 0; %index for storing the number of active elements 
active_states(:) = {[0 0]}; %reset active states 
freq(:) = 0; %reset the frequencies
amp(:) = 0; %reset the amplitudes
plim = false; %reset the phony limit 
scores = conv2(life_matrix,kernel,'same'); %2d convolution operation to calculate orthogonal states
    for i = 1:m
        for j = 1:n
            life_matrix(i,j) = life_rules(life_matrix(i,j),scores(i,j));
            if life_matrix(i,j) == 1
                ac = ac + 1; 
                if ac > max_phony %ensure no more than max_phony 
                    ac = ac - max_phony; %if more than max_phony, reset ac to 1
                    plim = true; %the phony limit has been reached
                end
                active_states(ac) = {[i,j]};
            end
        end
    end
%% Display the updated life matrix. Cycle through active states and compose corresponding MIDI messages 
    image(life_matrix,'CDataMapping','direct') %replot the image
    drawnow limitrate %limit to 20 fps
    if plim == true %if the phony limit was reached, we need to set the ac index to max_phony
        ac = max_phony;
    end
    midi_stamp = toc; %time stamp for the current array of midi notes (so they all play the same time)
    if ac > 0   %if there are any live cells 
            for i = 1:ac
                note = active_states{i}(2); %note on the x axis
                velocity = 128 - active_states{i}(1); % vel on the y axis 
                %as the matrix is 127 * 127 we can directly convert index values to
                %midi note and amplitude 
                midi_notes(i,iter) = note;
                midi_vel(i,iter) = velocity;
                midi_time(i,iter) = midi_stamp;
                % convert midi note value to frequency using A(Midi = 69) = 440Hz
                % convention and equal temperament tuning (/12)
                freq(i,1) = 440 * 2^((note-69)/12); %use 2^ as octaves are double in frequency each time
                amp(i,1)  = velocity/127; %amplitude ranges from 0 to 1 
            end
    %% Sound a single note or chord based on the midi message 
    if strcmp(wave_type,'square') %default behaviour
    wave = sign(sin(2*pi*freq*samples)) .* amp; %multiply the frequencies by amplitude to ensure they have the correct loudness 
    elseif strcmp(wave_type,'triangle')
    wave = sawtooth(2*pi*freq*samples) .* amp;
    elseif strcmp(wave_type,'sine')
    wave = sin(2*pi*freq*samples) .* amp;
    end
    phony = sum(wave); %sum all the waves playing at once to acheive polyphony, normalise between 1 and 0     
    phony = phony/max(phony); % normalise so rate is max [-1 +1] to acheive maximum loudness
    sound(phony,fs) % play the wave with sample rate fs
    if wait_for_note 
        wave_stamp = toc; %moving wave_stamp to the start of the play loop is one way of accounting for proc time (by using the current proc time for next iteration). But seems unstable. 
        while toc - wave_stamp < note_len + .2 %allow a fifth of a second to play the note
        end
    end
    end
end


function lineCallback(src,evt)
   index = round(evt.IntersectionPoint(1:2)); %round the coordinates of the click to nearest whole number
   if src.CData(index(2),index(1)) == 0
    src.CData(index(2),index(1)) = 1; 
   else
    src.CData(index(2),index(1)) = 0;    
   end
end

function state = life_rules(life,score)
  if score == 3 %a new life is created or sustained
     state = 1; 
  elseif life == 1 && score == 2 %a life is sustained
     state = 1;
  else 
     state = 0; %life dies 
  end
end
