-- 將藥局地址從高雄縣更新成高雄市
UPDATE `institute`
SET inst_addr = REPLACE(inst_addr, '高雄縣', '高雄市')
WHERE substring(inst_addr, 1, 3) LIKE '高雄縣'

-- 列出2/6(實名制第一天)晚上10點時口罩庫存縣市，根據口罩庫存排序，包含縣市、藥局間數、口罩數
SELECT substring(i.inst_addr, 1, 3) as city, COUNT(i.inst_id) as inst_num, SUM(m.adult_mask_num)+SUM(m.child_mask_num) as total_mask_num
FROM mask as m, institute as i
WHERE m.inst_id = i.inst_id
AND m.data_time LIKE '2020-02-06 22:00:%'
GROUP BY substring(i.inst_addr, 1, 3)
ORDER BY total_mask_num DESC
LIMIT 10;

-- 列新竹市東區在2/28中午12點時還有成人口罩的藥局名稱、電話、地址、口罩數目，並依照成人口罩數目排序
SELECT i.inst_name, i.inst_phone, i.inst_addr, m.adult_mask_num, m.child_mask_num
FROM mask as m, institute as i
WHERE m.inst_id = i.inst_id
AND m.data_time LIKE '2020-02-28 12:00:%'
AND i.inst_addr LIKE '新竹市東區%'
AND m.adult_mask_num > 0
ORDER BY m.adult_mask_num DESC

-- 列出從2/6晚上十點與2/29晚上十點庫存成長率的縣市、口罩剩餘數、成長比率，依照比率由高至低排序
SELECT lastm.city, last_total, first_total, last_total / first_total as growth_rate
FROM 
  (SELECT substring(institute.inst_addr, 1, 3) as city, (SUM(mask.adult_mask_num) + SUM(mask.child_mask_num)) as last_total
   FROM mask, institute
   WHERE data_time LIKE '2020-02-29 22:00:%'
   AND mask.inst_id = institute.inst_id
   GROUP BY city) as lastm, 
  (SELECT substring(institute.inst_addr, 1, 3) as city, (SUM(mask.adult_mask_num) + SUM(mask.child_mask_num)) as first_total
   FROM mask, institute
   WHERE data_time LIKE '2020-02-06 22:00:%'
   AND mask.inst_id = institute.inst_id
   GROUP BY city) as firstm
WHERE lastm.city = firstm.city
GROUP BY lastm.city
ORDER BY growth_rate DESC

-- 列出安禾藥局(清大對面)購買口罩最多天前十名
SELECT DATE(r.get_time) as date, COUNT(*) as customers
FROM record as r, institute as i
WHERE r.inst_id = i.inst_id
AND i.inst_name = '安禾藥局'
GROUP BY DATE(r.get_time)
ORDER BY customers DESC
LIMIT 10

-- 列出領過口罩次數各有多少人
SELECT record_sum.cnt, SUM(record_sum.cnt) as resident_count
FROM 
    (SELECT COUNT(*) as cnt
    FROM record as r
    GROUP BY r.id_card) as record_sum
GROUP BY record_sum.cnt