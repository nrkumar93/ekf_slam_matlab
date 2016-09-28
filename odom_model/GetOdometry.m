function [Xnow,ACdelTh,delX,delY,delTh] = GetOdometry(odo_dat,Xpast,ACdelTh)
i1=2; width=0.258; rd=0.0552;
cl_tic=abs(odo_dat(i1,2));
cr_tic=abs(odo_dat(i1,3));
pl_tic=abs(odo_dat(i1-1,2));
pr_tic=abs(odo_dat(i1-1,3));
% Ts=odo_dat(i1,1)-odo_dat(i1-1,1);
Ts=1;
% dlw=(cl_tic-pl_tic)*0.10422/1000;
% drw=(cr_tic-pr_tic)*0.10422/1000;
lftw=cl_tic-pl_tic;
ritw=cr_tic-pr_tic;
dlw=(cl_tic-pl_tic)*2*pi*rd/3200;
drw=(cr_tic-pr_tic)*2*pi*rd/3200;

delS=Ts*(drw+dlw)/2;
delTh=Ts*(drw-dlw)/width;

% % This is method 1
% if lftw>0 && ritw<0 || lftw<0 && ritw>0
%     delX=0;
%     delY=0;
%     Xnow(1)=Xpast(1);
%     Xnow(2)=Xpast(2);
%     Xnow(3)=Xpast(3)+delTh;
% else
%     delX=delS*cos(Xpast(3)+delTh);
%     delY=delS*sin(Xpast(3)+delTh);
%     Xnow(1)=Xpast(1)+delX;
%     Xnow(2)=Xpast(2)+delY;
%     Xnow(3)=Xpast(3)+delTh;
% end
% % This is method 1


% This is method 2
if delTh~=0 % While turning

    delX=(delS/delTh)*(sin(Xpast(3)+delTh)-sin(Xpast(3)));
    delY=(delS/delTh)*(cos(Xpast(3)+delTh)-cos(Xpast(3)));
    Xnow(1)=Xpast(1)+delX;
    Xnow(2)=Xpast(2)-delY;
    Xnow(3)=Xpast(3)+delTh;
    Xnow(3)=AngleWrapping(Xnow(3));
else % While moving straight
    delX=delS*cos(Xpast(3));
    delY=delS*sin(Xpast(3));
    Xnow(1)=Xpast(1)+delX;
    Xnow(2)=Xpast(2)+delY;
    Xnow(3)=Xpast(3);
end
% This is method 2


ACdelTh=ACdelTh+delTh;
% ACdelTh=(pi/2)-Xnow(3);
ACdelTh=AngleWrapping(ACdelTh);

end