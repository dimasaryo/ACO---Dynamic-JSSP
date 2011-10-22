function[graph,machine,nodes] = inputstream(input)
%10042011

data =xlsread(input,-1);
data(isnan(data))=0;
m = size(data,2)/size(data,1);
n = size(data,1);
job = 0; % job pertama;
graph = zeros(m,n); %matriks waktu proses
machine = zeros(m,n); %matriks mesin

%proses data yang berasal dari file excel ke dalam bentuk graf
for i = 1:size(data,1)
    for j=1:size(data,2)
        if(mod(j,n)==1)
            job = job+1;
        end
        if(data(i,j)~=0)
            operation = mod(j,n);
            if(operation == 0)
                operation = n;
            end
            graph(job,operation)=data(i,j);
            machine(job,operation)=i;
        end
    end
    job = 0;
end

%membuat matriks simpul untuk mempermudah proses manipulasi data
nodes=zeros(size(graph,1),size(graph,2));
k=1;
for i=1:size(graph,1)
    for j=1:size(graph,2)
        nodes(i,j)=k;
        k=k+1;
    end
end