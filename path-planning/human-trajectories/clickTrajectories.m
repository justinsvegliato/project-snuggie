close all;

% Open image
imshow('full_map.png');

viconCoords = cnvFn(getline(gcf)');

fprintf('(%.3f,%.3f),',viconCoords);
fprintf('\n\n');