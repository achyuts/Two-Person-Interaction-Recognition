% Calculation of Bounding Box around Region of Interest

function [roi_img, roi_img_grayscale, roi_xl, roi_xu, roi_yl, roi_yu] = bounding_box_calculate(green_segment_map, blue_segment_map, equalized_image_grayscale)

    % Green Encoding Bounding Box
    bbox = regionprops(green_segment_map,'BoundingBox');
    bboxes=cat(1,bbox.BoundingBox);

    by11 = floor(bboxes(:,1));
    bx11 = floor(bboxes(:,2));

    by12 = floor(bboxes(:,1) + bboxes(:,3));
    bx12 = floor(bboxes(:,2) + bboxes(:,4));

    % Blue Encoding Bounding Box
    bbox = regionprops(blue_segment_map,'BoundingBox');
    bboxes=cat(1,bbox.BoundingBox);

    by21 = floor(bboxes(:,1));
    bx21 = floor(bboxes(:,2));

    by22 = floor(bboxes(:,1) + bboxes(:,3));
    bx22 = floor(bboxes(:,2) + bboxes(:,4));

    % Handling boundary cases
    if bx11==0 
        bx11=1;
    end

    if by11==0 
        by11=1;
    end

    if bx21==0 
        bx21=1;
    end

    if by21==0 
        by21=1;
    end


    % Bounding box calculation
    if bx11<=bx21
        roi_xl=bx11;
    else
        roi_xl=bx21;
    end

    if by11<=by21
        roi_yl=by11;
    else
        roi_yl=by21;
    end

    if bx12>=bx22
        roi_xu=bx12;
    else
        roi_xu=bx22;
    end

    if by12>=by22
        roi_yu=by12;
    else
        roi_yu=by22;
    end

    roi_img=zeros(240,320);
    roi_img(roi_xl:roi_xu,roi_yl:roi_yu)=255;
    %figure,imshow(roi),title('the roi');
    
    roi_img_grayscale = equalized_image_grayscale(roi_xl:roi_xu,roi_yl:roi_yu);
    %figure,imshow(roi_img),title('the roi image');
    %figure,imhist(roi_img),title('the histogram image');

    roi_img_grayscale=uint8(roi_img_grayscale.*255);
end