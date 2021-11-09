t = linspace(0,2*pi,100);
x = cos(t);
y = sin(t);
z = t;
c = cos(t).^2;
colormap(hsv)
patch([x nan],[y nan],[z nan],[c nan],'FaceColor','none','EdgeColor','interp')
colorbar
view(3)

%%
x = 0:.05:2*pi;
y = sin(x);
z = zeros(size(x)); % We don't need a z-coordinate since we are plotting a 2d function
C = cos(x);  % This is the color, vary with x in this case.
surface([x;x],[y;y],[z;z],[C;C],...
        'FaceColor','none',...
        'EdgeColor','interp');