# The name of this view in Looker is "Agg Guild"
view: agg_guild_2 {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `discord-data-analytics-prd.core.agg_guild`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: day_pt {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.day_pt ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Num Guilds" in Explore.

  dimension: num_guilds {
    type: number
    sql: ${TABLE}.num_guilds ;;
    description: "Number of guilds"
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_num_guilds {
    type: sum
    sql: ${num_guilds} ;;
    description: "Totals"
  }

  dimension: timescale {
    type: string
    sql: ${TABLE}.timescale ;;
  }

  dimension: xag_segment {
    type: string
    sql: ${TABLE}.xag_segment ;;
  }
}