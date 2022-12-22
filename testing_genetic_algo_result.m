%function f=testing_genetic_algo_result(Xij)
clc
clear

W=15;
T=4;
t=7;
r=9;
w=10;
n=12;
Tj=[16 18 25 10];
Uj=[2 3 4 1];
%Total Advertising Budget=B
B=2100.000; % Dollar
%TV expenditure share=p1
p1=0.55;
%RADIO expenditure share=p2
p2=0.15;
%NEWSPAPER expenditure share=p3
p3=0.25;
Xij=[15   33   97   12;   
8   15   97   42;   
17   101   0   15;   
0   14   59   22;   
25   20   44   0;   
13   28   50   32;   
37   0   63   10;   
7   22   20   0;   
13   12   83   6;   
33   16   407   7;   
27   36   407   32;   
9   16   132   13;   
9   39   38   149;   
14   33   149   99;   
10   57   304   8];
              Pij=[0.21 0.12 0.12 0.23; % ATV-01
                   0.35 0.24 0.12 0.07; % BTV-02
                   0.19 0.04 0.00 0.19; % CTV-03
                   0.00 0.26 0.19 0.13; % DTV-04
                   0.13 0.19 0.25 0.00; % ETV-05
                   0.24 0.14 0.22 0.09; % FTV-06
                   0.09 0.00 0.18 0.28; % GTV-07
                   0.39 0.17 0.47 0.00; % K RADIO-08
                   0.24 0.31 0.14 0.43; % L RADIO-09
                   0.10 0.23 0.03 0.35; % INTERNET-10
                   0.12 0.11 0.03 0.09; % P NEWSPAPER-11
                   0.32 0.23 0.09 0.21; % R NEWSPAPER-12
                   0.32 0.10 0.28 0.02; % BILLBOARD-13
                   0.23 0.12 0.08 0.03; % PRINTINGS-14
                   0.29 0.07 0.04 0.32; % EMAIL-15 
                   ];
%               Xij=[0 0 0 0; % ATV-01
%                    7 0 0 0; % BTV-02
%                    6 1 0 2; % CTV-03
%                    0 5 0 0; % DTV-04
%                    0 0 6 0; % ETV-05
%                    2 0 5 0; % FTV-06
%                    0 0 0 0; % GTV-07
%                    2 0 8 0; % K RADIO-08
%                    0 15 0 0; % L RADIO-09
%                    0 0 0 12; % INTERNET-10
%                    2 2 2 2; % P NEWSPAPER-11
%                    1 1 1 1; % R NEWSPAPER-12
%                    1 1 1 1; % BILLBOARD-13
%                    1 1 1 1; % PRINTINGS-14
%                    1 1 1 1; % EMAIL-15 
%                    ];
%                Xij=[0 0 0 8; % ATV-01
%                    0 0 0 7; % BTV-02
%                    0 9 0 0; % CTV-03
%                    0 0 0 5; % DTV-04
%                    6 0 0 0; % ETV-05
%                    0 0 0 0; % FTV-06
%                    0 0 3 0; % GTV-07
%                    2 0 8 0; % K RADIO-08
%                    0 14 0 1; % L RADIO-09
%                    0 0 0 12; % INTERNET-10
%                    2 2 2 2; % P NEWSPAPER-11
%                    1 1 1 1; % R NEWSPAPER-12
%                    1 1 1 1; % BILLBOARD-13
%                    1 1 1 1; % PRINTINGS-14
%                    1 1 1 1; % EMAIL-15 
%                    ];
              Cij=[0.140 0.120 0.140 0.150; % ATV-01
                   0.110 0.130 0.150 0.100; % BTV-02
                   0.100 0.043 0.100 0.085; % CTV-03
                   0.130 0.130 0.130 0.125; % DTV-04
                   0.130 0.135 0.140 0.140; % ETV-05
                   0.150 0.150 0.150 0.150; % FTV-06
                   0.160 0.160 0.160 0.180; % GTV-07
                   0.015 0.010 0.010 0.010; % K RADIO-08
                   0.025 0.020 0.020 0.027; % L RADIO-09
                   0.050 0.050 0.050 0.065; % INTERNET-10
                   0.100 0.100 0.100 0.100; % P NEWSPAPER-11
                   0.160 0.160 0.160 0.160; % R NEWSPAPER-12
                   0.096 0.096 0.096 0.096; % BILLBOARD-13
                   0.020 0.020 0.020 0.020; % PRINTINGS-14
                   0.008 0.008 0.008 0.008; % EMAIL-15 
                   ];
%  for i=1:15
%      for j=1:4
%          if(j==1) Pij(i,j)=Pij(i,j)*2;
%          elseif(j==2) Pij(i,j)=Pij(i,j)*3;
%          elseif(j==3) Pij(i,j)=Pij(i,j)*4;
%          else
%                  Pij(i,j)=Pij(i,j)*1;
%          end
%      end
%  end
%               Xij=[0 0 0 8; % ATV-01
%                    7 0 0 0; % BTV-02
%                    9 0 0 0; % CTV-03
%                    0 5 0 0; % DTV-04
%                    0 0 6 0; % ETV-05
%                    8 0 0 0; % FTV-06
%                    0 0 0 3; % GTV-07
%                    0 0 10 0; % K RADIO-08
%                    0 0 0 15; % L RADIO-09
%                    0 0 0 12; % INTERNET-10
%                    2 2 2 2; % P NEWSPAPER-11
%                    1 1 1 1; % R NEWSPAPER-12
%                    1 1 1 1; % BILLBOARD-13
%                    1 1 1 1; % PRINTINGS-14
%                    1 1 1 1; % EMAIL-15 
%                    ];
                     
% Xij=[ 8     0     0     0;
%      7     0     0     0;
%      9     0     0     0;
%      0     5     0     0;
%      0     0     6     0;
%      0     0     8     0;
%      0     0     0     3;
%      0     0    10     0;
%      0    15     0     0;
%      0     0     0    12;
%      2     2     2     2;
%      1     1     1     1;
%      1     1     1     1;
%      1     1     1     1;
%      1     1     1     1];

% Xij= [  0     0     4     4;
%      6     1     0     0;
%      0     6     0     3;
%      0     5     0     0;
%      0     0     6     0;
%      5     3     0     0;
%      3     0     0     0;
%      0     0    10     0;
%      1    10     2     2;
%      1     0     0    11;
%      2     2     2     2;
%      1     1     1     1;
%      1     1     1     1;
%      1     1     1     1;
%      1     1     1     1];
% Xij= [0    8    0      0;
%      5     0     0     2;
%      0     9     0     0;
%      0     5     0     0;
%      0     0     6     0;
%      0     0     0     0;
%      0     0     0     0;
%      0     0    10     0;
%      0    15     0     0;
%      0     0     0    12;
%      2     2     2     2;
%      1     1     1     1;
%      1     1     1     1;
%      1     1     1     1;
%      1     1     1     1];
 
%     Xij= [1     0     0     1;
%      7     0     0     0;
%      0     1     0     0;
%      0     0     5     0;
%      0     2     4     0;
%      6     0     2     0;
%      1     0     1     0;
%      0     0    10     0;
%      1     6     0     8;
%      1    10     1     0;
%      2     2     2     2;
%      1     1     1     1;
%      1     1     1     1;
%      1     1     1     1;
%      1     1     1     1]
%      Xij= [1     0     0     1;
%      7     0     0     0;
%      0     1     0     0;
%      0     0     5     0;
%      0     2     4     0;
%      6     0     2     0;
%      1     0     1     0;
%      0     0    10     0;
%      0     0     0     15;
%      1    10     1     0;
%      2     2     2     2;
%      1     1     1     1;
%      1     1     1     1;
%      1     1     1     1;
%      1     1     1     1]
 disp('best Combination:');
 disp(Xij);
 disp('Best Fitness: ');

               
 VVV=0;
 for j=1:T
      MMM=1;
     for i=1:W
         
         MMM=MMM*(1-Pij(i,j))^Xij(i,j);
     end
     VVV=VVV+Uj(j)*(1-MMM);
     
 end
 format long
 disp(VVV);
 disp('');
 disp('');
 
 disp(sum(Xij));
 
 TV_Budget=0;
 for j=1:T
     for i=1:t
         TV_Budget=TV_Budget+Cij(i,j)*Xij(i,j);
     end
 end
 if(TV_Budget*10<= B*p1)
     disp('Ok TV Budget');
     disp(ceil(TV_Budget*10));
     
 else
     disp('Not Ok TV Budget');
      disp(TV_Budget*10);
      disp(ceil(TV_Budget*10));
 end
 %---------------------------------------
  Radio_Budget=0;
 for j=1:T
     for i=t+1:r
         Radio_Budget=Radio_Budget+Cij(i,j)*Xij(i,j);
     end
 end
 if(Radio_Budget*10<= B*p2)
     disp('Ok Radio Budget');
      disp(ceil(Radio_Budget*10));
 else
     disp('Not Ok Radio Budget');
     disp(ceil(Radio_Budget*10));
 end
  %---------------------------------------
  Newspaper_Budget=0;
 for j=1:T
     for i=w+1:n
         Newspaper_Budget=Newspaper_Budget+(1/T)*Cij(i,j)*Xij(i,j);
     end
 end
 if(Newspaper_Budget*10<= B*p3)
     disp('Ok Newspaper Budget');
     disp(ceil(Newspaper_Budget*10));
 else
     disp('Not Ok Newspaper Budget');
     disp(ceil(Newspaper_Budget*10));
 end
   %---------------------------------------
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
     disp('Ok Total Budget');
     disp('Total Budget: ');
     disp(ceil(Total_Budget*10));
 else
     disp('Not Ok Total Budget');
     disp(ceil(Total_Budget*10));
 end
 %end
 
 


                   
                