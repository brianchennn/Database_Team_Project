drop table pitcher_league_HR_FB_rate;
create table pitcher_league_HR_FB_rate(
  years varchar(4),
  HR_F float
);
insert into pitcher_league_HR_FB_rate
(years,HR_F)
VALUES
(2015,0.00114),
(2016,0.00128),
(2017,0.00137),
(2018,0.00127);