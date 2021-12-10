function volt = pix2volt(pix, iso)
% convert vector of pix values to volts 

volt = pix.*0.459./1023;