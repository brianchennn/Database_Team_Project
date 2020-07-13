drop table if exists pitch_type_create_table_per_year; 
create table pitch_type_create_table_per_year(
select  
        PTPG.years,
        PTPG.id,
        PTPG.first_name,
        PTPG.last_name,
        sum(PTPG.FF),
        pitcher_FF.FF_v0_avg,
        pitcher_FF.FF_v_delta_avg,
        pitcher_FF.FF_y_delta_avg,
        pitcher_FF.FF_spin_rate_avg,
        sum(PTPG.CH),
        pitcher_CH.CH_v0_avg,
        pitcher_CH.CH_v_delta_avg,
        pitcher_CH.CH_y_delta_avg,
        pitcher_CH.CH_spin_rate_avg,
        sum(PTPG.EP),pitcher_EP.EP_v0_avg,
        pitcher_EP.EP_v_delta_avg,
        pitcher_EP.EP_y_delta_avg,
        pitcher_EP.EP_spin_rate_avg
        

from pitch_type_per_game2 as PTPG,
     pitcher_FF,
     pitcher_CH,
     pitcher_EP
     

where   PTPG.years=pitcher_FF.years 
    and pitcher_FF.years=pitcher_CH.years
    and pitcher_CH.years=pitcher_EP.years

    and PTPG.id=pitcher_FF.pitcher_id
    and pitcher_FF.pitcher_id=pitcher_CH.pitcher_id
    and pitcher_CH.pitcher_id=pitcher_EP.pitcher_id
    
group by PTPG.years,PTPG.id
);
    
    