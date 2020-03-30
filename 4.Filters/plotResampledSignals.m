function [] = plotResampledSignals(x,y,z)
%plotResampledSignals: Plotting x, y and z signals

    [~,n] = size(x);
    figure;
    subplot(3,1,1)
    title('X coordinate')
    hold on;
    for i = 1:n
        plot(x(:,i))
    end
    legend('Type 1','Type 2','Type 3','Type 4','Type 5','Type 6','Type 7','Type 8')
    hold off;

    subplot(3,1,2)
    title('Y coordinate')
    hold on;
    for i = 1:n
        plot(y(:,i))
    end
    legend('Type 1','Type 2','Type 3','Type 4','Type 5','Type 6','Type 7','Type 8')
    hold off;

    subplot(3,1,3)
    title('Z coordinate')
    hold on;
    for i = 1:n
        plot(z(:,i))
    end
    legend('Type 1','Type 2','Type 3','Type 4','Type 5','Type 6','Type 7','Type 8')
    hold off;
end

