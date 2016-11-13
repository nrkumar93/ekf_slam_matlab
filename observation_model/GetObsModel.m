function Zmod=GetObsModel(Xnow,re,po,delTh)
siz=size(re);
if ~isempty(re)
    for i=1:siz(2)
        R_Mod(i)=sqrt((Xnow(1)-re(1,i))^2+(Xnow(2)-re(2,i))^2);
        Th_Mod(i)=po(2,i)+delTh;
    end
    Zmod=[R_Mod;Th_Mod];
else
    Zmod=[];
end
end






% function Zmod=GetObsModel(Xpast,Xnow,CAsf_po)
% siz=size(CAsf_po);
% if ~isempty(CAsf_po)
%     R_dis=sqrt((Xpast(1)-Xnow(1))^2+(Xpast(2)-Xnow(2))^2);
%     for i=1:siz(2)
%         R_Mod(i)=sqrt(R_dis^2+CAsf_po(1,i)^2-(2*R_dis*CAsf_po(1,i)*cos((pi/2)-CAsf_po(2,i))));
%         Th_Mod(i)=CAsf_po(2,i)-(Xnow(3)-Xpast(3));
%     end
%     Zmod=[R_Mod;Th_Mod];
% else
%     Zmod=[];
% end
% end