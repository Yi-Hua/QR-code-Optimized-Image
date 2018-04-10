function H = Halftone(pc)
% Halftone Mask
% pc : ?? 
g = 255*(1-pc)*ones(500,500); 
H = dither(uint8(g));
end