% Select and read the first image
[fileName, filePath] = uigetfile('C:\Users\Nazeema S\Desktop\18th work\sign  1.jpg');
I1 = rgb2gray(imread(fullfile(filePath, fileName)));
% Select and read the second image
[fileName, filePath] = uigetfile('C:\Users\Nazeema S\Desktop\18th work\nazafrinsign.jpeg');
I2 = rgb2gray(imread(fullfile(filePath, fileName)));
% Display the images
figure(1);
subplot(2,2,1); imshow(I1); title('Image 1');
subplot(2,2,3); imshow(I2); title('Image 2');
% Detect Harris features in both images
points1 = detectHarrisFeatures(I1); subplot(2,2,2); imshow(I1); hold on; plot(points1); title('Harris Features in Image 1');
points2 = detectHarrisFeatures(I2); subplot(2,2,4); imshow(I2); hold on; plot(points2); title('Harris Features in Image 2');
% Extract features and valid points
[features1, valid_points1] = extractFeatures(I1, points1);
[features2, valid_points2] = extractFeatures(I2, points2);
% Match features between the two images
indexPairs = matchFeatures(features1, features2);
% Retrieve the locations of the matched points
matchedPoints1 = valid_points1(indexPairs(:, 1));
matchedPoints2 = valid_points2(indexPairs(:, 2));
% Display matched features
figure(2);
showMatchedFeatures(I1, I2, matchedPoints1, matchedPoints2);
title('Matched Points');
% Calculate the difference in metrics
u = abs(matchedPoints2.Metric - matchedPoints1.Metric);
% Check if the images are matched based on metric difference
if all(u <= 1)
disp('Matched');
else
disp('Not Matched');
end
% METHOD - 2: Using the SURF Algorithm
% Display the images again
figure(3);
subplot(2,2,1); imshow(I1); title('Image 1');
subplot(2,2,3); imshow(I2); title('Image 2');
% Detect SURF features in both images
ref_points = detectSURFFeatures(I1); subplot(2,2,2); imshow(I1); hold on; plot(ref_points); title('SURF Features in Image 1');
test_points = detectSURFFeatures(I2); subplot(2,2,4); imshow(I2); hold on; plot(test_points); title('SURF Features in Image 2');
% Extract SURF features
[ref_features, ref_validPoints] = extractFeatures(I1, ref_points);
[test_features, test_validPoints] = extractFeatures(I2, test_points);
% Match features between the two images
indexPairs_SURF = matchFeatures(ref_features, test_features);
% Calculate the number of matches found
num_matches = size(indexPairs_SURF, 1);
% Set a threshold for the number of matches needed for verification
threshold = 90;
% Compare the number of matches to the threshold
if num_matches >= threshold
disp('Signature verified');
else
disp('Signature not verified');
end
