% Main function to extract the features from images
% Arguments start_index, end_index of the frames to process
% Returns the extracted features 

function [features_extracted] = main(start_index, end_index)
    tic
    for image_index = start_index : end_index
        
        fname = sprintf('%d.jpeg',image_index);

        % Reading the original image
        original_image = imread(fname);
        [l, b, h] = size(original_image);

        % Segmenting the image to get the foreground and remove noise
        segmented_image = segment_img(original_image);
        %segment_img=imread(segmented_image);
        figure,imshow(original_image),title('Original Image');
        imwrite(original_image,'Original_Image.jpeg');
        figure,imshow(segmented_image),title('Segmented Image');
        imwrite(segmented_image,'1_Segmented_Image.jpeg');
        
        % Calculation of the foreground segment map and equalized image of
        % the green encoded person
        [green_segment_map, green_equalize] = green_person_depth_map(segmented_image);
        figure,imshow(green_equalize),title('depth map of the green object');
        figure,imhist(green_equalize),title('histogram of the green object');
        imwrite(green_segment_map,'2_Green_Segment_Map.jpeg');
        imwrite(green_equalize,'3_Green_Equalized.jpeg');
        
        % Calculation of the foreground segment map and equalized image of
        % the blue encoded person
        [blue_segment_map, blue_equalize] = blue_person_depth_map(segmented_image);
        figure,imshow(blue_equalize),title('depth map of the blue object');
        figure,imhist(blue_equalize),title('histogram of the blue object');
        imwrite(blue_segment_map,'4_Blue_Segment_Map.jpeg');
        imwrite(blue_equalize,'5_Blue_Equalized.jpeg');

        % Joining the equalized individual images into a single equalized image
        [equalized_image] = depth_maps_joining(green_equalize, blue_equalize, l, b);
        
        % Extraction of features from the enhanced image
        % Calculation of distance between the centroids
        [centroid_green, centroid_blue, distance_centroid] = distance_btw_centroids(equalized_image, green_segment_map, blue_segment_map);

        % Handling the limitation in Kinect sensor when the color encoding
        % of the people in the interaction switches
        [green_equalize, blue_equalize, green_segment_map, blue_segment_map, prev_green_centrdx, prev_green_centrdy, flag1] = motion_handle(centroid_green, centroid_blue, green_equalize, blue_equalize, green_segment_map, blue_segment_map, 0, 0 ,0);

        % Joining the equalized individual images into a single equalized image
        % after handling the motion 
        [equalized_image] = depth_maps_joining(green_equalize, blue_equalize, l, b);
        [equalized_image_grayscale] = green_equalize + blue_equalize;
        imwrite(equalized_image,'6_Equalized_Image_Joined.jpeg');
        imwrite(equalized_image_grayscale,'7_Equalized_Image_Joined_Grayscale.jpeg');
        
        % Calculation of Bounding Box and extraction of Region of interest
        [roi_img, roi_img_grayscale, roi_xl, roi_xu, roi_yl, roi_yu] = bounding_box_calculate(green_segment_map, blue_segment_map, equalized_image_grayscale);
        figure,imshow(roi_img),title('The ROI Image');
        figure,imshow(roi_img_grayscale),title('The ROI Image Grayscale');
        figure,imhist(roi_img_grayscale),title('The Histogram of Grayscale Image');
        imwrite(roi_img,'8_ROI.jpeg');
        imwrite(roi_img_grayscale,'9_ROI_Enhanced_Image.jpeg');

        % Calculation of depth pixel intensity distribution feature
        [roi_distribution_bins] = pixel_intensity_distribution_bins(equalized_image_grayscale, roi_xl, roi_xu, roi_yl, roi_yu, l, b);

        % Calculation of Average depth of blue and green encoded person
        [avg_depth_blue, avg_depth_green] = average_grayscale_pixel(green_segment_map, blue_segment_map, green_equalize, blue_equalize);

        % Calculation of normalized foreground pixel count
        normalized_pixel_count = foreground_pixel_count(green_segment_map, blue_segment_map, l, b);

        % Calculation of normalized difference image pixel count
        if image_index== 1
            previous_segmented_frame = zeros(l,b);
        end
        
        [no_pixel_diff_norm, previous_segmented_frame] = normalized_difference_image_pixel_count(green_segment_map, blue_segment_map, previous_segmented_frame);

        % Feature Vector generation with the features extracted above
        % distance_centroid: Distance between the centroids
        % avg_depth_green: Average depth of the green encoded person pixels
        % avg_depth_blue: Average depth of the blue encoded person pixels
        % no_pixel_diff_norm: Normalized difference image pixel count
        % normalized_pixel_count: Normalized foreground pixel count
        % roi_distribution_bins: Depth pixel intensity distribution feature
        feature_vector(1,:)=[distance_centroid avg_depth_green avg_depth_blue no_pixel_diff_norm normalized_pixel_count roi_distribution_bins];
        
        % Stores the features for all the image frames
        features_extracted(image_index,:) = feature_vector;
        
        clear feature_vector
    end
    toc
end