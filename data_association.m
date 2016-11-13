clear mfe_x mfe_y;
r1=1;
mfe_x(r1)=0;
mfe_y(r1)=0;

for at=1:length(afe_x)
    for bt=1:length(fe_x)
        di_x=abs(afe_x(at)-fe_x(bt));
        di_y=abs(afe_y(at)-fe_y(bt));
        if di_x<=0.05&&di_y<=0.05
            mfe_x(r1)=(afe_x(at)+fe_x(bt))/2;
            mfe_y(r1)=(afe_y(at)+fe_y(bt))/2;
            r1=r1+1;
        end
    end
end