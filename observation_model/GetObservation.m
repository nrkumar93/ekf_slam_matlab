%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [po,re,re_x,re_y] = GetObservation(las_dat,ACdelTh)

re =[]; po=[];
pt_dis=0.03; lin_bk=0.1; num_pt=10;
fe_x=[]; fe_y=[]; % Initializing the feature coordinates

% get all landfeatures and tested each
alpha=linspace(0+ACdelTh,pi+ACdelTh,511);
[ex,why]=polar_rectangular(las_dat,alpha);
[re_x,re_y,st_pt,en_pt]=resample_linepts(ex,why,pt_dis,lin_bk);


% To find the start and end points to fit a line with num_pt
[Spt,Enpt]=start_end(st_pt,en_pt,num_pt);
[fe_x,fe_y]=extpt_method(re_x,re_y,Spt,Enpt);

r=sqrt(fe_x.^2+fe_y.^2);
rta=atan2(fe_y,fe_x);

if isempty(fe_x)
else
    re=[fe_x; fe_y];
    po=[r; rta];
end
end