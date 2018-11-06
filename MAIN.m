
clear ;
close all;
clc;

%Formating in order to create shortcguts --> simpler code looking

format shortE;
format compact;

%% Two-dimensional Transient Conduction Problem %%

%% Input data %%

InitialConditions;

%% Previous calculation %%
MeshLambdaGenerator;

%% ITERATE IN TIME %% (explicit)

SettingTimeOps; % Intial configs before starting the resolution

Core; % Core of the program ( computing coefficients, and temperatures applying line-by-line ( TDMA+GAUS SEIDEL) 

%% Plots  %%
Plots;


        



