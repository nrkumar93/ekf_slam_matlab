function [x,y] = feature_extraction_ram(las,ACdelTh)

alpha=linspace(0+ACdelTh,pi+ACdelTh,511);
k=1;
[row,col]=size(las);
    for j=1:col-1
        if (las(j)>=0.15)
            l_ex(k)=las(j);
            alp(k)=alpha(j);
            ex(k)=l_ex(k)*cos(alp(k));
            why(k)=l_ex(k)*sin(alp(k));
            k=k+1;
        end
    end
    
    
    j=1;
    k=1;
    j1=1;
    m=1;
    drop(m)=0;
    m=m+1;
    s_dat=length(l_ex);
    
%%%Resample the data    
    while (j+j1<s_dat)
        ec_dis=sqrt((ex(j)-ex(j+j1))^2+(why(j)-why(j+j1))^2);
        if (ec_dis>0.03)
            if (ec_dis<=0.2)
                re_x(k)=ex(j);
                re_y(k)=why(j);
                re_al(k)=alp(j);
                re_las(k)=l_ex(j);
                k=k+1;
                j=j+j1;
                j1=1;
            else
                drop(m)=k;
                re_x(k)=ex(j);
                re_y(k)=why(j);
                re_al(k)=alp(j);
                re_las(k)=l_ex(j);
                m=m+1;
                k=k+1;
                j=j+j1;
                j1=1;
            end
        else
            j1=j1+1;
        end
    end
    figure(1);
%      plot(X+re_x,Y+re_y,'or','markersize',4);
%      hold on;
    l_dat=length(re_x);
    drop(m)=l_dat;

    
%To find the start and end of the line segment
d=diff(drop);
kd=1;
for di=1:length(d)
    if d(di)>3
        st_pt(kd)=drop(di)+1;
        end_pt(kd)=drop(di+1);
        kd=kd+1;
       
    end
end
st_pt;
end_pt;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=0;
y=0;
v=1;
cl=1;
rw=1;
sol_ln=0;
for kd=1:length(st_pt)               %no of clusters (total no. of lines)
        f_dat=st_pt(kd);             
        tot=f_dat+3;                 %taking first 4 points of lot 1
        x_las=re_x(f_dat:tot);       %group first 4 points 'x' lot 1
        y_las=re_y(f_dat:tot);       %group first 4 points 'y' lot 1
        [p_lin,er]=polyfit(x_las,y_las,1);  %plot test line for 4 points
        temp=tot;                          %duplicate 'tot' 
        while(tot<=end_pt(kd))              
%             if tot~=temp                 %slope extraction
%             slo(1)=p_lin(1);
%             int(1)=p_lin(2);
%             end
        cnt=0; 
        var=tot;                          %duplicate 'tot' for line extension
            for j=1:4                     %take next 4 point and find distance to eliminate              
                var=var+1;  
                if (var>=end_pt(kd))
                    break
                end
                d_xy=abs(re_y(var)-(p_lin(1)*re_x(var))-p_lin(2))/sqrt(p_lin(1)^2+1);
                if d_xy>=0.04
                    cnt=cnt+1;
                end
            end
            if cnt>=1
                x_las=re_x(f_dat:tot-1);
                y_las=re_y(f_dat:tot-1); 
                [p_lin,er]=polyfit(x_las,y_las,1);
                y_new=(p_lin(1).*x_las)+p_lin(2);   %find 'y' by putting 'x' in new line 
                r_sm=length(x_las);
                Q=[x_las(1),y_new(1);x_las(r_sm),y_new(r_sm)];
                D=pdist(Q,'euclidean');
                if D>0.1
                    sol_ln(rw,cl)=p_lin(1);
                    sol_ln(rw,cl+1)=p_lin(2);
                    rw=rw+1;
                    cl=1;
                    plot(x_las,y_new,'-b','markersize',4);
%                  hold on
                end
                f_dat=tot;
                tot=f_dat+3;
                x_las=re_x(f_dat:tot-1);
                y_las=re_y(f_dat:tot-1);
                [p_lin,er]=polyfit(x_las,y_las,1);
            else
                x_las=re_x(f_dat:var-1);
                y_las=re_y(f_dat:var-1);
                [p_lin,er]=polyfit(x_las,y_las,1);
                tot=var;
                if tot==end_pt(kd)
                    y_new=(p_lin(1).*x_las)+p_lin(2);
                    r_sm=length(x_las);
                    Q=[x_las(1),y_new(1);x_las(r_sm),y_new(r_sm)];
                    D=pdist(Q,'euclidean');
                    if D>0.1
                        sol_ln(rw,cl)=p_lin(1);
                        sol_ln(rw,cl+1)=p_lin(2);
                        rw=rw+1;
                        cl=1;
                        plot(x_las,y_new,'-b','markersize',4);
                        hold on
                    end
                    break
                end
            end
%              pause(0.1)
       
    
        end
end


for j=1:length(sol_ln)-1
    ang=atand(((sol_ln(j,1)-sol_ln(j+1,1))/(1+(sol_ln(j,1).*sol_ln(j+1,1)))));
    if ang<0
        ang=ang+180;
    end
            if ang<=110 && ang>=70
                x(v)=((sol_ln(j+1,2)-sol_ln(j,2))/(sol_ln(j,1)-sol_ln(j+1,1)));
                y(v)=(((sol_ln(j,1).*(sol_ln(j+1,2)-sol_ln(j,2)))+(sol_ln(j,2).*(sol_ln(j,1)-sol_ln(j+1,1))))/(sol_ln(j,1)-sol_ln(j+1,1)));
                v=v+1;
             end
end

            plot(x,y,'*k','markersize',8);