function [K] = GetCameraParams(calibrationSession)
%La fonction renvoie les parametres intrinseque de la Camera
K = calibrationSession.CameraParameters.IntrinsicMatrix.' ;

end