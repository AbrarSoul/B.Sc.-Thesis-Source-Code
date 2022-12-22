clc        % clear command window
clear      % clear memory
addpath(genpath('E:\2.Matlab Codes\Genetic Algorithm'));  % adding the folder paths to access other functions
format long   % for more numbers after decimal point  
%------------------------------------------------------------------------
%DATA SET

W=15;	%No of Types
T=4;	%No of Targets
t=7;	%No of TV Channels
r=9;	%No of Radio Channels, t+1:r = r-(t+1)
w=10;	%No of Renewable Media Type=w ; No of Internet, r+1:w = w-(r+1)
n=12;	%No of Newspaper, w+1:n= n-(w+1)

%No of Ads Required(minimum ads required in each column)
%Target Audience 1  2  3  4
            Tj=[16 18 25 10];

%Segment Weights(Giving a priority no to the targets)
%Target Audience 1 2 3 4
             Uj=[2 3 4 1]; % Priority of targets
%------------------------------------------------------------------------             
population_size=20;
crossover_rate=0.9;
mutation_rate=0.01;
no_of_generation=1000;    
%------------------------------------------------------------------------         
% Fitness Value of Individuals
fitness_value=zeros(1,population_size);

B=75.000; % Total Advertising Budget=B Dollar
p1=0.55; %TV expenditure share=p1
p2=0.15; %RADIO expenditure share=p2
p3=0.25; %NEWSPAPER expenditure share=p3
%------------------------------------------------------------------------

Sj=[3 2 1 4]; %Serial of Target according to priority
Wi=Ad_Capacity(); %ad Capacity        
Pij=Probability_Table(); %Probability Table 
Cij=Cost_Table(); 	%Cost Table

%---------------------Code Started----------------------------------------
best=0.0;
for puro_algo_ta_cholbe_joto_times=1:1000 		% 50 times i ran this algorithm,but now just 1 time

Xij=zeros(W,T,population_size); %Result Combination
temp_Xij=zeros(15,4);    % just keep 1 Xij combination
%for k=1:population_size
%---------------------Initial Population Creation----------------------------------------
k=1;
while(k<=population_size) 
    for i=1:w   % 1 theke 10 - renewable
        temp_W=Wi(i);  % temp_W te ad capacity thakbe
       %------------------------Not used-----------------------------------------
%         for j=1:T         % Normally initial population create,no modification
%             Xij(i,j,k)=randi([0 temp_W],1,1);
%             temp_W=temp_W-Xij(i,j,k);
%         end
       %-------------------------------------------------------------------------
       %----Ekta row er element gulor probability er max-min onujayi, index gulo ke serially Sj er moddhe rakhsi---------     
       Tij=Pij; %temporary Tij for Probability Table
       for lk=1:T % lk 4 ber ghurbe,r protibar 'i' row theke max ber korbe
           maximum_p=max(Tij(i,:)); % maximum probability of One Row
        for tt=1:T % each lk er loop e tt 4 ber ghurbe,index ber korer jonno
            if(Tij(i,tt)==maximum_p)  % i=row no, tt=column no
                i1 =i;       %Type no
                Sj(lk)=tt;   % Sj er moddhe probabaility beshi jar take age rakha, tt holo column index of max probability
                Tij(i,tt)=0; % next max ta ber korer jonno current max ke 0 banaya deya
            end
        end
       end % end of lk=1:T-----------------------------------
	    %-------------------------------------------------------------------------
		%----------1 theke 10 porjonto renewable type gulo randomly ads assign kortesi----------------------------------------------
       cnt=1;  
        while(cnt<=T) % ekta row e only
            j=Sj(cnt); % max probability ke age assign korbo        
            Xij(i,j,k)=randi([0 temp_W],1,1); % Integer er jonno=randi()
			%i=row,j=coloumn,k=individual no.
          %  Xij(i,j,k)=rand()*temp_W;
            temp_W=temp_W-Xij(i,j,k); 
            cnt=cnt+1;
        end        
    end %-------1 theke 10,w ekhane Shesh
	%-------------------------------------------------------------------------
	%------11 theke 15 porjonto renewable type gulo randomly ads assign kortesi----------------------------------
    for i=w+1:W  % 11 theke 15
        temp_W=Wi(i)/T; % 8/4=2; 4/4=1
        TK=randi([0 temp_W],1,1);        
        for j=1:T
            Xij(i,j,k)=TK; % Same value for all audience or targets,because it is unrenewable
        end
        
    end
	%-------------------------------------------------------------------------
	%------------------Checking & Fitness --------------------------------------------------
    %checking all constraints
    temp_Xij=Xij(:,:,k); % je individual ta create holo ta thik ase kina check
    OK=Check(temp_Xij);  % thik thakle ok=1,na hole ok=0
    if(OK==0) % OK=0 Constraint Jhamela ase.tahle k er value r increament kora jabe na. r je change hoisilo,oiguloke 0 kore dilam
        Xij(:,:,k)=0;  
        temp_Xij(:,:)=0;
    else %OK=1 means all ok,er fitness check kora jai                
        fitness_value(k)=Fitness_of_Individual(temp_Xij); % fitness of that individual
        k=k+1; % ekti individual create hoyese,tai increament k
    end
    %-------------------------------------------------------------------------
end %-------While loop of 'k' ekhane Shesh
%---------Initial Population Print-------------------------------------------------------
% disp('Initial Population''s Xij(size 20)');
% disp(Xij);
% B = sort(fitness_value,'descend');
% disp('Initial Population''s Fitenss Value(Max to Min,size 20)');
% disp(B);
% disp('Initial Population''s Best Fitenss Value');
% disp(B(1));
% % for i=1:population_size
% %     disp(B(i)); 
% % end
%--------Initia Population ke Modification,Max probabaility te na use hoya ads ke add kore deya-----------

[Xij_new,fitness_new,ft]=Add_Remains(Xij,fitness_value);
% ft= no. of Xij(combinations) created
%--------------------- Modified Best 20 Population Print-----------------------------------------
% disp('Modified Population''s Fitenss Value(size=20):');
% B = sort(fitness_new,'descend');
% mt=0;
% for i=1:population_size
    % mt=mt+1;
    % disp(B(i));
    % disp(mt);
   
% end
% disp('No. of Combination Created:');
% disp(ft);
% disp('Modified Population''s Best Fitenss Value:');
% disp(B(1));
%------------------------------------------------------------------------------------------------
%------------------------------------------------------------------------------------------------
%ekhn ager old Xij,fitness_value change hbe Xij_new,fitness_new theke,best 20 from modified version theke choice kora hbe
fitt=fitness_new; % new fitness vector ke fitt er moddhe rakha
for i=1:20   % ekhn old initial 20 ta fitness keo add kora
    fitt(ft+i)=fitness_value(i);
    Xij_new(:,:,ft+1)=Xij(:,:,i);
end
for indx=1:20  % ekhn best 20 ta ber kore set kora
    maximum_p=max(fitt);           
    for tt=1:ft+20            
        if(fitt(tt)==maximum_p)
           % disp(tt);
            position(indx)=tt;
            Xij(:,:,indx)=Xij_new(:,:,tt);
            fitness_value(indx)=maximum_p;
            fitt(tt)=0;
            break;
        end
    end       
end

%---------------Change korer por Xij,fitness_value----------------------------------------------------------------------

% disp('Best Combination: ');
% disp(Xij(:,:,1));
% disp('Best Fitness Value: ');
% disp(fitness_value(1));
%------------------------------------------------------------------------------------------------

%-------------------------Crossover & Mutation----------------------------------------------------------------------

    
	[best_Xij2,best2]=Crossover_Mutation_Media_Allocation(Xij,fitness_value);
    
	if(best2>best)  % puro algo 1 ber chalale best=0,kintu onk ber chala le best je ta pabe sheta thakbe best e
		best=best2;
		best_Xij=best_Xij2;
        
	end
end % 50 times puro algo cholse,but now just for 1 time
%------------------------------------------------------------------------------------------------
%----------------------------Crossover  & Mutation Korer por result --------------------------------------------------------------------
disp('Final Result Before Last Modification:')
disp('Best Combination: ');
disp(best_Xij);
disp('Best Fitenss Value: ');
disp(best);
% disp('test');
% testing_genetic_algo_result(best_Xij);
% xx=1:1:length(plot_best_arr);
% plot(xx,plot_best_arr,'.','LineWidth',2,...
% 						'MarkerEdgeColor','r',...
% 						'MarkerFaceColor','r');
% disp(length(plot_best_arr));
% hold on;
%  for inx=1:length(plot_best_arr)  % combination finding         
%       if(plot_best_arr(inx)==max(plot_best_arr))
%            sz=inx;
%         break;
%       end
%  end
%  plot(sz,max(plot_best_arr),'o','LineWidth',2,...
% 						'MarkerEdgeColor','g',...
% 						'MarkerFaceColor','g');

% xlabel('Generation','FontName','Comic Sans MS');
% ylabel('Quality','FontName','Comic Sans MS');
%------------------------------------------------------------------------------------------------
%----------------------------Last Modification --------------------------------------------------------------------
% for i=1:40
%    [best_of_all_Xij,best_of_all]=Last_Modification(best_Xij,best);
%    best_Xij=best_of_all_Xij;
%    best=best_of_all;
% end
%------------------------------------------------------------------------------------------------
% disp('Final Result:')
% disp('Best Combination: ');
% disp(best_of_all_Xij);
% disp('Best Fitenss Value: ');
% disp(best_of_all);










