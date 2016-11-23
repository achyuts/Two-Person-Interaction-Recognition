% Handling the limitation in Kinect sensor when the color encoding
% of the people in the interaction switches. 
% Swapping the blue and green encoded maps in that case to extract feature for the right person.

function [green_equalize, blue_equalize, green_segment_map, blue_segment_map, prev_green_centrdx, prev_green_centrdy, flag1] = motion_handle(centroid_green, centroid_blue, green_equalize, blue_equalize, green_segment_map, blue_segment_map, flag1, prev_green_centrdx, prev_green_centrdy)
    
    if flag1 == 0
        prev_green_centrdx = centroid_green(:,1);
        prev_green_centrdy = centroid_green(:,2);
        %prev_blue_centrdx = centroid_blue(:,1);
        %prev_blue_centrdy = centroid_blue(:,2);
        flag1=1;
    end
        
    dis1 = ((centroid_green(:,1)-prev_green_centrdx).^2)+((centroid_green(:,2)-prev_green_centrdy).^2);
    dis2 = ((centroid_blue(:,1)-prev_green_centrdx).^2)+((centroid_blue(:,2)-prev_green_centrdy).^2);

    %dis3 = ((centroid_green(:,1)-prev_blue_centrdx).^2)+((centroid_green(:,2)-prev_blue_centrdy).^2);
    %dis4 = ((centroid_blue(:,1)-prev_blue_centrdx).^2)+((centroid_blue(:,2)-prev_blue_centrdy).^2);

    if dis1 > dis2
        map_swap = green_segment_map;
        green_segment_map = blue_segment_map;
        blue_segment_map = map_swap;

        sw=green_equalize;
        green_equalize = blue_equalize;
        blue_equalize=sw;

        %prev_blue_centrdx = centroid_green(:,1);
        %prev_blue_centrdy = centroid_green(:,2);
        prev_green_centrdx = centroid_blue(:,1);
        prev_green_centrdy = centroid_blue(:,2);
    end
end