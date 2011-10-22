function[bestrute,setuptimes,machines] = ACO(graph,machine,nodes,Q,a,b,p,t,mactime,jobtime)
%% (Ant System) 10042011
%----------------------------------
% inisialisasi parameter algoritma
%----------------------------------
m = size(graph,2);
n = size(graph,1);
minimumspan=0;

% membuat matriks pheromone
pher = pheromone(graph,t);

simpulcount=0;
for i=1:n
    for j=1:m
        if(graph(i,j)~=0)
            v(i,j)=1/graph(i,j);
            simpulcount=simpulcount+1;
        end
    end
end

%penyusunan rute kunjungan semut
state=1;
while(state==1)
rute = zeros(m,simpulcount+2); %matriks rute
for i= 1: n
   node=nodes(i,1); %simpul pertama
   rute(i,2)=nodes(i,1); %masukkan simpul pertama pada matriks rute
   stat=1;
   temps =pher;
   temps(:,(nodes(i,1)+1))=0;
   while(stat<simpulcount)
       temp = temps(node+1,:);
       for j=2:size(temp,2)
           column=mod((j-1),size(v,2));
           if(column==0)
               column=3;
           end
           if(column>1) %filter berdasarkan urutan operasi
               allowed=0;
               for k=1:size(rute,2)
                   if(nodes(ceil((j-1)/size(v,2)),column-1)==rute(i,k))
                        allowed=temp(1,j);
                   end
               end
               temp(1,j)=allowed;
           end
           temp(1,j)= temp(1,j)*v(ceil((j-1)/size(v,2)),column);
       end
       sigma = sum(temp);
       prob = temp ./ sigma;
       nodemax = max(prob);
       for j=2:size(prob,2)
           if(prob(1,j)==nodemax)
               node=j-1; %simpul terpilih dengan nilai probabilitas terbesar
               stat=stat+1;
               rute(i,stat+1)=node; %simpan simpul terpilih
               temps(:,j)=0;
           end
       end
   end
   
   %temukan rute dengan minimum span setelah pertukaran simpul.
   bestrutes(i,:)=nodeexchange(graph,rute(i,:),nodes,machine,mactime,jobtime);
end
   if(min(bestrutes(:,(size(bestrutes,2))))== minimumspan)
        state=0;
   end
   minimumspan=min(bestrutes(:,(size(bestrutes,2))));
   for j=1:size(bestrutes,1)
       if(bestrutes(j,(size(bestrutes,2)))==minimumspan)
           bestrute=bestrutes(j,:);
       end
   end
   deltapher=Q/minimumspan;
   %update pheromone
   for j=1:size(pher,1)
       for k=1:size(pher,2)
           if(pher(j,k)~=0)
               pher(j,k)= (1-p)*t+deltapher;
           end
       end
   end
end

% menghitung setup time setiap operasi
setuptimes =setuptime(graph,bestrute,machine,mactime,jobtime);

%mengeset matriks mesin dalam satu baris
machines =setmachine(machine,bestrute);

