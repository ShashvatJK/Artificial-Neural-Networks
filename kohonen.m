clear workspace
clear all
clc
format short

inputs=[1 1 1 -1; -1 -1 -1 1; 1 -1 -1 -1; -1 -1 1 1];
learning_rate=0.9
lr_reduction_factor=0.5;
epochs =1000;
[weights] = training(inputs,learning_rate,lr_reduction_factor,epochs);
outputs = testing(weights)
function [weights] = training(inputs,learning_rate,lr_reduction_factor,epochs)
    strcat('########## TRAINING ##########')
    
    inputs
    weights=[0.2 0.8; 0.6 0.4; 0.5 0.7; 0.9 0.3]
    [patterns , classes] = size(weights)
    learning_rate
    epochs
    ini_weights = weights;
    output=zeros(patterns,1);
    for j = 1:epochs
        for i = 1:patterns
            euclidean_dist=zeros(classes,1);
            for k=1:classes
                euclidean_dist(k,1)=sum((inputs(i,:)-weights(:,k)').^2);
            end
            [minimum, index] = min(euclidean_dist);   
            output(i,:)=index;
            weights(:,index) = weights(:,index) + learning_rate.*(inputs(i,:)-weights(:,index)')';
            weights
        end
        output
        learning_rate = learning_rate*(1-lr_reduction_factor)
        epochnum=["Epoch No.: " j]
        %splitlines(compose("Epoch No: " + num2str(j) + "\nW11: " + num2str(input_weights(1,1))+ "\nW12: " + num2str(input_weights(1,2))+ "\nW21: " + num2str(input_weights(2,1))+ "\nW22: " + num2str(input_weights(2,2))+ "\nB1: " + num2str(input_bias(1,1))+ "\nB2: " + num2str(input_bias(1,2)) + "\nZ1: " + num2str(hidden_weights(1,1))+ "\nZ2: " + num2str(hidden_weights(2,1)) + "\nB3: " + num2str(hidden_bias) ))
    end
    strcat('########## END OF TRAINING ##########')
    ini_weights
    weights
end
function outputs = testing(weights)
    strcat('########## TESTING ##########')
    I = [1 1 1 1; -1 1 -1 1; -1 -1 -1 -1; 1 -1 1 1]
    [patterns , classes] = size(weights);
    euclidean_dist=zeros(classes,1);
    outputs=zeros(patterns,1);
    for i=1:patterns
        for k=1:classes
            euclidean_dist(k,1)=sum((I(i,:)-weights(:,k)').^2);
        end
    [minimum, index] = min(euclidean_dist);   
    outputs(i,:)=index;
    end
    strcat('########## END OF TESTING ##########')
end
