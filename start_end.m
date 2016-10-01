function [Spt,Enpt]=start_end(st_pt,en_pt,num)
    num_sten=en_pt-st_pt+1;
    % The minmum number of points for a line to exist is num_pt (num_sten)
    gre=find(num_sten>=num);
    for i1=1:length(gre)
        Spt(i1)=st_pt(gre(i1));
        Enpt(i1)=en_pt(gre(i1));
    end
end