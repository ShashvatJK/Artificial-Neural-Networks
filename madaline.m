clear workspace
clear all
clc
format short

inputs = [1,1;1,-1;-1,1;-1,-1];
targets = [-1;1;1;-1];
learning_rate = 0.7;
epochs = 4;
hidden_weights=[0.5;0.6];
hidden_bias=0.5;
[input_weights , input_bias] = training(inputs,targets,learning_rate,epochs,hidden_weights,hidden_bias);
final_output = testing(input_weights,input_bias,hidden_weights,hidden_bias)

function [input_weights , input_bias] = training(inputs,targets,learning_rate,epochs,hidden_weights,hidden_bias)
    strcat('########## TRAINING ##########')
    inputs
    targets
    learning_rate
    epochs
    input_bias =[0.5,0.5] %(rand(1,2))';          %randomly initalized
    input_weights =[0.1,0.2;0.3,0.4]%(rand(2,2))';%randomly initalized
    hidden_weights
    hidden_bias
    patterns=length(inputs);
    hidden_nodes=length(input_bias);
    hidden_output = zeros(patterns,hidden_nodes);
    hidden_sum = zeros(patterns,hidden_nodes);
    for j = 1:epochs
        for i = 1:patterns
            hidden_sum(i,:) = inputs(i,:)*input_weights + input_bias

            for h = 1:hidden_nodes
                hidden_output(i,h)=bipolar(hidden_sum(i,h));
            end
            hidden_output(i,:)
            final_sum = (hidden_output(i,:)*hidden_weights) + hidden_bias
            final_output = bipolar(final_sum)
            targets(i,1)
            if final_output==targets(i,1)
                input_weights
                input_bias
                continue
            else
                if targets(i,1) == 1
                    [minimum,index]=min(abs(hidden_sum(i,:)));
                    input_weights(:,index) = input_weights(:,index) + learning_rate*(1-hidden_sum(i,index)).*inputs(i,:)';
                    input_bias(:,index) = input_bias(:,index) + learning_rate*(1-hidden_sum(i,index));
                end
                if targets(i,1) == -1
                    ind=find(hidden_sum(i,:)>0);
                    input_weights(:,ind) = input_weights(:,ind) + learning_rate*(-1-hidden_sum(i,ind)).*inputs(i,:)';
                    input_bias(:,ind) = input_bias(:,ind) + learning_rate*(-1-hidden_sum(i,ind));
                end
            end
            input_weights
            input_bias
        end
        splitlines(compose(["Epoch No: " + num2str(j) + "\nW11: " + num2str(input_weights(1,1))+ "\nW12: " + num2str(input_weights(1,2))+ "\nW21: " + num2str(input_weights(2,1))+ "\nW22: " + num2str(input_weights(2,2))+ "\nB1: " + num2str(input_bias(1,1))+ "\nB2: " + num2str(input_bias(1,2))]))
    end
    strcat('########## END OF TRAINING ##########')
end

function final_output = testing(input_weights,input_bias,hidden_weights,hidden_bias)
    strcat('########## TESTING ##########')
    inputs = [-1,1;1,1;-1,-1;1,-1]
    %inputs = [1,1;1,-1;-1,1;-1,-1]
    hidden_sum = (inputs*input_weights) + input_bias;
    patterns=length(inputs);
    hidden_nodes=length(input_bias);
    hidden_output = zeros(patterns,hidden_nodes);
    final_sum = zeros(patterns,1);
    final_output = zeros(patterns,1);
    for i = 1:patterns
        for h = 1:hidden_nodes
            hidden_output(i,h)=bipolar(hidden_sum(i,h));
        end
        final_sum(i,:) = (hidden_output(i,:)*hidden_weights) + hidden_bias;
        final_output(i,:) = bipolar(final_sum(i,:));
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