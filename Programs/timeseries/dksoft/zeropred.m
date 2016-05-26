% zeropred.m                       7 June 1993
% Program to calculate prediction error from time-series.
% Calculates mean error of zeroth order prediction of entire series.
% Mean error is normalized by dividing by error of constant
%   prediction = mean of series, to get NPE (norm. pred. error).

%To use, either activate the following statement (to enter the
%filename prefix of  abc.dat containing the time series from the
%keyboard) or set filename='abc'; before running this m-file.

%filename = input('Filename of .DAT file to import:  ','s')
eval(['load ',filename,'.dat'])
eval(['s = ',filename,';'])
filename
N = length(s);

k=10;
%k = input('Number of nearest neighbors:   ');
%k=fix(0.02*N);
Hmax=10;
%Hmax = input('Maximum Horizon:  ');
L=1;
%L = input('Time Lag:  ');
E=3;
%E = input('Embedding Dimension:  ');
huge=1000000000000000000;

% Embed s for embedding dimension E
   for j = 1:E
       for i = 1:(N - (E - 1) * L)
          xx(i,j) = s(i + (j-1)*L);
       end
   end
% Find mean of portion of time series to be predicted

   me=mean(xx(1+(E-1)*L+2*Hmax:N-(E-1)*L,E));
   End=N-(E-1)*L-Hmax;

% Find k nearest neighbors of xx(j)

   for j = 1:End
%for j=1:100
       m1=max(0,j-50); m2=min(j+50,End+1);
       for i = 1:m1
            a=xx(i,1:E)-xx(j,1:E);
            normE(i) = a*a';
       end
% Don't want near-in-time nbrs helping
       for i = m1+1:m2-1
            normE(i) = huge;
       end
       for i = m2:End
            a=xx(i,1:E)-xx(j,1:E);
            normE(i) = a*a';
       end

       [sorted,index] = sort(normE);

%  xx(index(1:k),1:E) are the k nearest neighbors of xx(j)
%  Next find the zeroth order prediction for xx(j+H,E)
%  Record the prediction error in the error array
%  Record the prediction error of predicting the mean in merror
     for H=1:Hmax
       tot = 0;
       for q = 1:k
           tot= tot+ xx(index(q)+H,E);
       end
       tot=tot/k;
       error(j,H)=xx(j+H,E)-tot;
       merror(j,H)=xx(j+H,E)-me;
     end  %  end of H loop
    end    % end of loop for each index point

%    Compute normalized mean prediction error

   for H=1:Hmax
     above=norm(error(:,H));
     below=norm(merror(:,H));
     npe(H,E) = above/below;
   end

%    Write the horizon and normalized mean prediction error to disk

   outmatrix=1:H; outmatrix=outmatrix';
   outmatrix=[outmatrix npe(1:Hmax,E:2:E)];
   eval(['save ',filename,'.p0 outmatrix -ascii'])      
   clear xx;clear x;clear y;clear normE; 
end

