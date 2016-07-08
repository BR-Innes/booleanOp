expEvent(:, 1) = 1:70; % timestamps
expEvent(:, 2) = [zeros(62, 1); 20; 35; 40; 35; 20; zeros(3, 1)]; % data
plot(expEvent(:, 1), expEvent(:, 2)) 
