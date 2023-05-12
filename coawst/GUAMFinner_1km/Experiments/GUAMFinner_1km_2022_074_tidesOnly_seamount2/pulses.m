% Consider a Gaussian pulse


x = [-10:.1:10];

fig(1);clf;
plot(x,exp(-(x.^2)))

t = [-20:20];

fig(2);clf;
plot(x,exp(  -(x-t(1)).^2  ) )

% Here is a plot of a pair of counterpropagating pulses
for tt=1:length(t)
    plot(x,exp(-(x-t(tt)).^2)+exp(-(-x-t(tt)).^2) );ylim(2*[0 1])
    pause(.2)
end;

%% So here is the task
%   Given a data set that represents the colliding pulses

data = zeros(length(t),length(x));
for tt=1:length(t); for ii=1:length(x)
        data(tt,ii) = exp(-(x(ii)-t(tt)).^2)+exp(-(-x(ii)-t(tt)).^2);
    end;end;

%   can I separate the leftward-propagating part from 
%   the rightward-propagating part?
