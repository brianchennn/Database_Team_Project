-- 1. Find PID of users who traveled UK and were back Taiwan on 2020/03/16
--- Solution 1
select inbound.PID
from
(
    select * from airport where country = 'UK'
) as airport,
(
    select * from inbound where date = '2020-03-16'
) as inbound
where airport.IATA_code = inbound.IATA_code;
--- Solution 2
select inbound.PID
from airport, inbound
where airport.IATA_code = inbound.IATA_code
and airport.country = 'UK'
and inbound.date = '2020-03-16';

-- 2. Find the ID of users who traveled to UK and were back Taiwan on 2020/03/16
--- Solution 1
select user.ID
from
(
    select airport.*, inbound.PID, inbound.flight_no, inbound.date from
    (
        select * from airport where country = 'UK'
    ) as airport,
    (
        select * from inbound where date = '2020-03-16'
    ) as inbound
    where airport.IATA_code = inbound.IATA_code
) as airport, user
where user.PID = airport.PID;
--- Solution 2
select ID
from
(
    select PID
    from
    (
        select IATA_code from airport where country = 'UK'
    ) as airport,
    (
        select * from inbound where date = '2020-03-16'
    ) as inbound
    where airport.IATA_code = inbound.IATA_code
) as airport, user
where user.PID = airport.PID;

-- 3. Find the ID of users who were back from UK or Japan
--- Solution 1
select user.ID
from
(
    select TempAirport.*, inbound.PID, inbound.flight_no, inbound.date  from
    (
        select * from airport where country = 'UK' or country = 'Japan'
    ) as TempAirport, inbound
    where TempAirport.IATA_code = inbound.IATA_code
) as TempAirport, user
where TempAirport.PID = user.PID;

--- Solution 2
select user.ID
from
(
    select airport.*, inbound.PID, inbound.flight_no, inbound.date  from
    (
        select * from airport where country = 'UK'
    ) as airport, inbound
    where airport.IATA_code = inbound.IATA_code
) as airport, user
where airport.PID = user.PID
union
select user.ID
from
(
    select airport.*, inbound.PID, inbound.flight_no, inbound.date  from
    (
        select * from airport where country = 'Japan'
    ) as airport, inbound
    where airport.IATA_code = inbound.IATA_code
) as airport, user
where airport.PID = user.PID;

-- 4. Find the PID of users who were in the same plant of one confirmed case with his PID as NQ13219857 on 2020/03/06
select inbound.PID, inbound.flight_no
from inbound
where inbound.flight_no in (
    select flight_no
    from inbound
    where PID = 'NQ13219857'
    and date = '2020-3-6'
);