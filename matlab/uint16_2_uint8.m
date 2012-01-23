function img_out = uint16_2_uint8(I)
 % Normalize the image by convert to uint8 from 16bit images. On
 % the other hand, this is normalized by L0 norm of the image
 % values.
 img_out = uint8(round(double(I) / double(max(I(:))) * 255));