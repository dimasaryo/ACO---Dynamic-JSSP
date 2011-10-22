function[bestrute]=nodeexchange(graph,rute,nodes,machine,mactime,jobtime)
%10042011

m=size(nodes,1);
n=size(nodes,2);
tablerute(1,:)=rute;
i=2;

%melakukan pertukaran simpul dengan memperhatikan urutan operasi
for j=2:(size(rute,2)-2)
    row1=ceil(rute(1,j)/n);
    row2=ceil(rute(1,j+1)/n);
    column1=mod(j-1,n);
    column2=mod(j,n);
    if(column1==0)
        column1=3;
    end
    if(column2==0)
        column2=3;
    end
    if(row1~=row2) %jika kedua simpul berada di job yang berbeda
        tablerute(i,:)=rute;
        tablerute(i,j)=rute(1,j+1);
        tablerute(i,j+1)=rute(1,j);
        i=i+1;
    end
end

%menghitung nilai makespan setiap rute hasil pertukaran simpul
for i=1:size(tablerute,1)
    tablerute(i,:)=makespan(graph,tablerute(i,:),machine,mactime,jobtime);
end
%menentukan rute dengan makespan terkecil
minimumspan=min(tablerute(:,(size(tablerute,2))));
for i=1:size(tablerute,1)
    if(tablerute(i,(size(tablerute,2)))==minimumspan)
        bestrute=tablerute(i,:);
    end
end
