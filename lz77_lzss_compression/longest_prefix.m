function [prefix, dist] = longest_prefix(labuffer,sbuffer)
    prefix = '';
    dist = 0;
    for i=length(labuffer)-1:-1:1
        s = labuffer(1:i);
        k = strfind(sbuffer, s);
        if isempty(k)
            continue
        else
            prefix = s;
            dist = length(sbuffer)-k(end)+1;
            break
        end
    end
end