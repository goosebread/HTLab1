%Alex Yeh 2/10/2021
%HT Lab 1

%See graphAccel
%plots 2 sets of data instead of 3
function graphAccel2(dataFile1,sr1,dataFile2,sr2,time,gval,gzero, title1, title2)
    fid1 = fopen(dataFile1);
    aval1=zeros(time*sr1,1);
    
    fid2 = fopen(dataFile2);
    aval2=zeros(time*sr2,1);   
   
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

    
    %time in seconds
    time1 = (0:time*sr1-1)./sr1;
    time2 = (0:time*sr2-1)./sr2;

    %acceleration in m/s^2
    accel1 = (aval1-gzero).*(9.81/gval);
    accel2 = (aval2-gzero).*(9.81/gval);
   
    Y1=fft(accel1);
    %scaled power spectrum
    P1=(Y1.*conj(Y1))/(sr1*time);
    f1 = (0:(time*sr1/2))/time;
    
    Y2=fft(accel2);
    P2=(Y2.*conj(Y2))/(sr2*time);
    f2 = (0:(time*sr2/2))/time;
    
    
    figure
    hold on
    
    subplot(2,1,1)
    plot(time1,accel1)
    xlabel('Time (s)')
    ylabel('Acceleration (m/s^2)')
    title(title1)

    subplot(2,1,2)
    plot(time2,accel2)
    xlabel('Time (s)')
    ylabel('Acceleration (m/s^2)')
    title(title2)

    
    figure
    hold on
    
    subplot(2,1,1)
    plot(f1,P1(1:sr1*time/2+1))
    xlabel('Frequency (Hz)')
    xlim([0 5]);
    ylim([0,5000]);%30,000 for walking
    ylabel('Signal Power')
    title({'Power Spectrum' ,append('SR= ',num2str(sr1),' Hz')})
    
    subplot(2,1,2)
    plot(f2,P2(1:sr2*time/2+1))
    xlabel('Frequency (Hz)')
    xlim([0 5]);
    ylim([0,5000]);%30,000 for walking
    ylabel('Signal Power')
    title({'Power Spectrum' ,append('SR= ',num2str(sr2),' Hz')})

end