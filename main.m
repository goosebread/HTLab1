%Alex Yeh 2/10/2021
%HT Lab 1

sr1=1000;%1000 Hz sample rate
sr2=100;
sr3=10;

tGrav=10;%10 second gravity sample time
tTest=30;
tADL=60;%for walking and ADL data

%obtains values needed to calibrate accelerometer readings
[gval,gzero]=gcalibrate("gravity_up.txt","gravity_down.txt",tGrav,sr1);

%for comparing 3 sets of data with different sampling rates
graphAccel("test_1000.txt",sr1,"test_100.txt",sr2,"test_10.txt",sr3,tTest,gval,gzero)

%for comparing 2 sets of data
%graphAccel2("walk_arm.txt",sr1,"walk_leg.txt",sr1,tADL,gval,gzero, "Accelerometer on Arm, Walking","Accelerometer on Leg, Walking")

%graphAccel2("teeth_arm.txt",sr1,"teeth_leg.txt",sr1,tADL,gval,gzero, "Accelerometer on Arm, Brushing Teeth","Accelerometer on Leg, Brushing Teeth")
