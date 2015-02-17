figures = dir([pwd '\*.tif']);
for i = 1:length(figures)
    img = imread(figures(i).name);
    img = imcrop(img,[175 0 350 500]);
    imwrite(img, [pwd '\crop\' figures(i).name]);
    
    subplot(8, 7, i)
    imshow(img)
end