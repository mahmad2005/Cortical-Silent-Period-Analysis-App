f1 = figure;
t = -pi:0.01:pi;
amp = sin(t);
plot(t,amp);
hold on;           % and keep it there while we plot
xs = [];
ys = [];           % initialisations
xold = 0;
yold = 0;
but = 1;
global x_pos;
global y_pos;


% while but == 1                      % while button 1 being pressed
%     [xi, yi, but] = ginput(1);      % get a point
%     xs = [xs; xi];                  % append its coords to vector
%     ys = [ys; yi];
%     if xold;
%         plot([xold xi], [yold yi], 'go-');  % draw as we go
%     else
%         plot(xi, yi, 'go');         % first point on its own
%     end;
%     xold = xi;
%     yold = yi;
% end;
% 
% plot([xi xs(1)], [yi ys(1)], 'g-'); % join first to last points
% hold off;

% set(f1, 'WindowButtonMotionFcn', @mouseMove);
% mosuePOS = mouseMove();
% plot(t,amp);
% plot(mosuePOS(1), mosuePOS(2), '*');
% 
% function getMousePOS = mouseMove (~, ~)
% cla;
% C = get (gca, 'CurrentPoint');
% title(gca, ['(X,Y) = (', num2str(C(1,1)), ', ',num2str(C(1,2)), ')']);
%  x_pos = (C(1,1));
%  y_pos = (C(1,2));
% txt = ['Potential: ' num2str(x_pos) ' mV'];
% text(x_pos,y_pos-0.40,txt);
% getMousePOS = [x_pos, y_pos];
% end


windowsize = 40;
set(gcf, 'WindowButtonMotionFcn', @(source, eventarg) mg_BPP_mouseMove(source, eventarg, windowsize));
 function mg_BPP_mouseMove(object, eventdata, windowSize)
      persistent lastrect;      
      C = get (gca, 'CurrentPoint');
      topLeftCornerX = round(C(1,1)) - windowSize/2;
      topLeftCornerY = round(C(1,2)) - windowSize/2;
      width = windowSize;
      height = windowSize;
      if ~isempty(lastrect) && lastrect.isvalid
         delete(lastrect);
      end
      lastrect = imrect(gca, [topLeftCornerX, topLeftCornerY, width, height]);
  end
