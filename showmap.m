function[]=showmap(graph,rute,setuptime,machines)
%10042011

hold on;
for i=2:size(rute,2)-1
    column = mod(rute(1,i),size(graph,2));
    if(column==0)
        column=3;
    end
    x=[setuptime(1,i) setuptime(1,i)+graph(ceil(rute(1,i)/size(graph,2)),column)];
    row =ceil(rute(1,i)/size(graph,2));
    y=[row row];
    plot(x,y,'-ro','linewidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',7);
    text(setuptime(1,i)+1,ceil(rute(1,i)/size(graph,2))+0.15,['R(' num2str(machines(1,i)) ')']);
    %hanya untuk mempercantik tampilan
    plot([0 0],[0 row+1]);
end
hold off;