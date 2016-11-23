% Segmentation of foreground from image

function segmented_img = segment_img(image) 
    [l, b, h]=size(image);
    segmented_img = zeros(l,b,h);
    for x=1:240
        for y=1:320
            if (image(x,y,2) <= image(x,y,1)+12) && (image(x,y,3) <= image(x,y,1)+12)  
                segmented_img(x,y,:) = 0;
            else
                if image(x,y,2) > image(x,y,3)
                    segmented_img(x,y,2) = image(x,y,2);
                    segmented_img(x,y,1) = 0;
                    segmented_img(x,y,3) = 0;
                else
                    segmented_img(x,y,3) = image(x,y,3);
                    segmented_img(x,y,1) = 0;
                    segmented_img(x,y,2) = 0;
                end
            end
        end
    end
end