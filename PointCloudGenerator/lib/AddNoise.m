function ptCloud_noisy = AddNoise( ptCloud, sigma, normalize_to_ptCloud )
% Add Noise to a point cloud
% Parameters:
%   ptCloud - point cloud
%   sigma - standard deviation of the noise
%   normalize_to_ptCloud (optional) - normalize sigma to he pt. cloud diameter (1:
%       yes, 2 false) - yes by default

if nargin<3
    normalize_to_ptCloud=1;
end

N = ptCloud.Count;  

%% if necessary give a more suitable scale to sigma
if(normalize_to_ptCloud)
    diameters = [
        abs(ptCloud.XLimits(1)-ptCloud.XLimits(2)) ...
        abs(ptCloud.YLimits(1)-ptCloud.YLimits(2))...
        abs(ptCloud.ZLimits(1)-ptCloud.ZLimits(2))];
    scale = max(diameters);
else
    scale=1; 
end

%% add zero mean random Gaussian noise
abs_sigma = scale*sigma; % std in absolute scale
noise = normrnd(0, abs_sigma, [N,3]);
pt_noisy = ptCloud.Location + noise;
ptCloud_noisy = pointCloud(pt_noisy);

end
