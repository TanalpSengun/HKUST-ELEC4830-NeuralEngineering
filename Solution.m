
 
K=2; % K is the parameter for determinig the shape of the function
Q=30; %angles of movement direction for the first question
N=4;
 
u_for_four_neuron = [ 0 90 180 270 ];  %preferred direction
rad_u_for_four_neuron = u_for_four_neuron.*(pi)/180; % changed everything into radians since cos 
%used with radians.
 
res= tune_func(pi/6,2,rad_u_for_four_neuron);
 
 
%------------------------------ Answer 1 ended ---------------------------
 
% N= the number of neurons
% C_i = preferred direction of the ith neuron
% r_i=  firing rate
% v= decoded movement direction 
vec_u_for_four_neuron = [ 1,0 ; 0,1 ; -1,0 ; 0,-1 ];

neural_fires = [ 1 0 2 7 ];
 
decoded_moving_direction = population_vector(neural_fires,vec_u_for_four_neuron);
 

% ----------------------------- Answer 2 ended -------------------------
% 
for i=1:24
    for j=1:4   
      store_all(i,j)=tune_func(movingDirection(1,i),2,rad_u_for_four_neuron(j));  
    end
end

figure();
subplot(2,2,1);
plot(movingDirection, store_all(:,1));
title('spikerate in terms of the moving direction 1st')
subplot(2,2,2);
plot(movingDirection, store_all(:,2));
title('spike rate in terms of the moving direction 2nd')
subplot(2,2,3);
plot(movingDirection, store_all(:,3));
title('spike rate in terms of the moving direction 3rd')
subplot(2,2,4);
plot(movingDirection, store_all(:,4));
title('spike rate in terms of the moving direction 4rth')






% ------------------------------ Answer 3a ended --------------------------


for i=1:6    
    decoded_moving_direction_matrix(i,:)= population_vector(neuralFiring(i,:),vec_u_for_four_neuron);
end

figure()
plotTrajectory(decoded_moving_direction_matrix)
title('Trajectory of decoded moving direction matrix')

% ----------------------------- Answer 3b ended ---------------------------
 
function y=tune_func(Q,K,u)
 
y=exp(K*cos(Q-u));
 
end
 
function y=population_vector(rate_r,u)

 y1=zeros(size(u));
 
for i= 1:4   
   y1(i,:)= rate_r(i).*u(i,:);
end
 
sum_down=cumsum(rate_r);
total_down=sum_down(size(u,1));
 
sum_up=sum(y1);

 
y=sum_up/total_down;

 
 
end
 

% ---------------------------- functions ---------------------------


