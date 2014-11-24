function vec = rhythm2spikeTrain(a)

vec = zeros(uint32(sum(a) / (1/32)), 1);
% addOnset = 0;
% for i = 1:size(a, 1)
%     addOnset = uint32(addOnset + (a(i) / (1/32)));
%     vec(addOnset) = 1;
% end
% end

c = 0;
for i = 1:size(a, 1)
    for j = 1:(a(i)/(1/32))
        c = c + 1;
        vec(c) = a(i);
    end
end