drop table if exists batter_create_table_interval;
create table batter_create_table_interval(       
    select first_name,last_name,           
    sum(PA) as PA,sum(AB) as AB,sum(Single) as Single,sum(DDouble) as DDouble,sum(Triple)    as Triple ,      
    sum(HR) as HR,sum(K) as K,sum(BB) as BB,sum(HBP)as HBP,sum(IBB) as IBB,           
    (sum(Single)+sum(DDouble)+sum(Triple)+sum(HR))/sum(AB) as AVG,           
    (sum(Single)+sum(DDouble)+sum(Triple)+sum(HR)+sum(HBP)+sum(BB))/(sum(AB)+sum(BB)+sum(HBP)+sum(SF)) as OBP,           
    (sum(Single)+2*sum(DDouble)+3*sum(Triple)+4*sum(HR))/AB as SLG,           
    (sum(Single)+sum(DDouble)+sum(Triple)+sum(HR)+sum(HBP)+sum(BB))/(sum(AB)+sum(BB)+sum(HBP)+sum(SF))+(sum(Single)+2*sum(DDouble)+3*sum(Triple)+4*sum(HR))/sum(AB) as OPS,     
    ROUND((0.792*(sum(BB)-sum(IBB)) + 0.75*sum(HBP) + 0.9*sum(Single) + 0.92*sum(ROE) + 1.24*sum(DDouble) + 1.56*sum(Triple) + 1.95*sum(HR))/sum(PA),3) as wOBA,     
    sum(SF) as SF,     
    sum(GDP) as GDP,           
    sum(ROE) as ROE from batter_create_table_per_game2 as A        
    where Date between 20150405 and 20150415          
    group by first_name,last_name 
    );
