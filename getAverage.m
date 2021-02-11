%Alex Yeh 2/5/2021
%HT Lab 1

%finds average value for raw signal
%bitalino raw data starts header files with # 
%and has accelerometer data on 6th column
function g=getAverage(filename,time,sr)

    fid = fopen(filename);
    aval=zeros(time*sr,1);
    r=1;

    %loop through file
    while (~feof(fid)&&r<=time*sr)
          txtLine = fgetl(fid);

          %ignore headers that start with '#'
          if ~strncmpi(txtLine,'#',1)
              C=strsplit(txtLine);
              aval(r)=str2double(C(6));
              r=r+1;
          end
    end
    fclose(fid);
    g=mean(aval);
end