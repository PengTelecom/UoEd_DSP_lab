function tri = triangle(centre,width);
    t = [0:100-1];
    tri = zeros(1,100);
    step = 1 ./ (width/2);
    tri(centre-(width/2)+1:centre+1) = 0:step:1;
    tri(centre+1:centre+(width/2)+1) = 1:-1 * step:0;
%     figure(1)
%     plot(t,tri)
end
