% Combining the depth equalized images into a single image

function equalized_image = depth_maps_joining(green_equalize, blue_equalize, l, b)
    equalized_image(1:l,1:b,2) = green_equalize;
    equalized_image(1:l,1:b,1) = zeros(l,b);
    equalized_image(1:l,1:b,3) = blue_equalize;
end