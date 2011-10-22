function [machines]=setmachine(machine,rute)
%10042011

machines=zeros(1,size(rute,2));
for i=2:size(rute,2)-1
    row=ceil(rute(1,i)/size(machine,2));
    column=mod(rute(1,i),size(machine,2));
    if(column==0)
        column=3;
    end
    machines(1,i)=machine(row,column);
end