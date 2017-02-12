with shop_list as (
     select td.id_div
            , td.id_contr
     from warehouses.tbl_division td
     where td.higher=3307
           and td.id_contr is not null), --list of shops

contrs as (
       select ag.id_contr
       from warehouses.div_state ds
            ,shop_list ag
       where ds.id_div=ag.id_div
       and ds.id_cond=11
       and(ds.date_end is null or ds.date_end >= trunc(sysdate))
       and ds.date_start < trunc(sysdate)),       --divisions in shops

waagh as (
      select st.id_ws
             , st.fullname
      from warehouses.storage st
             ,contrs cas
      where st.id_controwner = cas.id_contr
             and st.lvl=3
             and st.leg=201)             

select ws.id_ws
       , ws.fullname       
from warehouses.tbl_operation op 
     , waagh ws     
where op.date(+)=(trunc(sysdate)-1)
      and op.id_top(+)=3      
and op.typeop(+)=20 
and substr(op.opnumber(+),1,1) != 'B' --mark of wrong number
and ws.id_ws = op.ud_wso(+) --antijoin statement
and op.id_wso is null; --antijoin statement