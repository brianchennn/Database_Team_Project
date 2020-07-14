/*每場球每位投手使用的每種球種數量*/
/*
drop table if  exists pitch_type_per_game;
create table pitch_type_per_game
(
SELECT years,id
       first_name,
       last_name,
       g_id,
       count(pitch_type="FF") as Four_seam,
       count(pitch_type="FT") as Two_seam,
       count(pitch_type="FO"） or pitch_type="GO") as Pitchout, 
       count(pitch_type="SI") as Sinker,
       count(pitch_type="SL") as Slider,
       count(pitch_type="CH") as Changeup,
       count(pitch_type="FC") as Cutter, 
       count(pitch_type="FS") as Splitter,
       count(pitch_type="KC") as Knuckle_ball,
       count(pitch_type="SC") as Screwball,
       count(pitch_type="IN") as Intentional_ball,
       count(pitch_type="EP") as EP,
       count(pitch_type="UN") as Unknown

FROM(
    SELECT SUBSTRING(A.ab_id, 1, 4) AS years,
        PL.id,
        PL.first_name,
        PL.last_name,
        A.g_id,
        P.ab_id,
        if(P.pitch_type="FF",1,0) as FF
    FROM pitches as P, atbats as A, player_names as PL
    WHERE P.ab_id=A.ab_id and PL.id=A.pitcher_id
) as T 
GROUP BY T.years, T.id, T.g_id 
);
*/
drop table if exists t_FF;
drop table if exists t_CH;
drop table if exists t_CU;
drop table if exists t_EP;
drop table if exists t_FC;
drop table if exists t_PO;
drop table if exists t_FS;
drop table if exists t_FT;
drop table if exists t_IN;
drop table if exists t_KC;
drop table if exists t_KN;
drop table if exists t_UN;
drop table if exists t_SC;
drop table if exists t_SI;
drop table if exists t_SL;
drop table if exists temp1;
drop table if exists temp2;
drop table if exists temp3;
drop table if exists temp4;
drop table if exists temp5;
drop table if exists temp6;
drop table if exists temp7;
drop table if exists temp8;
drop table if exists temp9;
drop table if exists temp10;
drop table if exists temp11;
drop table if exists temp12;
drop table if exists temp13;

create table t_FF(
SELECT years,
       T.id,
       T.first_name,
       T.last_name,
       T.g_id,
       sum(FF) as FF
FROM    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years,
        PL.id,
        PL.first_name,
        PL.last_name,
        A.g_id,
        P.ab_id,
        if(P.pitch_type="FF",1,0) as FF
    FROM pitches as P, atbats as A, player_names as PL
    WHERE P.ab_id=A.ab_id and PL.id=A.pitcher_id) as T
GROUP BY years,T.id,T.g_id
);
ALTER TABLE t_FF
ADD primary key(g_id,id);

create table t_CH(
SELECT years,
       T.id,
       T.first_name,
       T.last_name,
       T.g_id,
       sum(CH) as CH
FROM    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years,
        PL.id,
        PL.first_name,
        PL.last_name,
        A.g_id,
        P.ab_id,
        if(P.pitch_type="CH",1,0) as CH
    FROM pitches as P, atbats as A, player_names as PL
    WHERE P.ab_id=A.ab_id and PL.id=A.pitcher_id) as T
GROUP BY years,T.id,T.g_id
);
ALTER TABLE t_CH
ADD primary key(g_id,id);


create table t_CU(
SELECT years,
       T.id,
       T.first_name,
       T.last_name,
       T.g_id,
       sum(CU) as CU
FROM    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years,
        PL.id,
        PL.first_name,
        PL.last_name,
        A.g_id,
        P.ab_id,
        if(P.pitch_type="CU",1,0) as CU
    FROM pitches as P, atbats as A, player_names as PL
    WHERE P.ab_id=A.ab_id and PL.id=A.pitcher_id) as T
GROUP BY years,T.id,T.g_id
);
ALTER TABLE t_CU
ADD primary key(g_id,id);

create table t_EP(
SELECT years,
       T.id,
       T.first_name,
       T.last_name,
       T.g_id,
       sum(CU) as EP
FROM    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years,
        PL.id,
        PL.first_name,
        PL.last_name,
        A.g_id,
        P.ab_id,
        if(P.pitch_type="EP",1,0) as CU
    FROM pitches as P, atbats as A, player_names as PL
    WHERE P.ab_id=A.ab_id and PL.id=A.pitcher_id) as T
GROUP BY years,T.id,T.g_id
);
ALTER TABLE t_EP
ADD primary key(g_id,id);

create table t_FC(
SELECT years,
       T.id,
       T.first_name,
       T.last_name,
       T.g_id,
       sum(CU) as FC
FROM    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years,
        PL.id,
        PL.first_name,
        PL.last_name,
        A.g_id,
        P.ab_id,
        if(P.pitch_type="FC",1,0) as CU
    FROM pitches as P, atbats as A, player_names as PL
    WHERE P.ab_id=A.ab_id and PL.id=A.pitcher_id) as T
GROUP BY years,T.id,T.g_id
);
ALTER TABLE t_FC
ADD primary key(g_id,id);



create table t_PO(
SELECT years,
       T.id,
       T.first_name,
       T.last_name,
       T.g_id,
       sum(CU) as PO
FROM    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years,
        PL.id,
        PL.first_name,
        PL.last_name,
        A.g_id,
        P.ab_id,
        if(P.pitch_type="FO" or P.pitch_type="PO",1,0) as CU
    FROM pitches as P, atbats as A, player_names as PL
    WHERE P.ab_id=A.ab_id and PL.id=A.pitcher_id) as T
GROUP BY years,T.id,T.g_id
);
ALTER TABLE t_PO
ADD primary key(g_id,id);

create table t_FS(
SELECT years,
       T.id,
       T.first_name,
       T.last_name,
       T.g_id,
       sum(CU) as FS
FROM    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years,
        PL.id,
        PL.first_name,
        PL.last_name,
        A.g_id,
        P.ab_id,
        if(P.pitch_type="FS",1,0) as CU
    FROM pitches as P, atbats as A, player_names as PL
    WHERE P.ab_id=A.ab_id and PL.id=A.pitcher_id) as T
GROUP BY years,T.id,T.g_id
);
ALTER TABLE t_FS
ADD primary key(g_id,id);

create table t_FT(
SELECT years,
       T.id,
       T.first_name,
       T.last_name,
       T.g_id,
       sum(CU) as FT
FROM    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years,
        PL.id,
        PL.first_name,
        PL.last_name,
        A.g_id,
        P.ab_id,
        if(P.pitch_type="FT",1,0) as CU
    FROM pitches as P, atbats as A, player_names as PL
    WHERE P.ab_id=A.ab_id and PL.id=A.pitcher_id) as T
GROUP BY years,T.id,T.g_id
);
ALTER TABLE t_FT
ADD primary key(g_id,id);

create table t_IN(
SELECT years,
       T.id,
       T.first_name,
       T.last_name,
       T.g_id,
       sum(CU) as "IN"
FROM    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years,
        PL.id,
        PL.first_name,
        PL.last_name,
        A.g_id,
        P.ab_id,
        if(P.pitch_type="IN",1,0) as CU
    FROM pitches as P, atbats as A, player_names as PL
    WHERE P.ab_id=A.ab_id and PL.id=A.pitcher_id) as T
GROUP BY years,T.id,T.g_id
);
ALTER TABLE t_IN
ADD primary key(g_id,id);

create table t_KC(
SELECT years,
       T.id,
       T.first_name,
       T.last_name,
       T.g_id,
       sum(CU) as KC
FROM    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years,
        PL.id,
        PL.first_name,
        PL.last_name,
        A.g_id,
        P.ab_id,
        if(P.pitch_type="KC",1,0) as CU
    FROM pitches as P, atbats as A, player_names as PL
    WHERE P.ab_id=A.ab_id and PL.id=A.pitcher_id) as T
GROUP BY years,T.id,T.g_id
);
ALTER TABLE t_KC
ADD primary key(g_id,id);

create table t_KN(
SELECT years,
       T.id,
       T.first_name,
       T.last_name,
       T.g_id,
       sum(CU) as KN
FROM    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years,
        PL.id,
        PL.first_name,
        PL.last_name,
        A.g_id,
        P.ab_id,
        if(P.pitch_type="KN",1,0) as CU
    FROM pitches as P, atbats as A, player_names as PL
    WHERE P.ab_id=A.ab_id and PL.id=A.pitcher_id) as T
GROUP BY years,T.id,T.g_id
);
ALTER TABLE t_KN
ADD primary key(g_id,id);

create table t_SC(
SELECT years,
       T.id,
       T.first_name,
       T.last_name,
       T.g_id,
       sum(CU) as SC
FROM    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years,
        PL.id,
        PL.first_name,
        PL.last_name,
        A.g_id,
        P.ab_id,
        if(P.pitch_type="SC",1,0) as CU
    FROM pitches as P, atbats as A, player_names as PL
    WHERE P.ab_id=A.ab_id and PL.id=A.pitcher_id) as T
GROUP BY years,T.id,T.g_id
);
ALTER TABLE t_SC
ADD primary key(g_id,id);

create table t_SI(
SELECT years,
       T.id,
       T.first_name,
       T.last_name,
       T.g_id,
       sum(CU) as SI
FROM    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years,
        PL.id,
        PL.first_name,
        PL.last_name,
        A.g_id,
        P.ab_id,
        if(P.pitch_type="SI",1,0) as CU
    FROM pitches as P, atbats as A, player_names as PL
    WHERE P.ab_id=A.ab_id and PL.id=A.pitcher_id) as T
GROUP BY years,T.id,T.g_id
);
ALTER TABLE t_SI
ADD primary key(g_id,id);

create table t_SL(
SELECT years,
       T.id,
       T.first_name,
       T.last_name,
       T.g_id,
       sum(CU) as SL
FROM    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years,
        PL.id,
        PL.first_name,
        PL.last_name,
        A.g_id,
        P.ab_id,
        if(P.pitch_type="SL",1,0) as CU
    FROM pitches as P, atbats as A, player_names as PL
    WHERE P.ab_id=A.ab_id and PL.id=A.pitcher_id) as T
GROUP BY years,T.id,T.g_id
);
ALTER TABLE t_SL
ADD primary key(g_id,id);

create table t_UN(
SELECT years,
       T.id,
       T.first_name,
       T.last_name,
       T.g_id,
       sum(CU) as UN
FROM    (SELECT SUBSTRING(A.ab_id, 1, 4) AS years,
        PL.id,
        PL.first_name,
        PL.last_name,
        A.g_id,
        P.ab_id,
        if(P.pitch_type="UN",1,0) as CU
    FROM pitches as P, atbats as A, player_names as PL
    WHERE P.ab_id=A.ab_id and PL.id=A.pitcher_id) as T
GROUP BY years,T.id,T.g_id
);
ALTER TABLE t_UN
ADD primary key(g_id,id);
/*
drop table if exists pitcher_type_per_game;
create table pitcher_type_per_game(
select t_FF.years,
       t_FF.id,
       t_FF.first_name,
       t_FF.last_name,
       t_FF.g_id,
       t_CH.CH,
       t_EP.EP,
       t_FC.FC,
       t_FF.FF,
       t_PO.PO,
       t_FS.FS,
       t_FT.FT,
       t_IN.IN,
       t_KC.KC,
       t_KN.KN,
       t_SC.SC,
       t_SI.SI,
       t_SL.SL,
       t_UN.UN
from t_FF,t_CH,t_CU,t_EP,t_FC,t_PO,t_FS,t_FT,t_IN,t_KC,t_KN,t_SC,t_SI,t_SL,t_UN
where  t_FF.g_id=t_CH.g_id 
   and t_CH.g_id=t_CU.g_id
   and t_CU.g_id=t_EP.g_id
   and t_EP.g_id=t_FC.g_id
   and t_FC.g_id=t_PO.g_id
   and t_PO.g_id=t_FS.g_id
   and t_FS.g_id=t_FT.g_id
   and t_FT.g_id=t_IN.g_id
   and t_IN.g_id=t_KC.g_id
   and t_KC.g_id=t_SC.g_id
   and t_SC.g_id=t_SI.g_id
   and t_SI.g_id=t_SL.g_id
   and t_SL.g_id=t_UN.g_id
   and t_FF.id=t_CH.id 
   and t_CH.id=t_CU.id
   and t_CU.id=t_EP.id
   and t_EP.id=t_FC.id
   and t_FC.id=t_PO.id
   and t_PO.id=t_FS.id
   and t_FS.id=t_FT.id
   and t_FT.id=t_IN.id
   and t_IN.id=t_KC.id
   and t_KC.id=t_SC.id
   and t_SC.id=t_SI.id
   and t_SI.id=t_SL.id
   and t_SL.id=t_UN.id
GROUP BY t_FF.years,t_FF.id,t_FF.g_id
);
*/

drop table if exists temp1;
create table temp1(
select t_FF.years,
       t_FF.id,
       t_FF.first_name,
       t_FF.last_name,
       t_FF.g_id,
       t_FF.FF,
       t_CH.CH
       
from t_FF,t_CH
where  t_FF.g_id=t_CH.g_id 
   
   and t_FF.id=t_CH.id 
   
GROUP BY t_FF.years,t_FF.id,t_FF.g_id
);
ALTER table temp1
add primary key(g_id,id);

drop table if exists temp2;
create table temp2(
select t_EP.years,
       t_EP.id,
       t_EP.first_name,
       t_EP.last_name,
       t_EP.g_id,
       t_EP.EP,
       t_FC.FC
from t_EP,t_FC
where  t_EP.g_id=t_FC.g_id 
   and t_EP.id=t_FC.id 
group by t_EP.years,t_EP.id,t_EP.g_id
);
ALTER table temp2
add primary key(g_id,id);

drop table if exists temp3;
create table temp3(
select t_CU.*,
       t_PO.PO
from t_CU,t_PO
where  t_CU.g_id=t_PO.g_id 
   and t_CU.id=t_PO.id 
group by t_CU.years,t_CU.id,t_CU.g_id
);
ALTER table temp3
add primary key(g_id,id);

drop table if exists temp4;
create table temp4(
select t_FS.*,
       t_FT.FT
       
from t_FS,t_FT
where  t_FS.g_id=t_FT.g_id 
   and t_FS.id=t_FT.id 
   
group by t_FS.years,t_FS.id,t_FS.g_id
);
ALTER table temp4
add primary key(g_id,id);
drop table if exists temp5;
create table temp5(
select t_IN.*,
       t_KC.KC
       
from t_IN,t_KC
where  t_IN.g_id=t_KC.g_id 
   and t_IN.id=t_KC.id 
   
group by t_IN.years,t_KC.id,t_KC.g_id
);
ALTER table temp5
add primary key(g_id,id);
drop table if exists temp6;
create table temp6(
select t_KN.*,
       t_SC.SC
       
from t_KN,t_SC
where  t_KN.g_id=t_SC.g_id 
   and t_KN.id=t_SC.id 
   
group by t_KN.years,t_KN.id,t_KN.g_id
);
ALTER table temp6 add primary key(g_id,id);
drop table if exists temp7;
create table temp7(
select t_SI.*,
       t_SL.SL
       
from t_SI,t_SL
where  t_SI.g_id=t_SL.g_id 
   and t_SI.id=t_SL.id 
   
group by t_SI.years,t_SI.id,t_SI.g_id
);
ALTER table temp7 add primary key(g_id,id);

drop table if exists temp8;
create table temp8(
select temp1.*,
       temp2.EP,
       temp2.FC
       
from temp1,temp2
where  temp1.g_id=temp2.g_id 
   and temp1.id=temp2.id 
   
group by temp1.years,temp1.id,temp1.g_id
);
ALTER table temp8 add primary key(g_id,id);

drop table if exists temp9;
create table temp9(
select temp3.*,
       temp4.FS,
       temp4.FT
       
from temp3,temp4
where  temp3.g_id=temp4.g_id 
   and temp3.id=temp4.id 
   
group by temp3.years,temp3.id,temp3.g_id
);
ALTER table temp9 add primary key(g_id,id);

drop table if exists temp10;
create table temp10(
select temp5.*,
       temp6.KN,
       temp6.SC
       
from temp5,temp6
where  temp5.g_id=temp6.g_id 
   and temp5.id=temp6.id 
   
group by temp5.years,temp5.id,temp5.g_id
);
ALTER table temp10 add primary key(g_id,id);

drop table if exists temp11;
create table temp11(
select temp7.*,
       t_UN.UN
       
from temp7,t_UN
where  temp7.g_id=t_UN.g_id 
   and temp7.id=t_UN.id 
   
group by temp7.years,temp7.id,temp7.g_id
);
ALTER table temp11 add primary key(g_id,id);

drop table if exists temp12;
create table temp12(
select temp8.*,
       temp9.CU,
       temp9.PO,
       temp9.FS,
       temp9.FT
       
from temp8,temp9
where  temp8.g_id=temp9.g_id 
   and temp8.id=temp9.id 
   
group by temp8.years,temp8.id,temp8.g_id
);
ALTER table temp12 add primary key(g_id,id);

drop table if exists temp13;
create table temp13(
select temp10.*,
       temp11.SI,
       temp11.SL,
       temp11.UN
       
from temp10,temp11
where  temp10.g_id=temp11.g_id 
   and temp10.id=temp11.id 
   
group by temp11.years,temp11.id,temp11.g_id
);
ALTER table temp13 add primary key(g_id,id);

drop table if exists pitch_type_per_game;
create table pitch_type_per_game(
select temp12.*,
       temp13.IN,
       temp13.KC,
       temp13.KN,
       temp13.SC,
       temp13.SI,
       temp13.SL,
       temp13.UN
       
from temp12,temp13
where  temp12.g_id=temp13.g_id 
   and temp12.id=temp13.id 
   
group by temp12.years,temp12.id,temp12.g_id
);
ALTER table pitch_type_per_game add primary key(g_id,id);

drop table if exists t_FF;
drop table if exists t_CH;
drop table if exists t_CU;
drop table if exists t_EP;
drop table if exists t_FC;
drop table if exists t_PO;
drop table if exists t_FS;
drop table if exists t_FT;
drop table if exists t_IN;
drop table if exists t_KC;
drop table if exists t_SC;
drop table if exists t_SI;
drop table if exists t_SL;
drop table if exists temp1;
drop table if exists temp2;
drop table if exists temp3;
drop table if exists temp4;
drop table if exists temp5;
drop table if exists temp6;
drop table if exists temp7;
drop table if exists temp8;
drop table if exists temp9;
drop table if exists temp10;
drop table if exists temp11;
drop table if exists temp12;
drop table if exists temp13;
