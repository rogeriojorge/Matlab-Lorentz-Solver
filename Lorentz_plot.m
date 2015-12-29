function [] = Lorentz_plot(tit,xlab,ylab,plot,plotname,zlab)
    hTitle=title({tit;''});
    hXLabel=xlabel(xlab,'interpreter','latex');hYLabel=ylabel(ylab,'interpreter','latex');
    if nargin > 5
        hZLabel=zlabel(zlab,'interpreter','latex');
        set([hTitle, hXLabel, hYLabel,hZLabel],'FontName','AvantGarde');
        set([hXLabel, hYLabel, hZLabel],'FontSize',12);
        set(gca,'Box','on','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on',...
            'ZMinorTick','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'ZColor',[.3 .3 .3]);        
    else
        set([hTitle, hXLabel, hYLabel],'FontName','AvantGarde');
        set([hXLabel, hYLabel],'FontSize',12);
        set(gca,'Box','on','TickDir','out','TickLength',[.02 .02],'XMinorTick','on', 'YMinorTick','on',...
            'XColor',[.3 .3 .3],'YColor',[.3 .3 .3]);
    end
    set(gca,'FontName','Helvetica' );
    set( hTitle,'FontSize',12,'FontWeight','bold');
    set(gcf,'Color',[1 1 1]);
    drawnow;
    if plot==1
        export_fig([plotname,'.pdf']);
    end
end

