function [Xij_new,fitness_new,ft]=Add_Remains(Mij,f)
disp('Add_Remains');
format long
Xij=Mij;
fitness_value=f;


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
             
population_size=20;
p_of_crsover=0.9;
p_of_mutation=0.01;
no_of_generation=1000;             
% Fitness Value of Individuals
format long 
fitness_value=zeros(1,population_size);
%Total Advertising Budget=B
B=75.000; % Dollar
%TV expenditure share=p1
p1=0.55;
%RADIO expenditure share=p2
p2=0.15;
%NEWSPAPER expenditure share=p3
p3=0.25;

Sj=[3 2 1 4];

%r=randi([0 3],1,10)
%ad Capacity
Wi=Ad_Capacity();
         
%Probability Table 
Pij=Probability_Table();

% %Cost Table
Cij=Cost_Table();

Xij_new=zeros(W,T,500);
ft=0;
fitness_new=zeros(1,500);
for k=1:population_size
    for i=1:W
        Remains=Wi(i)- sum(Xij(i,:,k));
        if(Remains==0) 
            continue;
        end;
        maximum_p=max(Pij(i,:));
        for tt=1:T
            if(Pij(i,tt)==maximum_p)
                i1 =i;
                j1=tt;
            end
        end
        old_value=Xij(i1,j1,k);
        if(i<=w)
            Xij(i1,j1,k)=Xij(i1,j1,k)+Remains;
        else
            for inx=1:T
                Xij(i,inx,k)=Xij(i,inx,k)+(Remains/T);
            end
        end
        
        temp_Xij=Xij(:,:,k);
       % disp('temp');
      %  disp(temp_Xij);
        OK=Check(temp_Xij);
       % OK=1;
       % disp('OK returned: ');
        %disp(OK);
        if(OK==0) 
            Xij(i1,j1,k)=old_value;
            temp_Xij(:,:)=0;
        else
            fitness=Fitness_of_Individual(temp_Xij);
            if(fitness>fitness_value(k))
                ft=ft+1;
                fitness_new(ft)=fitness;
                Xij_new(:,:,ft)=temp_Xij;
            else
                Xij(i1,j1,k)=old_value;
            end
            
        end
        
    end
    
end

end