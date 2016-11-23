% Calculation of normalized difference image pixel count

function [no_pixel_diff_norm, previous_segmented_frame] = normalized_difference_image_pixel_count(green_segment_map, blue_segment_map, previous_segmented_frame)

    current_frame_segment_map = green_segment_map + blue_segment_map;
    
    dif_image=current_frame_segment_map - previous_segmented_frame;
    %figure,imshow(dif_image),title('difference image');
    
    previous_segmented_frame = current_frame_segment_map;
           
    [xdif, ydif]=find(dif_image);
    [no_pixel_dif,waste1]=size(xdif);

    [xpr, ypr]=find(current_frame_segment_map);
    [no_pixel_prs, waste1]=size(xpr);
    no_pixel_diff_norm=no_pixel_dif/no_pixel_prs;
end