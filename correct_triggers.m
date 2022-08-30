function correct_triggers(filepath)
% Shifts event triggers to the nearest audio trigger
% and automatically saves in new file with a 'corrected_'
% prefix (needs eeglab w/ biosig plug-in).
%
% Parameters: filepath = path to .bdf file
% 
% @author   AliTafakkor
% @version  1.0

    % Load the file
    [data, hdr] = sload(filepath, 'OVERFLOWDETECTION:OFF');
    % Extract event types and positions
    event_typ = hdr.EVENT.TYP;
    event_pos = hdr.EVENT.POS;

    % Separate upper byte events (matlab sent triggers)
    index = find(event_typ >= 256);
    
    % Correct event times and remove extra triggers
    corrected_event_typ = event_typ(index);
    corrected_event_pos = zeros(length(index), 1);
    for i = 1:length(index)
        curr_ind = index(i);
    
        if i == length(index)
            nxt_ind = length(event_typ);
        else
            nxt_ind = index(i+1);
        end
    
        for j = curr_ind:nxt_ind
            if event_typ(j) == 32 || event_typ(j) == 64 % Change for any arbitrary trigger
                corrected_event_pos(i) = event_pos(j);
                break;
            elseif j == nxt_ind
                corrected_event_pos(i) = event_pos(i);
            end
        end
    end
    
    % Forming new header
    corrected_hdr = hdr;
    corrected_hdr.FileName = ['corrected_' hdr.FileName];
    corrected_hdr.EVENT.TYP = corrected_event_typ;
    corrected_hdr.EVENT.POS = corrected_event_pos;
    corrected_hdr.EVENT.CHN = zeros(length(index), 1);
    corrected_hdr.EVENT.DUR = zeros(length(index), 1);
    
    % Adding status channel to the data
    status_channel = zeros(size(data,1), 1);
    status_channel(corrected_event_pos) = corrected_event_typ/256; % Shift MSB byte to LSB
    data = [data, status_channel];
    
    % Open new file to write
    corrected_hdr = sopen(corrected_hdr, 'w');
    swrite(corrected_hdr, data);
    sclose(corrected_hdr);
end