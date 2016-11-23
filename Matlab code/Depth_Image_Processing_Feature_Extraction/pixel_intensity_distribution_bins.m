% Calculation of region of interest depth pixel intensity distribution feature

function [roi_distribution_bins] = pixel_intensity_distribution_bins(equalized_image_grayscale, roi_xl, roi_xu, roi_yl, roi_yu, l, b)
    loopsx=8;
    loopsy=5;
    flag2=0;

    xinc=ceil((roi_xu - roi_xl)/loopsx);
    yinc=ceil((roi_yu - roi_yl)/loopsy);

    roi_yl_save = roi_yl;

    xu=roi_xl+xinc;
    yu=roi_yl+yinc;

    nval(1,5)=0;
    equalized_image_grayscale=uint8(equalized_image_grayscale.*255);

    for i=1:loopsx
         for j=1:loopsy

             imgpart=equalized_image_grayscale(roi_xl:xu,roi_yl:yu);
             %figure,imshow(imgpart);
             %[counts bins]=imhist(imgpart,8);
             %val=transpose(counts);
             %nval=[nval val];

             total_counts=0;
             cint=[0 0 0 0 0];
             binterval=[0 20 100 180 255];
             for lp=roi_xl:xu
                 nnn=histc(equalized_image_grayscale(lp,roi_yl:yu),binterval);
                 cint=cint+nnn;
             end
             %counts=cint;        
             %total_counts=sum(cint(:));
             %val=transpose(counts);
             total_counts=l*b;
             val=cint/total_counts;

             if flag2==0
                 nval=val;
                 flag2=1;
             else
                 nval=[nval val];
             end

             roi_yl=yu;
             yu=yu+yinc;
             if yu>roi_yu
                 yu=roi_yu;
             end

          end

          roi_xl=xu;
          xu=xu+xinc;

          if xu>roi_xu
             xu=roi_xu;
          end

          roi_yl = roi_yl_save;
          yu = roi_yl+yinc;
    end

    roi_distribution_bins=nval;
    clear nval;
end