for d=0.1:0.1:0.9
g = 255*(1-d)*ones(500,500);
h = dither(uint8(g));
imshow(h);
imwrite(h,['HalftoneMask',num2str(d*10),'.tif']);
end