create table spin_strike_rate(
select T.year, T.first_name,T.last_name,T.p_throws as pitcher_throws ,T.stand as batter_stand,T.pitch_type,T.Spin,sum(strike_cnt)/sum(cnt) as strike_ratio
from(select substring(A.ab_id,1,4) as year,
            PN.first_name,PN.last_name,A.p_throws,A.stand,P.pitch_type,P.code,round(avg(P.spin_rate),0) as Spin,
            if( P.code="S" or P.code="C" or P.code="T" or (P.code="F" and P.s_count!=2),count(*),0) as strike_cnt,count(*) as cnt,P.start_speed,P.spin_rate
    from(
        pitches as P,
        atbats as A,
        player_names as PN
    )
    where P.ab_id = A.ab_id and A.pitcher_id = PN.id
    group by year,PN.first_name,PN.last_name,A.p_throws,A.stand,P.pitch_type,P.code) as T
group by year,T.first_name,T.last_name,T.p_throws,T.stand,T.pitch_type
having sum(cnt) >= 500
order by year asc,strike_ratio desc

);
