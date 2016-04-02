classdef Lab3Utils
    methods(Static)
        function Y = EDistance(pointA, pointB)
            Y = sqrt((pointA - pointB)' * (pointA - pointB));
        end
        
        function Y = ClassifyClass(Mus, point)
            for i = 1:length(Mus)
                distances(i) = Lab3Utils.EDistance(Mus(:,i),point);
                
                if(Mus(:,i) == point)
                    temp = distances(i);
                end
                if(distances(i) ==0)
                    temp = distances(i);
                end
                
            end
            [~, Y] = min(distances);
        end
        
        function Y = SimilarMeans(means1, means2)
            Y = true;
            for i = 1:size(means1,2)
                if(Lab3Utils.EDistance(means1(:,i),means2(:,i)) <= 0.001)
                    Y = false;
                end
            end
        end
            
    end
end