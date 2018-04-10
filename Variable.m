% Image (RGB)--------------------------------------------------------------
Aim = imread('angrybird312.jpg');   % AngryBird with 312x312 pixels => 312x312x3 double
Aim = double(Aim); 
Aim = Aim/255;  
Aim156 = imread('angrybird156.jpg'); % AngryBird with 156x156 pixels => 156x156x3 unit8
Aim156 = double(Aim156); 
Aim156 = Aim156/255;    
% QR-----------------------------------------------------------------------
load('QR39.mat')
% Halftone Hi--------------------------------------------------------------
% H1 = imread('HalftoneMask1.tif');
% H2 = imread('HalftoneMask2.tif');
% H3 = imread('HalftoneMask3.tif');
% H4 = imread('HalftoneMask4.tif');
% H5 = imread('HalftoneMask5.tif');
% H6 = imread('HalftoneMask6.tif');
% H7 = imread('HalftoneMask7.tif');
% H8 = imread('HalftoneMask8.tif');
% H9 = imread('HalftoneMask9.tif');
