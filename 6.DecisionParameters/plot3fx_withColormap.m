function [] = plot3fx_withColormap(s1Text,s1,m1,s2Text,s2,m2,s3Text,s3,m3,...
              title,nTotalSignals,c,cmap,types)
    
    figure;
    suptitle(title);
    subplot(311);
    hold on;
    scatter(1:nTotalSignals,s1,25,c);
    if m1 ~= 0
        offset = 1;
        for i=1:length(types)
            x1 = offset;
            x2 = offset + types(i) - 1;
            line([x1,x2],[m1(i),m1(i)]);
            offset = x2 + 1;
        end
    end
    hold off;
    ylabel(s1Text);
    subplot(312);
    scatter(1:nTotalSignals,s2,25,c);
    if m2 ~= 0
        offset = 1;
        for i=1:length(types)
            x1 = offset;
            x2 = offset + types(i) - 1;
            line([x1,x2],[m2(i),m2(i)]);
            offset = x2 + 1;
        end
    end
    hold off;
    ylabel(s2Text);
    subplot(313);
    scatter(1:nTotalSignals,s3,25,c);
    if m3 ~= 0
        offset = 1;
        for i=1:length(types)
            x1 = offset;
            x2 = offset + types(i) - 1;
            line([x1,x2],[m3(i),m3(i)]);
            offset = x2 + 1;
        end
    end
    hold off;
    ylabel(s3Text);

    hp1 = get(subplot(3,1,1),'Position');
    hp3 = get(subplot(3,1,3),'Position');
    chb = colorbar('Position', [hp3(1)+hp3(3)+0.025  hp3(2)  0.025  hp1(2)+hp3(2)]);
    colormap(cmap);
    set(chb,'Ticks',0.125/2:0.125:1,'TickLabels',...
        {'Typ.1','Typ.2','Typ.3','Typ.4','Typ.5','Typ.6','Typ.7','Typ.8'});

end

