CREATE TABLE ASTARTES.customers
( snum number,
  sname varchar2(50),
  city varchar2(50),
  comm number
);

begin
for item in 1..255 loop
    INSERT INTO ASTARTES.customers (snum, sname, city, comm) 
   VALUES (   
    round(DBMS_RANDOM.value(1,1000)), 
    dbms_random.string('U', 4), 
    dbms_random.string('U', 5),
    round(dbms_random.value(1, 100)/100,2)
    );
end loop;
commit;
end;

update ASTARTES.customers t 
set t.SNAME= (
select case
    when substr(t.SNAME,0,1) in ('A','X','E') then 'ALEX'
    when substr(t.SNAME,0,1) in ('B','W','S') then 'BORIS'
    when substr(t.SNAME,0,1) in ('C','V','T') then 'VICTOR'
    when substr(t.SNAME,0,1) in ('G','Z','I') then 'GEORGE'
    when substr(t.SNAME,0,1) in ('L','Q','D','N') then 'LEONID'
    when substr(t.SNAME,0,1) in ('Y','U','R') then 'YURI'
    when substr(t.SNAME,0,1) in ('M','F','H') then 'MICHAEL'
    when substr(t.SNAME,0,1) in ('O','J','K') then 'OLEG'
    when substr(t.SNAME,0,1) in ('P') then 'ANDREW'
    ELSE NULL
    end from dual)
    , t.CITY= (
select case
    when substr(t.SNAME,0,1) in ('A','X','E') then 'Petersburg'
    when substr(t.SNAME,0,1) in ('B','W','S') then 'Sochi'
    when substr(t.SNAME,0,1) in ('C','V','T') then 'Novosibirsk'
    when substr(t.SNAME,0,1) in ('G','Z','I') then 'Grozny'
    when substr(t.SNAME,0,1) in ('L','Q','D','N') then 'Kaliningrad'
    when substr(t.SNAME,0,1) in ('Y','U','R') then 'Ekaterinburg'
    when substr(t.SNAME,0,1) in ('M','F','H') then 'Moscow'
    when substr(t.SNAME,0,1) in ('O','J','K') then 'Yaroslavlv'
    when substr(t.SNAME,0,1) in ('P') then 'Novgorod'
    ELSE NULL
    end from dual);
    
    commit;