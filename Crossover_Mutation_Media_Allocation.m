function [best_Xij,best]=Crossover_Mutation_Media_Allocation(Received_Xij,fitness_vector)

format long 
crossover_rate=0.9;
mutation_rate=0.01;
population_size=20;
no_of_generation=10; 

best=fitness_vector(1);  % initial population er best take best er moddhe neya
best_Xij=Received_Xij(:,:,1); % best combination
W=15; %No of Types
T=4; %No of Targets
w=10; % no of renewable types


disp('==========================Crossover Choltese===================================');

%----------------------------Crossover---------------------------------------------

new_Xij=Received_Xij;  
for generation=1:no_of_generation   % 1000 ber iteration hbe 

    %[Xij_new,fitness_new,ft]=Add_Remains(new_Xij,fitness_vector); % Add_Remains ads to the newest population
	% ft= no. of Xij created
	% B = sort(fitness_new,'descend'); % new population ke fitness er base e descend e sort
	%-------------------------------------------------------------------------------------------------------
	% ekhn Xij,fitness_value change hbe,best 20 from modified version theke choice kora hbe
	% ad remains e to onk gulo fitness,combination hoise,oi combination gulor shathe 
	% new population keo add kore,sort kore 20 ta new inidividual create kora
    Xij_new=new_Xij;
    fitness_new=fitness_vector;
    ft=0;
	fitt=fitness_new;
	for i=1:20
		fitt(ft+i)=fitness_vector(i);
		Xij_new(:,:,ft+1)=new_Xij(:,:,i);
	end
	for indx=1:20
		maximum_p=max(fitt);           
		for tt=1:ft+20            
			if(fitt(tt)==maximum_p)
			   % disp(tt);
			   
				new_Xij(:,:,indx)=Xij_new(:,:,tt);
				fitness_vector(indx)=maximum_p;
				fitt(tt)=0;
				break;
			end
		end       
	end
	%fitness_vector holo new population er fitness
	%new_Xij holo new population er combination
	%-------------------------------------------------------------------------------------------------------
	%-------------------------------------------------------------------------------------------------------
   
	%-------------Ager Best value er shathe new best er check-----------------------------------------------
    if(max(fitness_vector)>best)
        best=max(fitness_vector);      
        for tt=1:population_size  % combination finding         
          if(fitness_vector(tt)== best)
               best_Xij=new_Xij(:,:,tt);
            break;
          end
        end 
    end
%      plot_best_arr(1,generation)=max(fitness_vector);
	%-------------------------------------------------------------------------------------------------------
    %-------------------------------Crossover Started-------------------------------------------------------
    ppsize=0; % 20 ter besi individual 1 ta generation e na
    cnt=0;   % new_Xij te new combination er index dite use kortesi
    while(ppsize<=population_size)
        temp_Xij=new_Xij;
		%------------------------------------------
        k1=1;  % parent 1 er index,k
        k2=1;  % parent 2 er index,k
        % Choosing 2 Parents - Individuals index 
        while(k1 == k2) % 2 ta parent er index jate same na hoy
            k1=randi([1 population_size],1,1); % 1st parent
            k2=randi([1 population_size],1,1); % 2nd parent
        end
		%------------------------------------------
        % disp('k1 k2');
        % disp(k1);
        % disp(k2);
		%----------------------------------------------------------------------------------------
		% temp_Xij er k1,k2 individual ke cross kre 2 ta new children banalam
        for i=1:W % row no. increament hoitese,jokhn crossover_rate er upore niche random value paitese,swap kortese index ke
            if(rand()<=crossover_rate)   % Swap korlam     %temp_Xij(:,:,k1) children no.1
                tempo=temp_Xij(i,:,k1);                    %temp_Xij(:,:,k2) children no.2
                temp_Xij(i,:,k1)= temp_Xij(i,:,k2);
                temp_Xij(i,:,k2)=tempo;       
            end    
        end
		%----------------------------------------------------------------------------------------
        %----------------------------1st children ke Mutation---------------------------------------------
		
		% 1st childern ke row er index value swap kora 
		for i=1:w
			for j=1:T
				if(rand()>=mutation_rate)
					index1=1;
					index2=1;
					while(index1==index2)       % 2 ta index jate same na hoy
						index1=randi([1 T],1,1);
						index2=randi([1 T],1,1);
					end
					val1=temp_Xij(i,index1,k1);
					val2=temp_Xij(i,index2,k1);
					temp_Xij(i,index1,k1)=val2;
					temp_Xij(i,index2,k1)=val1;
				end
			end
		end
	    %----------------------------------------------------------------------------------------
		 %----------------Checking & fitness calc. child 1--------------------------------------------------------------
		OK1=Check(temp_Xij(:,:,k1));
		fitness=Fitness_of_Individual(temp_Xij(:,:,k1));  % fitness check kortesi na,kom ashleo nibo,keno na alwaays best nite thakle exploration hbe na
		if(OK1==1)%--------------------------------------------------------
			cnt=cnt+1;
			fitness_vector(cnt)=fitness;
			new_Xij(:,:,cnt)=temp_Xij(:,:,k1); 
			ppsize=ppsize+1;
		end %--------------------------------------------------------
		%----------------------------2nd children ke Mutation---------------------------------------------
		for i=1:w
			for j=1:T
				if(rand()>=mutation_rate)
					index1=1;
					index2=1;
					while(index1==index2)
						index1=randi([1 T],1,1);
						index2=randi([1 T],1,1);
					end
					val1=temp_Xij(i,index1,k2);
					val2=temp_Xij(i,index2,k2);
					temp_Xij(i,index1,k2)=val2;
					temp_Xij(i,index2,k2)=val1;
				end
			end
		end
		%----------------------------------------------------------------------------------------
		 %----------------Checking & fitness calc. child 1--------------------------------------------------------------
		OK2=Check(temp_Xij(:,:,k2));
		fitness=Fitness_of_Individual(temp_Xij(:,:,k2));
		if(OK2==1)%--------------------------------------------------------
			cnt=cnt+1;
			fitness_vector(cnt)=fitness;
			new_Xij(:,:,cnt)=temp_Xij(:,:,k2); 
			ppsize=ppsize+1;
		end %--------------------------------------------------------
    end % --------------------------------------------------------
end % end of no of generation --------------------------------------------------------
% 
% maximum_p = max(fitness_vector);           
% for tt=1:population_size          
%     if(fitness_vector(tt)== maximum_p)
%         disp('Maximum Result after Crossover & Mutation');
%         disp(maximum_p);
%         disp('Maximum Result Combination');
%         disp(round(Received_Xij(:,:,tt)));
%         R_Xij=Received_Xij(:,:,tt);
%         fitness=maximum_p;
%         fitness=Fitness_of_Individual(round(Received_Xij(:,:,tt)));
%         disp(fitness);
%         break;
%     end
% end   
% disp('best: ');
% disp(best);
end  % Function End
    
