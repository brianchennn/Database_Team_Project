-- 列出離2020-3-12前14天內，曾待危險地區的人，以及其對應的等級
select inb.id_card, inb.country, inb.province, inb.inbord_date, ta.security_level
from inbord as inb, travel_alert as ta
where datediff('2020-3-12', inb.inbord_date) > 0
and datediff('2020-3-12', inb.inbord_date) <= 14
and inb.country = ta.area
order by inb.inbord_date asc;

-- 列出目前三級分別有幾個國家
select security_level, count(security_level) as cnt
from travel_alert
group by security_level;