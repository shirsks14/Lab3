classdef MICDClassifier
    properties
        
        Mus;
        covs;
        
%         AMu;
%         BMu;
%         CMu;
%         DMu;
%         EMu;
%         FMu;
%         GMu;
%         HMu;
%         IMu;
%         JMu; 
    end
    
    methods
        function obj = MICDClassifier(data)
            counter = 0;
            for i = 1:10
                obj.Mus(:,i) = [sum(data(1,counter+1:counter+16))/16; sum(data(2,counter+1:counter+16))/16];
                counter = counter +16;
            end
            counter = 0;
            for i = 1:10
               x = [data(1,counter+1:counter+16); data(2,counter+1:counter+16)];
               obj.covs{i} = obj.CalCovariance(x,obj.Mus(:,i));
               counter = counter + 16;
            end
        end
        
        function Y = CalCovariance(obj, x, Mu)
            Y = zeros(2,2);
            for i = 1:length(x)
                Y = Y + (x(:,i)' - Mu')'*(x(:,i)' -Mu');
            end
            Y = Y/length(x);
            Y = length(x)/(length(x) - 1) * Y;
        end
        
        function Y = Classify(obj, point)
        distances = [];
        for i = 1: 10
           distances(i) = (point - obj.Mus(:,i))'*inv(obj.covs{i})*(point - obj.Mus(:,i)); 
        end
        [~, Y] = min(distances);
    end
        
 end
    
    
    
end
