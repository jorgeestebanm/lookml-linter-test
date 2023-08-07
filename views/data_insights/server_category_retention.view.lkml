view: server_category_retention {
  derived_table: {
    sql:
    with mo1 as (
        select u.guild_id,u.user_id,s.category
        from derived.user_guild_participation_month u
        join `discord-data-analytics-prd.ml_derived.server_category_predictions` s on s.guild_id = u.guild_id
        where month_pt = timestamp(date_sub(date({% parameter month_pt_param %}),INTERVAL 5 MONTH))
    ),
    mo2 as (
        select u.guild_id,user_id,s.category
        from derived.user_guild_participation_month u
        join `discord-data-analytics-prd.ml_derived.server_category_predictions` s on s.guild_id = u.guild_id
        where month_pt = timestamp(date_sub(date({% parameter month_pt_param %}),INTERVAL 4 MONTH))
    ),
    mo3 as (
        select u.guild_id,user_id,s.category
        from derived.user_guild_participation_month u
        join `discord-data-analytics-prd.ml_derived.server_category_predictions` s on s.guild_id = u.guild_id
        where month_pt = timestamp(date_sub(date({% parameter month_pt_param %}),INTERVAL 3 MONTH))
    ),
    mo4 as (
        select u.guild_id,user_id,s.category
        from derived.user_guild_participation_month u
        join `discord-data-analytics-prd.ml_derived.server_category_predictions` s on s.guild_id = u.guild_id
        where month_pt = timestamp(date_sub(date({% parameter month_pt_param %}),INTERVAL 2 MONTH))
    ),
    mo5 as (
        select u.guild_id,user_id,s.category
        from derived.user_guild_participation_month u
        join `discord-data-analytics-prd.ml_derived.server_category_predictions` s on s.guild_id = u.guild_id
        where month_pt = timestamp(date_sub(date({% parameter month_pt_param %}),INTERVAL 1 MONTH))
    ),
    mo6 as (
        select u.guild_id,user_id,s.category
        from derived.user_guild_participation_month u
        join `discord-data-analytics-prd.ml_derived.server_category_predictions` s on s.guild_id = u.guild_id
        where month_pt = timestamp(date({% parameter month_pt_param %}))
    ),
    core_dim_guilds_latest as (
        select * from dem.dim_guild where day_pt = (select max(day_pt) from dem.dim_guild) --Latest From Dim Guilds
    )
    select mo1.guild_id,mo1.category,dg.guild_members guild_size,
        count(distinct mo1.user_id) m1_users,
        count(distinct mo2.user_id) m2_users,
        count(distinct mo3.user_id) m3_users,
        count(distinct mo4.user_id) m4_users,
        count(distinct mo5.user_id) m5_users,
        count(distinct mo6.user_id) m6_users,
    from mo1
    left join mo2 on mo1.user_id = mo2.user_id and mo1.guild_id = mo2.guild_id
    left join mo3 on mo1.user_id = mo3.user_id and mo1.guild_id = mo3.guild_id
    left join mo4 on mo1.user_id = mo4.user_id and mo1.guild_id = mo4.guild_id
    left join mo5 on mo1.user_id = mo5.user_id and mo1.guild_id = mo5.guild_id
    left join mo6 on mo1.user_id = mo6.user_id and mo1.guild_id = mo6.guild_id
    left join core_dim_guilds_latest dg on dg.guild_id = mo1.guild_id
    group by 1,2,3
      ;;
  }
  parameter: month_pt_param {
    label: "Retention Month Start Date"
    type: date
  }

  dimension: guild_id {
    type: string
    sql: ${TABLE}.guild_id ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: guild_size {
    type: number
    sql: ${TABLE}.guild_size ;;
  }

  dimension: guild_size_bucket {
    type: string
    sql: case
      when ${TABLE}.guild_size <= 30 then '1.Guild Size [0,30]'
      when ${TABLE}.guild_size <= 100 then '2.Guild Size (30,100]'
      when ${TABLE}.guild_size <= 200 then '3.Guild Size (100,200]'
      when ${TABLE}.guild_size <= 1000 then '4.Guild Size (200,1000]'
      when ${TABLE}.guild_size <= 10000 then '5.Guild Size (1000,10000]'
      when ${TABLE}.guild_size > 10000 then '6.Guild Size 10000+'
      when ${TABLE}.guild_size is null then '0.Guild Size N/A'
      end
      ;;
  }


  measure: m1_users {
    type: sum
    sql: ${TABLE}.m1_users ;;
  }

  measure: m2_users {
    type: sum
    sql: ${TABLE}.m2_users ;;
  }

  measure: m3_users {
    type: sum
    sql: ${TABLE}.m3_users ;;
  }

  measure: m4_users {
    type: sum
    sql: ${TABLE}.m4_users ;;
  }

  measure: m5_users {
    type: sum
    sql: ${TABLE}.m5_users ;;
  }

  measure: m6_users {
    type: sum
    sql: ${TABLE}.m5_users ;;
  }


  measure: m1_retention {
    type: number
    value_format_name: percent_0
    sql: sum(${TABLE}.m1_users)/sum(${TABLE}.m1_users) ;;
  }

  measure: m2_retention {
    type: number
    value_format_name: percent_0
    sql: sum(${TABLE}.m2_users)/sum(${TABLE}.m1_users) ;;
  }

  measure: m3_retention {
    type: number
    value_format_name: percent_0
    sql: sum(${TABLE}.m3_users)/sum(${TABLE}.m1_users) ;;
  }

  measure: m4_retention {
    type: number
    value_format_name: percent_0
    sql: sum(${TABLE}.m4_users)/sum(${TABLE}.m1_users) ;;
  }

  measure: m5_retention {
    type: number
    value_format_name: percent_0
    sql: sum(${TABLE}.m5_users)/sum(${TABLE}.m1_users) ;;
  }

  measure: m6_retention {
    type: number
    value_format_name: percent_0
    sql: sum(${TABLE}.m6_users)/sum(${TABLE}.m1_users) ;;
  }

}