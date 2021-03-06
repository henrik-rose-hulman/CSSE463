addpath('./library/finalLandmarksIsh');
d = dir('./testImgs/happy/');

M = zeros(12, 1);
index = 1;
detector = buildDetector();

stdP = [];

for i = 4 : 2 : size(d, 1) - 1
    fileName1 = [pwd '/testImgs/happy/' d(i, 1).name];
    stdImg = imread(fileName1);
    stdP = landmark(stdImg, detector);
    if isempty(stdP)
        continue;
    end
    fileName2 = [pwd '/testImgs/happy/' d(i + 1, 1).name];
    emoImg = imread(fileName2);
    emoP = landmark(emoImg, detector);
    if isempty(emoP)
        continue;
    end
    motionVec = emoP - stdP;
    M(:, index) = motionVec(:);
    index = index + 1;
end


happy = 0;
surprise = 0;
neutral = 0;
for i = 1 : size(M, 2)
    result = nearestMean4(M(:, i));
    if result == 1
        happy = happy + 1;
    elseif result == 2
        surprise = surprise + 1;
    else 
        neutral = neutral + 1;
    end
end

happy / size(M, 2)