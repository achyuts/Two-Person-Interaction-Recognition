%Calculating average pixel depth for blue and green encoding 

function [avg_depth_blue, avg_depth_green] = average_grayscale_pixel(green_segment_map, blue_segment_map, green_equalize, blue_equalize)

    [varx1,vary1]=find(blue_segment_map);
    [lenx1,lenx11]=size(varx1);

    sblue1=sum(blue_equalize);
    sblue2=sum(sblue1);

    avg_depth_blue=sblue2/lenx1;

    %green 
    [varx2,vary2]=find(green_segment_map);
    [lenx2,lenx22]=size(varx2);

    sgreen1=sum(green_equalize);
    sgreen2=sum(sgreen1);

    avg_depth_green=sgreen2/lenx2;
end