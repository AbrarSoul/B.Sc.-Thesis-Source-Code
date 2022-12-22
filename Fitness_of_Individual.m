function fitness_value=Fitness_of_Individual(Xij)
%DATA SET
%No of Types
W=15;
%No of Targets
T=4;
%No of TV Channels
%Segment Weights
%Target Audience 1 2 3 4
             Uj=[2 3 4 1]; % Priority of targets
       
%Probability Table 
Pij=Probability_Table();

% WTA Fitness-------------------------------------------------
     format long
     fitness_value=0;
     for j=1:T
          temp1=1;
         for i=1:W

             temp1=temp1*(1-Pij(i,j))^Xij(i,j);
         end
         fitness_value=fitness_value+Uj(j)*(1-temp1);

     end     
     disp(fitness_value);
end