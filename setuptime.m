function[setuptime]=setuptime(graph,rute,machine,mactime,jobtime)
%10042011

m=size(graph,1);
n=size(graph,2);
setuptime=zeros(1,(size(rute,2)));
for j=2:(size(rute,2)-1);
    column = mod(rute(1,j),size(machine,2));
    if(column==0)
        column=3;
    end
    row = ceil(rute(1,j)/size(machine,2));
    if(mactime(1,machine(row,column))>jobtime(1,row))
        setuptime(1,j)= mactime(1,machine(row,column));
        jobtime(1,row)=mactime(1,machine(row,column))+ graph(row,column);
        mactime(1,machine(row,column))=jobtime(1,row);
    else
        setuptime(1,j)= jobtime(1,row);
        jobtime(1,row)=jobtime(1,row)+ graph(row,column);
        mactime(1,machine(row,column))=jobtime(1,row);

    end
end