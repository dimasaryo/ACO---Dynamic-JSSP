function [pher] = pheromone(graph,p)
%date 09042011

graph=graph;
m= size(graph,1);
n= size(graph,2);
node=zeros(m,n);
k=1;
for i=1:m
    for j=1:n
        node(i,j)=k;
        k=k+1;
    end
end

pher = zeros((m*n)+1);
for i=1:m
    pher(1,node(i,1)+1)=p;
end
for i=1:m
    for j=1:n
        % baris pertama
        if(graph(i,j)~=0)
        if(i==1)
            if(j<n)
                if((graph(i,j+1))~=0) % filter nilai 0
                    pher(node(i,j)+1,node(i,j+1)+1)=p;
                end
            end
            for k=1:m-1
                for l=1:n
                    if(graph(k+1,l)~=0) %filter nilai 0
                        pher(node(i,j)+1,node(i+k,l)+1)=p;
                    end
                end
            end
        % baris terakhir
        elseif(i==m)
            if(j<n)
                if((graph(i,j+1))~=0) % filter nilai 0
                    pher(node(i,j)+1,node(i,j+1)+1)=p;
                end
            end
            for k=1:m-1
                for l=1:n
                    if(graph(i-k,l)~=0) %filter nilai 0
                        pher(node(i,j)+1,node(i-k,l)+1)=p;
                    end
                end
            end
        %baris tengah
        else
            if(j<n)
                if((graph(i,j+1))~=0) % filter nilai 0
                    pher(node(i,j)+1,node(i,j+1)+1)=p;
                end
            end
            for k = (i-1):-1:1
                for l=1:n
                    if(graph(k,l)~=0) %filter nilai 0
                        pher(node(i,j)+1,node(i-k,l)+1)=p;
                    end
                end
            end
            for k= (i+1):m
                for l=1:n
                    if(graph(k,l)~=0) %filter nilai 0
                        pher(node(i,j)+1,node(k,l)+1)=p;
                    end
                end
            end
        end
        end
    end
end   