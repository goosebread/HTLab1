%Alex Yeh 2/5/2021
%HT Lab 1

%graphs acceleration data as a function of time in SI units
%future improvement could be done with generalizing number of files graphed
%and generalizing the frequency range for the plots
%
%This function plots the 3 files into 3 subplots for time domain
%and 3 subplots for frequency domain
function graphAccel(dataFile1,sr1,dataFile2,sr2,dataFile3,sr3,time,gval,gzero)
    fid1 = fopen(dataFile1);
    aval1=zeros(time*sr1,1);
    
    fid2 = fopen(dataFile2);
    aval2=zeros(time*sr2,1);   
    
    fid3 = fopen(dataFile3);
    aval3=zeros(time*sr3,1);
   
    %loop through file1
    r=1;
    while (~feof(fid1)&&r<=time*sr1)
          txtLine = fgetl(fid1);

          %ignore headers that start with '#'
          if ~strncmpi(txtLine,'#',1)
              C=strsplit(txtLine);
              %bitalino raw data has accel on 6th col
              aval1(r)=str2double(C(6));
              r=r+1;
          end
    end
    fclose(fid1);
    
    %file 2
    r=1;
    while (~feof(fid2)&&r<=time*sr2)
          txtLine = fgetl(fid2);

          %ignore headers that start with '#'
          if ~strncmpi(txtLine,'#',1)
              C=strsplit(txtLine);
              %bitalino raw data has accel on 6th col
              aval2(r)=str2double(C(6));
              r=r+1;
          end
    end
    fclose(fid2);
    
    %file 3
    r=1;
    while (~feof(fid3)&&r<=time*sr3)
          txtLine = fgetl(fid3);

          %ignore headers that start with '#'
          if ~strncmpi(txtLine,'#',1)
              C=strsplit(txtLine);
              %bitalino raw data has accel on 6th col
              aval3(r)=str2double(C(6));
              r=r+1;
          end
    end
    fclose(fid3);

    
    %time in seconds
    time1 = (0:time*sr1-1)./sr1;
    time2 = (0:time*sr2-1)./sr2;
    time3 = (0:time*sr3-1)./sr3;

    %acceleration in m/s^2
    accel1 = (aval1-gzero).*(9.81/gval);
    accel2 = (aval2-gzero).*(9.81/gval);
    accel3 = (aval3-gzero).*(9.81/gval);
   
    %applies FFT to get spectrum data
    Y1=fft(accel1);
    %scaled power spectrum
    P1=(Y1.*conj(Y1))/(sr1*time);
    %frequency axis
    f1 = (0:(time*sr1/2))/time;
    
    Y2=fft(accel2);
    P2=(Y2.*conj(Y2))/(sr2*time);
    f2 = (0:(time*sr2/2))/time;
    
    Y3=fft(accel3);
    P3=(Y3.*conj(Y3))/(sr3*time);
    f3 = (0:(time*sr3/2))/time;
    
    
    %graphs
    figure(1)
    hold on
    
    subplot(3,1,1)
    plot(time1,accel1)
    xlabel('Time (s)')
    ylabel('Acceleration (m/s^2)')
    title({'Acceleration vs Time for Periodic Test Movement' ,append('SR= ',num2str(sr1),' Hz')})

    subplot(3,1,2)
    plot(time2,accel2)
    xlabel('Time (s)')
    ylabel('Acceleration (m/s^2)')
    title({'Acceleration vs Time for Periodic Test Movement' ,append('SR= ',num2str(sr2),' Hz')})

    subplot(3,1,3)
    plot(time3,accel3)
    xlabel('Time (s)')
    ylabel('Acceleration (m/s^2)')
    title({'Acceleration vs Time for Periodic Test Movement' ,append('SR= ',num2str(sr3),' Hz')})
    
    figure(2)
    hold on
    
    subplot(3,1,1)
    plot(f1,P1(1:sr1*time/2+1))
    xlabel('Frequency (Hz)')
    xlim([0 5]);%5 Hz maximum is due to the 10 Hz sample rate
    ylabel('Signal Power')
    title({'Power Spectrum' ,append('SR= ',num2str(sr1),' Hz')})
    
    subplot(3,1,2)
    plot(f2,P2(1:sr2*time/2+1))
    xlabel('Frequency (Hz)')
    xlim([0 5]);
    ylabel('Signal Power')
    title({'Power Spectrum' ,append('SR= ',num2str(sr2),' Hz')})
    
    subplot(3,1,3)
    plot(f3,P3(1:sr3*time/2+1))
    xlabel('Frequency (Hz)')
    xlim([0 5]);
    ylabel('Signal Power')
    title({'Power Spectrum' ,append('SR= ',num2str(sr3),' Hz')})
end