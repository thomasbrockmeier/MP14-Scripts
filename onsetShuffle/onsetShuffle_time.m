b = zeros(length(onsets), 1);
for i = length(onsets):-1:2
    b(i) = onsets(i) - onsets(i - 1);
end

b(1) = [];
b = shuffle(b);

c = zeros(length(onsets), 1);
c(1) = b(1);

for ii = 2:length(b)
    c(ii) = c(ii-1)+b(ii);
end
c(end) = [];
[ S, f, ~ ] = mtspectrumpt(c, PARAMS);