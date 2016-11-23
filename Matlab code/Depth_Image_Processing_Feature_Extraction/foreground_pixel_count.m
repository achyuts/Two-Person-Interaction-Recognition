% Normalized foreground pixel count calculation

function normalized_pixel_count = foreground_pixel_count(green_segment_map, blue_segment_map, l, b)

    segment_maps = green_segment_map + blue_segment_map;
    %figure,imshow(present_segmented),title('the final segmented images');

    count_px = find(segment_maps);
    [x, r] = size(count_px);
    normalized_pixel_count = x/(l*b);

end