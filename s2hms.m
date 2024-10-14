function [hours,minutes, seconds] = s2hms(totalSeconds)
    % Convert total seconds to hours, minutes, and seconds
    hours = floor(totalSeconds / 3600);
    remainingSeconds = mod(totalSeconds, 3600);
    minutes = floor(remainingSeconds / 60);
    seconds = floor (mod(remainingSeconds, 60));
end

