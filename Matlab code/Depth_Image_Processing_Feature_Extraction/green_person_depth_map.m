% Calculation of Foreground pixels and Equalized image for the green encoded
% person

function [green_segment_map, green_equalize] = green_person_depth_map(segmented_image)
    
    green_person = segmented_image(:,:,2);
    label_green = bwlabel(green_person);
    area_green = regionprops(label_green, green_person, 'Area');

    %idg1 = find([ar1.Area] < 100);

    [l, b, h] = size(segmented_image);
    
    idg2 = find([area_green.Area] > 100);
    [l1, b1] = size(idg2);

    green_segment_map = zeros(l,b);
    for i=1:b1
        label_green_1 = (label_green == idg2(1,i));
        green_segment_map = green_segment_map + label_green_1;
    end

    green_person = green_segment_map .* green_person;
    new_green_obj = green_person/255;

    green_equalize = imadjust(new_green_obj,[0.35 .6],[0.0 1.0],.8);
    
    %nobj(1:l,1:b,2)=green_equalize;
    %nobj(1:l,1:b,1)=zeros(l,b);
    %nobj(1:l,1:b,3)=zeros(l,b);

    %figure, imshow(nobj),title('depth map of the green object');
end