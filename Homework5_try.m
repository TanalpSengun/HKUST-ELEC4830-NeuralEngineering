close all
clear all
load("ELEC4830_homework5.mat");

%changing the names to the easy versions
v1 = initialV;
w1 = initialW;
x= trainingNeuralFiring;
z= trainingWindDirection;

z_with_4 = zeros(2800,4);

%translate z into 4x1
for i=1:2800
    if z(i)==45
        z_with_4(i,1)=1;
    end
    if z(i)==135
           z_with_4(i,2)=1;
    end
    if z(i)==225
           z_with_4(i,3)=1;
    end
    if z(i)==315
           z_with_4(i,4)=1;
    end
end


eta_1 = 0.1;
eta_2 = 0.01;
eta_3 = 0.001;

%defining what is y and z 
%y = sigmoid(sum(w.*x));
%z_calculated = sum(v*y);

 
%iterative algorithm with eta_1

for iteration=1:1000
    
    
    y_train1= sgm(x*w1);
    z_predicted1 = y_train1*v1;
    
    
     w1 = w1 + eta_1*(((z_with_4-z_predicted1)*v1'.*y_train1.*(1-y_train1))'*x)'/2800;
     
     v1 = v1 + eta_1*((z_with_4-z_predicted1)'* y_train1)'/2800;
  
  
    
    y_train1= sgm(x*w1);
    z_predicted1 = y_train1*v1;
    
    cost_func = (1/2).*sum((z_predicted1-z_with_4).^2);
    cost_func_mat(iteration) = sum(cost_func)/2800;
    
end


 figure();
 plot(cost_func_mat);
 title("Iteration vs Cost Function");
 xlabel("Iteration")
 ylabel("Cost Function ( Error ) ")
 
%iterative algorithm with eta_2
v2 = initialV;
w2 = initialW;

for iteration_2=1:10000
    
    
    y_train2= sgm(x*w2);
    z_predicted2 = y_train2*v2;
    
    
     w2 = w2 + eta_2*(((z_with_4-z_predicted2)*v2'.*y_train2.*(1-y_train2))'*x)'/2800;
     
     v2 = v2 + eta_2*((z_with_4-z_predicted2)'* y_train2)'/2800;
  
  
    
    y_train2= sgm(x*w2);
    z_predicted2 = y_train2*v2;
    
    cost_func2 = (1/2).*sum((z_predicted2-z_with_4).^2);
    cost_func_mat2(iteration_2) = sum(cost_func2)/2800;
    
end


 figure();
 plot(cost_func_mat2);
 title("Iteration vs Cost Function");
 xlabel("Iteration")
 ylabel("Cost Function ( Error ) ")
 
 
 %iterative algorithm with eta_3
 
v3 = initialV;
w3 = initialW;

for iteration_3=1:10000
    
    
    y_train3= sgm(x*w3);
    z_predicted_3 = y_train3*v3;
    
    
    
     w3 = w3 + eta_3*(((z_with_4-z_predicted_3)*v3'.*y_train3.*(1-y_train3))'*x)'/2800;
     
     v3 = v3 + eta_3*((z_with_4-z_predicted_3)'* y_train3)'/2800;
  
  
    y_train3= sgm(x*w3);
    z_predicted_3 = y_train3*v3;
    
    cost_func_3 = (1/2).*sum((z_predicted_3-z_with_4).^2);
    cost_func_mat_3(iteration_3) = sum(cost_func_3)/2800;
    
end


 figure();
 plot(cost_func_mat_3);
 title("Iteration vs Cost Function");
 xlabel("Iteration")
 ylabel("Cost Function ( Error ) ")
%how should we use eta
%w = w - eta_1.*(z_calculated-z_real)*v*y(1-y)*x;
%v = v - eta_1*(z_calculated-z_real)*(y);

%-----------------------------q2 -------------------------------------

test_x = testingNeuralFiring ;
test_z = testingWindDirection ;

test_z_indexes = (test_z+45)/90;


y_1= sgm(test_x*w1);
z_test_1=y_1*v1;

y_2= sgm(test_x*w2);
z_test_2=y_2*v2;

y_3= sgm(test_x*w3);
z_test_3=y_3*v3;

%translate z_predicted into 4x1by looking at the maximum 
z_test1_with_4 = zeros(1200,1);
z_test2_with_4 = zeros(1200,1);
z_test3_with_4 = zeros(1200,1);
% 
for i=1:1200
    
   index_max_at1= find(z_test_1(i,:)==max(z_test_1(i,:)));
   z_test1_with_4(i)=index_max_at1;
   
   index_max_at2= find(z_test_2(i,:)==max(z_test_2(i,:)));
   z_test2_with_4(i)=index_max_at2;
   
   index_max_at3= find(z_test_3(i,:)==max(z_test_3(i,:)));
   z_test3_with_4(i)=index_max_at3;
   
    
end






[cm,order]=confusionmat(test_z_indexes,z_test1_with_4);
[cm2,order2]=confusionmat(test_z_indexes,z_test2_with_4);
[cm3,order3]=confusionmat(test_z_indexes,z_test3_with_4);

cm
cm2
cm3

%----------------------------- q3 -------------------------------------

%starting by defining sigmoid function
function sigmoid = sgm(a) 
sigmoid= (1 ./ (1 + exp(-a)));
end




