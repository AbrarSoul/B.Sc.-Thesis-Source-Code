function [combination,best]=Last_Modification(Result_Combination,best)
X=Result_Combination;
combination=Result_Combination;
mx=1.5;
w=10;
T=4;
Wi=Ad_Capacity();
Pij=Probability_Table();
for i=1:w % media allocation er jonno shudhu 1-10 
    if(Wi(i)>T*mx) % jodi ads capacity column er no. er chaite 1.5 gun  beshi hoy tahlei test ta korbo
        for j=1:T        
            max_ads=max(X(i,:));  % max ads assign hoise je column e
            index=find(X(i,:)==max_ads); % oi column er index
            if(j~=index && Pij(i,j)~=0.00) % j= je column e 1 ta kore barabo,
                %jdi j=max ads er index hoy tahle r oitate add korbo na,temni probability 0 hole o na
                old_value=X(i,index); % max ads index er value change er age save kore rakha
                old_value_j=X(i,j);  % j colmn er value ta save kore rakha
                X(i,index)=X(i,index)-1; % max prob. er value 1 komano
                X(i,j)=X(i,j)+1; % j index er ads er shathe 1 ta ads add kra
                ok=Check(X);    % checking  new X
                fitness=Fitness_of_Individual(X);
                if(ok==1 && fitness>best)
                    best=fitness;
                    combination=X;
                else
                     X(i,index)=old_value;
                     X(i,j)=old_value_j;
                end
            end          
                       
        end
    end
end

end