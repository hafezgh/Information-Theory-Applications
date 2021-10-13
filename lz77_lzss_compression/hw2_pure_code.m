% Hafez Ghaemi - s289963
% LZ77 and LZSS implementation
clc;
clear;
close all;

input_str_or_path = 'abracadabrarray';

sbuffer_len = 8;
labuffer_len = 6;

encoded_output_lz77 = lz77(input_str_or_path, sbuffer_len, labuffer_len);
encoded_output_lzss = lzss(input_str_or_path, sbuffer_len, labuffer_len);

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

alphabet = append('a':'z','A':'Z', ' ');
n = length(alphabet);
freqs = zeros(1,n);
for i=1:length(input_str)
    ind = strfind(alphabet, input_str(i));
    freqs(ind) = freqs(ind)+1;
end

bits_no_comp = ceil(log2(n))*length(input_str);
bits_lz77 = length(encoded_output_lzss)*(ceil(log2(sbuffer_len))+ceil(log2(labuffer_len))+ceil(log2(n)));
bits_lzss = 0;
for i=1:length(encoded_output_lzss)
    if encoded_output_lzss{i,1} == 0
        bits_lzss = bits_lzss + 1 + ceil(log2(n));
    else
        bits_lzss = bits_lzss + 1 + ceil(log2(sbuffer_len)) + ceil(log2(labuffer_len)) + ceil(log2(n));
    end
end

output_lz77 = '';
for i=1:length(encoded_output_lz77)
    output_lz77 = append(output_lz77, '(', num2str(encoded_output_lz77{i,1}),...
        ', ',num2str(encoded_output_lz77{i,2}),', ',num2str(encoded_output_lz77{i,3}),')');
    if i ~= length(encoded_output_lz77)
        output_lz77 = append(output_lz77, ', ');
    end
end

output_lzss = '';
for i=1:length(encoded_output_lzss)
    if encoded_output_lzss{i,1} ~= 0
        output_lzss = append(output_lzss, '(', '1, ', num2str(encoded_output_lzss{i,1}),...
            ', ',num2str(encoded_output_lzss{i,2}),', ',num2str(encoded_output_lzss{i,3}),')');
    else
        output_lzss = append(output_lzss, '(', num2str(encoded_output_lzss{i,1}),...
            ', ',num2str(encoded_output_lzss{i,2}),')');
    end
    if i ~= length(encoded_output_lzss)
        output_lzss = append(output_lzss, ', ');
    end
end

bytes_no_comp = bits_no_comp/8/length(input_str)
bytes_lz77 = bits_lz77/8/length(input_str)
bytes_lzss = bits_lzss/8/length(input_str)
output_lz77
output_lzss

