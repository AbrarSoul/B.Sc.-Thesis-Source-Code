function OK=Check(Xij)
disp('check');
%disp(Xij);

%DATA SET
%No of Types
W=15;
%No of Targets
T=4;
%No of TV Channels
t=7;
%No of Radio Channels, t+1:r = r-(t+1)
r=9;
%No of Renewable Media Type=w ; No of Internet, r+1:w = w-(r+1)
w=10;
%No of Newspaper, w+1:n= n-(w+1)
n=12;
%No of Ads Required
%Target Audience 1  2  3  4
            Tj=[16 18 25 10];

%Segment Weights
%Target Audience 1 2 3 4
             Uj=[2 3 4 1]; % Priority of targets

%Total Advertising Budget=B
B=75.000; % Dollar
%TV expenditure share=p1
p1=0.55;
%RADIO expenditure share=p2
p2=0.15;
%NEWSPAPER expenditure share=p3
p3=0.25;
%ad Capacity
Wi=Ad_Capacity();
         
%Probability Table 
Pij=Probability_Table();

% %Cost Table
Cij=Cost_Table();
OK=1;
  %No of Ads Required Check-----------------------------------------------
  sum_of_columns=sum(Xij);
  for temp=1:length(sum_of_columns)
      if(sum_of_columns(1,temp)< Tj(1,temp))
          OK=0;
%           disp('Tj Problem');
          return;
      end
  end
  %TV Budget---------------------------------------------------------------
     TV_Budget=0;
     for j=1:T
         for i=1:t
             TV_Budget=TV_Budget+Cij(i,j)*Xij(i,j);
         end
     end
     if(TV_Budget*10 <= B*p1)
%          disp('Ok TV Budget');
         OK=1;
     else
%          disp('Not Ok TV Budget');
         OK=0;
         return;
     end
   % Radio Budget--------------------------------------------------------
     Radio_Budget=0;
     for j=1:T
         for i=t+1:r
             Radio_Budget=Radio_Budget+Cij(i,j)*Xij(i,j);
         end
     end
     if(Radio_Budget*10<= B*p2)
%          disp('Ok Radio Budget');
         OK=1;
     else
%          disp('Not Ok Radio Budget');
         OK=0;
         return;
     end
   % Newspaper Budget---------------------------------------------------
     Newspaper_Budget=0;
     for j=1:T
         for i=w+1:n
             Newspaper_Budget=Newspaper_Budget+(1/T)*Cij(i,j)*Xij(i,j);
         end
     end
     if(Newspaper_Budget*10<= B*p3)
%          disp('Ok Newspaper Budget');
         OK=1;
     else
%          disp('Not Ok Newspaper Budget');
         OK=0;
         return;
     end
   % Total Budget---------------------------------------------------------
     Total_Budget=0;
     for j=1:T
         one=0;
         two=0;
         for i=1:w
             one=one+Cij(i,j)*Xij(i,j);
         end
         for i=w+1:W
             two=two+(1/T)*Cij(i,j)*Xij(i,j);
         end
         Total_Budget=Total_Budget+one+two;
     end
     if(Total_Budget*10<= B)
%           disp('Ok Total Budget');
          OK=1;
     else
%           disp('Not Ok Total Budget');
          OK=0;
          return;
     end
    % Total Budget---------------------------------------------------------
end
    




