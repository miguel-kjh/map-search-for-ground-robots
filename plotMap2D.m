function [] = plotMap2D(pos,obs)
    figure(1);
    hold on;
    plot(pos.x,pos.y);
    xlabel('room width');
    ylabel('room depth');

    for i = 1:length(obs.x)
        obs_x = obs.x{i};
        obs_y = obs.y{i};
        plot(obs_x, obs_y, '.');
    end
end

