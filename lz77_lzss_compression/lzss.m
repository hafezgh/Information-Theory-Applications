function [encoded_output] =  lzss(input_str_or_path, sbuffer_len, labuffer_len)

if isfile(input_str_or_path)
    input_str = fileread(input_str_or_path);
else
    if isfile(append(input_str_or_path, '.txt'))
        input_str = fileread(append(input_str_or_path, '.txt'));
    else
        input_str = input_str_or_path;
    end
    
end
input_str = regexprep(input_str,'[^a-z^A-Z\s]','');
input_length = length(input_str);
if labuffer_len > input_length
    labuffer_len = input_length;
end
sbuffer = '';
input_counter = labuffer_len;
encoded_output = {};
counter_output = 1;

labuffer = input_str(1:labuffer_len);


while isempty(labuffer) ~= true
    [prefix, dist] = longest_prefix(labuffer, sbuffer);
    if isempty(prefix)
        d=0;
        l=0;
        c=labuffer(1);
    else
        d = dist;
        l = length(prefix);
        c = labuffer(length(prefix)+1);
    end
    if d==0
        encoded_output{counter_output,1} = 0;
        encoded_output{counter_output,2} = c;
    else
        encoded_output{counter_output,1} = d;
        encoded_output{counter_output,2} = l;
        encoded_output{counter_output,3} = c;
    end
    counter_output = counter_output + 1;
    %sbuffer(1:l+1) = [];
    s = labuffer(1:l+1);
    labuffer(1:l+1) = [];
    sbuffer = append(sbuffer, s);
    if length(sbuffer) > sbuffer_len
        sbuffer(1:length(sbuffer)-sbuffer_len)=[];
    end
    labuffer_cap = labuffer_len-length(labuffer);
    if input_counter ~= input_length
        if input_counter+1+labuffer_cap <= input_length
            labuffer = append(labuffer, input_str(input_counter+1:input_counter+1+labuffer_cap-1));
            input_counter = input_counter + labuffer_cap;
        else
            labuffer = append(labuffer, input_str(input_counter+1:end));
            input_counter = input_length;
        end
    end
end