% Calculation of Foreground pixels and Equalized image for the blue encoded
% person

function [blue_segment_map, blue_equalize] = blue_person_depth_map(segmented_image)
    blue_person = segmented_image(:,:,3);
    label_blue = bwlabel(blue_person);
    area_blue = regionprops(label_blue, blue_person, 'Area');

    %idb1 = find([areab.Area] < 100);
    
    [l, b, h] = size(segmented_image);
    
    idb2 = find([area_blue.Area] > 100);
    
    [l1, b1]=size(idb2);

    blue_segment_map = zeros(l,b);
    for i=1:b1
        label_blue_1 = (label_blue == idb2(1,i));
        blue_segment_map = blue_segment_map + label_blue_1;
    end

    blue_person= blue_segment_map .* blue_person;
    new_blue_obj = blue_person/255;

    blue_equalize = imadjust(new_blue_obj,[0.35 .76],[0.0 1.0],.8);    
end