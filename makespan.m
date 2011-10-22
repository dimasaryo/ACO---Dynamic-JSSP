function [rute] = makespan(graph,rute,machine,mactime,jobtime)
%10042011

m=size(graph,1);
n=size(graph,2);
for j=2:(size(rute,2)-1);
    column = mod(rute(1,j),size(machine,2));
    if(column==0)
        column=3;
    end
    row = ceil(rute(1,j)/size(machine,2));
    if(mactime(1,machine(row,column))>jobtime(1,row))
        jobtime(1,row)=mactime(1,machine(row,column))+ graph(row,column);
        mactime(1,machine(row,column))=jobtime(1,row);
    else
        jobtime(1,row)=jobtime(1,row)+ graph(row,column);
        mactime(1,machine(row,column))=jobtime(1,row);
    end
end
rute(1,size(rute,2))=max(jobtime);