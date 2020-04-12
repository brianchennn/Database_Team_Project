-- 卻診年齡區間與人數對應
select if((age mod 10) < 0, 'null', concat(convert((age mod 10)*10, CHAR), '-', convert(((age mod 10)+1)*10-1, CHAR))) as age_range,
 count(*) as cnt
from patient
group by age mod 10;

-- 性別與人數對應
select sex, count(*) as cnt
from patient
group by sex;

-- 第一起沒有中國旅遊史的病患資訊
select * from patient
where country != 'China'
and date_confirmation != '0000-00-00'
order by date_confirmation asc
limit 1;

-- 2/26~3/3之間，各地區確診人數比例，由大到小排序
select reg_a.province, reg_a.country, reg_b.confirmed_num as earlier_data,
reg_a.confirmed_num as later_data, 
(reg_a.confirmed_num-reg_b.confirmed_num)/reg_b.confirmed_num as increase_ratio
from region_acc as reg_a, region_acc as reg_b
where reg_a.province = reg_b.province
and reg_a.country = reg_b.country
and reg_a.data_date = '2020-03-03'
and reg_b.data_date = '2020-02-26'
order by increase_ratio desc;

-- 資料中，各地區開始有確診案例的日期
select province, country, min(data_date) as start_date
from region_acc
group by province, country
order by start_date asc;

-- 在3/6時，確診人數比台灣多的地區有幾個，同時顯示有確診案例的地區總共有幾個
select inner_res.cnt as cnt, count(ra.province) as total_cnt
from region_acc as ra,
(
    select count(ra.province) as cnt
    from region_acc as ra,
    (
        select confirmed_num
        from region_acc
        where data_date = '2020-03-06'
        and province = 'Taiwan'
        and country = 'Taiwan'
    ) as new_taiwan_data
    where ra.data_date = '2020-03-06'
    and ra.confirmed_num > new_taiwan_data.confirmed_num
) as inner_res
where ra.data_date = '2020-03-06';

-- 列出各地區在2/28增加的確診案例個數，數量由大到小排序
select later_data.province, later_data.country,
 earlier_data.confirmed_num as earlier_patient_num,
 later_data.confirmed_num as later_patient_num, 
 (later_data.confirmed_num-earlier_data.confirmed_num) as new_patient_num
from region_acc as later_data, region_acc as earlier_data
where later_data.data_date = '2020-2-28'
and earlier_data.data_date = '2020-2-27'
and later_data.province = earlier_data.province
and later_data.country = earlier_data.country
order by new_patient_num desc;