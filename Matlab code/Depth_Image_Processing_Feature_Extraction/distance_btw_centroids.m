% Calculation of position of centroids of blue & green encoded person and
% the distance between their centroids

function [centroids_green, centroids_blue, distance_centroid] = distance_btw_centroids(equalized_image, green_segment_map, blue_segment_map)
    
    label_centroid_green  = regionprops(green_segment_map, 'centroid');
    centroids_green = cat(1, label_centroid_green.Centroid);

    label_centroid_blue  = regionprops(blue_segment_map, 'centroid');
    centroids_blue = cat(1, label_centroid_blue.Centroid);

    distance_centroid = (((centroids_green(:,1) - centroids_blue(:,1)).^2) + ((centroids_green(:,2) - centroids_blue(:,2)).^2))/100000;

    figure,imshow(equalized_image)
    hold on
    plot(centroids_green(:,1), centroids_green(:,2), 'r*')
    plot(centroids_blue(:,1), centroids_blue(:,2), 'r*')
    hold off
    imwrite(equalized_image,'Centroid_Shown.jpeg');
end