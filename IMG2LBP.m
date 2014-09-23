function [lbpf]=IMG2LBP(im, cellheight, cellwidth)

%LBP preparation
unipats = uniform_pattern(8)';
np = size(unipats,1)+1;
map = np*ones(2^8,1);
map(1+unipats) = [1:np-1]';



    % LBP feature extraction
    lbp = lbp_image(double(im),'P8R2');
    lbp = map(1+lbp);
    h = lbp_histo([1:np]',im2col(lbp,[cellheight cellwidth],'distinct')); 
    lbpf = reshape(h, size(h,1)*size(h,2), 1);
   % lbpf = lbpf-mean(lbpf); 
    lbpf = lbpf/norm(lbpf);
