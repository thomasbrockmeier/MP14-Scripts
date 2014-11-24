aaa=shuffle(aa);
aaaa = zeros(sum(aaa),1);

counter = 0;
for i = 1:length(aaa)
    counter = counter+1;
    aaaa(counter) = aaa(i);
    for j = 1:aaa(i)-1
        counter = counter+1;
        aaaa(counter) = 0;
    end
end

%aaaa(aaaa~=0)=1;

[ S, f, ~ ] = mtspectrumpb(aaaa, PARAMS);