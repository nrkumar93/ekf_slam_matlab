function [OAsf_re,CAsf_re,NAsf_re]=GetAssoFeature(past,now)

OA_fex=[];OA_fey=[];CA_fex=[];CA_fey=[];NA_fex=[];NA_fey=[];

tol=0.2;
a=size(now); b=size(past);
r1=1;r2=1;

for at=1:a(2)
    Test_flag=0;
    for bt=1:b(2)
        ecd=sqrt((now(1,at)-past(1,bt))^2+(now(2,at)-past(2,bt))^2);
        if ecd<=tol
            CA_fex(r1)=(now(1,at)+past(1,bt))/2;
            CA_fey(r1)=(now(2,at)+past(2,bt))/2;
            r1=r1+1;
            Test_flag=1;
        end
    end
    if (Test_flag==0)
        NA_fex(r2)=now(1,at);
        NA_fey(r2)=now(2,at);
        r2=r2+1;
    end
end
r2=1;
for bt=1:b(2)
    Test_flag=0;
    for at=1:a(2)
        ecd=sqrt((now(1,at)-past(1,bt))^2+(now(2,at)-past(2,bt))^2);
        if ecd<=tol
            Test_flag=1;
        end
    end
    if (Test_flag==0)
        OA_fex(r2)=past(1,bt);
        OA_fey(r2)=past(2,bt);
        r2=r2+1;
    end
end
OAsf_re=[OA_fex;OA_fey];
CAsf_re=[CA_fex;CA_fey];
NAsf_re=[NA_fex;NA_fey];
end
    