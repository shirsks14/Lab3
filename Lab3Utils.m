classdef Lab3Utils
    methods(Static)
        function Y = EDistance(pointA, pointB)
            Y = sqrt((pointA - pointB)' * (pointA - pointB));
        end
        function Y = ClassifyClass(Mus, point)
            for i = 1:length(Mus)
                distances(i) = Lab3Utils.EDistance(Mus(i),point);
            end
            [~, Y] = min(distances);
        end
            
    end
end