clear workspace
clear all
clc
format short

inputs = [1,1;1,-1;-1,1;-1,-1];
targets = [1;1;1;-1];
learning_rate = 0.05;
tolerance = 0.4;
epochs = 50;
[weights , bias] = training(inputs,targets,learning_rate,tolerance,epochs);
outputs = testing(weights,bias)


function [weights , bias] = training(inputs,targets,learning_rate,tolerance,epochs)
    strcat('########## TRAINING ##########')
    inputs
    targets
    learning_rate
    tolerance
    epochs
    bias = randn(1);          %randomly initalized
    weights =(randn(1,2))';   %randomly initalized
    ini_weights = weights;
    ini_bias =bias;
    patterns=length(inputs);
    flag=0;
    for j = 1:epochs
        for i = 1:patterns
            sum = inputs(i,:)*weights + bias;
            output = bipolar(sum);
            change = learning_rate*(targets(i)-sum)*(inputs(i,:)');
            weights(:,1) = weights(:,1) + change(:,1);
            bias = bias + learning_rate*(targets(i)-sum);
            if(max(change) > tolerance)
                flag=1;
                break
            end
        end
%         strcat('########## EPOCH NO. ', num2str(j), ' ##########')
%         weights
%         bias
        splitlines(compose(["Epoch No: " + num2str(j) + "\nW1: " + num2str(weights(1,1))+ "\nW2: " + num2str(weights(2,1))+ "\nB: " + num2str(bias)]))
        if flag==1
            break
        end
    end
    strcat('########## END OF TRAINING ##########')
    ini_weights
    weights
    ini_bias
    bias
end
function outputs = testing(weights,bias)
    strcat('########## TESTING ##########')
    I = [-1,1;1,1;-1,-1;1,-1]
    s = I*weights + bias;
    outputs = zeros(length(I),1);
    for i = 1:length(I)
        outputs(i,1)=bipolar(s(i,1));
    end
    strcat('########## END OF TESTING ##########')
end
function value = bipolar(sumk)
    if sumk >= 0
       value = 1;
    else
       value = -1;
    end
end
