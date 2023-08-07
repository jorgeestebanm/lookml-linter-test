# Define the database connection to be used for this model.
connection: "cost_to_serve"

# include all the views
include: "/views/gcp_billing/*.view"
include: "/views/gcp_billing_detailed/*.view"
include: "/views/cts_alpha/*.view"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: cost_to_serve_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

datagroup: cost_to_serve_monitoring_daily_datagroup {
  max_cache_age: "24 hours"
  label: "CTS Monitoring Daily Export"
  description: "Detailed monitoring data for CTS metrics, updated daily."
}

persist_with: cost_to_serve_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Cost to Serve"

# owner: Theo/Saif

explore: dashboard_ready_cost_breakdown  {
  group_label: "Cost-to-Serve"
  label: "[CTS] Utilization Breakdown"
}

explore: gke_node_view  {
  group_label: "Cost-to-Serve"
  label: "[CTS] GKE Nodes"
  join: gke_container_view {
    type: left_outer
    relationship: one_to_many
    sql_on: ${gke_node_view.start_time_raw} = ${gke_container_view.start_time_raw} AND ${gke_container_view.metadata_system_node_name} = ${gke_node_view.resource_node_name}; ;;
  }
}

# owner: Saif/Etan
explore: gcp_billing {
  group_label: "Cost-to-Serve"
  label: "[CTS] GCP Billing"
}

explore: gcp_billing_detailed {
  group_label: "Cost-to-Serve"
  label: "[CTS] GCP Billing Detailed"
}

# owner: Etan/Saif
explore: gcp_billing_cud {
  group_label: "Cost-to-Serve"
  label: "[CTS] GCP CUD"
}

explore: gcp_spend {
  group_label: "Cost-to-Serve"
  label: "[CTS] GCP Spend"
}

explore: gcp_utilization {
  group_label: "Cost-to-Serve"
  label: "[CTS] GCP Utilization"
}

explore: gcp_billing_export_v1_00024_c_3_cad01_681634 {
  join: gcp_billing_export_v1_00024_c_3_cad01_681634__tags {
    view_label: "Gcp Billing Export V1 00024 C 3 Cad01 681634: Tags"
    sql: LEFT JOIN UNNEST(${gcp_billing_export_v1_00024_c_3_cad01_681634.tags}) as gcp_billing_export_v1_00024_c_3_cad01_681634__tags ;;
    relationship: one_to_many
  }

  join: gcp_billing_export_v1_00024_c_3_cad01_681634__labels {
    view_label: "Gcp Billing Export V1 00024 C 3 Cad01 681634: Labels"
    sql: LEFT JOIN UNNEST(${gcp_billing_export_v1_00024_c_3_cad01_681634.labels}) as gcp_billing_export_v1_00024_c_3_cad01_681634__labels ;;
    relationship: one_to_many
  }

  join: gcp_billing_export_v1_00024_c_3_cad01_681634__credits {
    view_label: "Gcp Billing Export V1 00024 C 3 Cad01 681634: Credits"
    sql: LEFT JOIN UNNEST(${gcp_billing_export_v1_00024_c_3_cad01_681634.credits}) as gcp_billing_export_v1_00024_c_3_cad01_681634__credits ;;
    relationship: one_to_many
  }

  join: gcp_billing_export_v1_00024_c_3_cad01_681634__system_labels {
    view_label: "Gcp Billing Export V1 00024 C 3 Cad01 681634: System Labels"
    sql: LEFT JOIN UNNEST(${gcp_billing_export_v1_00024_c_3_cad01_681634.system_labels}) as gcp_billing_export_v1_00024_c_3_cad01_681634__system_labels ;;
    relationship: one_to_many
  }

  join: gcp_billing_export_v1_00024_c_3_cad01_681634__project__labels {
    view_label: "Gcp Billing Export V1 00024 C 3 Cad01 681634: Project Labels"
    sql: LEFT JOIN UNNEST(${gcp_billing_export_v1_00024_c_3_cad01_681634.project__labels}) as gcp_billing_export_v1_00024_c_3_cad01_681634__project__labels ;;
    relationship: one_to_many
  }

  join: gcp_billing_export_v1_00024_c_3_cad01_681634__project__ancestors {
    view_label: "Gcp Billing Export V1 00024 C 3 Cad01 681634: Project Ancestors"
    sql: LEFT JOIN UNNEST(${gcp_billing_export_v1_00024_c_3_cad01_681634.project__ancestors}) as gcp_billing_export_v1_00024_c_3_cad01_681634__project__ancestors ;;
    relationship: one_to_many
  }
}

explore: gcp_billing_export_v1_00_cf44_f9_eb0_e_c99_a24 {
  join: gcp_billing_export_v1_00_cf44_f9_eb0_e_c99_a24__labels {
    view_label: "Gcp Billing Export V1 00 Cf44 F9 Eb0 E C99 A24: Labels"
    sql: LEFT JOIN UNNEST(${gcp_billing_export_v1_00_cf44_f9_eb0_e_c99_a24.labels}) as gcp_billing_export_v1_00_cf44_f9_eb0_e_c99_a24__labels ;;
    relationship: one_to_many
  }

  join: gcp_billing_export_v1_00_cf44_f9_eb0_e_c99_a24__credits {
    view_label: "Gcp Billing Export V1 00 Cf44 F9 Eb0 E C99 A24: Credits"
    sql: LEFT JOIN UNNEST(${gcp_billing_export_v1_00_cf44_f9_eb0_e_c99_a24.credits}) as gcp_billing_export_v1_00_cf44_f9_eb0_e_c99_a24__credits ;;
    relationship: one_to_many
  }

  join: gcp_billing_export_v1_00_cf44_f9_eb0_e_c99_a24__system_labels {
    view_label: "Gcp Billing Export V1 00 Cf44 F9 Eb0 E C99 A24: System Labels"
    sql: LEFT JOIN UNNEST(${gcp_billing_export_v1_00_cf44_f9_eb0_e_c99_a24.system_labels}) as gcp_billing_export_v1_00_cf44_f9_eb0_e_c99_a24__system_labels ;;
    relationship: one_to_many
  }

  join: gcp_billing_export_v1_00_cf44_f9_eb0_e_c99_a24__project__labels {
    view_label: "Gcp Billing Export V1 00 Cf44 F9 Eb0 E C99 A24: Project Labels"
    sql: LEFT JOIN UNNEST(${gcp_billing_export_v1_00_cf44_f9_eb0_e_c99_a24.project__labels}) as gcp_billing_export_v1_00_cf44_f9_eb0_e_c99_a24__project__labels ;;
    relationship: one_to_many
  }
}

explore: gcp_billing_export_resource_v1_00024_c_3_cad01_681634 {
  join: gcp_billing_export_resource_v1_00024_c_3_cad01_681634__tags {
    view_label: "Gcp Billing Export Resource V1 00024 C 3 Cad01 681634: Tags"
    sql: LEFT JOIN UNNEST(${gcp_billing_export_resource_v1_00024_c_3_cad01_681634.tags}) as gcp_billing_export_resource_v1_00024_c_3_cad01_681634__tags ;;
    relationship: one_to_many
  }

  join: gcp_billing_export_resource_v1_00024_c_3_cad01_681634__labels {
    view_label: "Gcp Billing Export Resource V1 00024 C 3 Cad01 681634: Labels"
    sql: LEFT JOIN UNNEST(${gcp_billing_export_resource_v1_00024_c_3_cad01_681634.labels}) as gcp_billing_export_resource_v1_00024_c_3_cad01_681634__labels ;;
    relationship: one_to_many
  }

  join: gcp_billing_export_resource_v1_00024_c_3_cad01_681634__credits {
    view_label: "Gcp Billing Export Resource V1 00024 C 3 Cad01 681634: Credits"
    sql: LEFT JOIN UNNEST(${gcp_billing_export_resource_v1_00024_c_3_cad01_681634.credits}) as gcp_billing_export_resource_v1_00024_c_3_cad01_681634__credits ;;
    relationship: one_to_many
  }

  join: gcp_billing_export_resource_v1_00024_c_3_cad01_681634__system_labels {
    view_label: "Gcp Billing Export Resource V1 00024 C 3 Cad01 681634: System Labels"
    sql: LEFT JOIN UNNEST(${gcp_billing_export_resource_v1_00024_c_3_cad01_681634.system_labels}) as gcp_billing_export_resource_v1_00024_c_3_cad01_681634__system_labels ;;
    relationship: one_to_many
  }

  join: gcp_billing_export_resource_v1_00024_c_3_cad01_681634__project__labels {
    view_label: "Gcp Billing Export Resource V1 00024 C 3 Cad01 681634: Project Labels"
    sql: LEFT JOIN UNNEST(${gcp_billing_export_resource_v1_00024_c_3_cad01_681634.project__labels}) as gcp_billing_export_resource_v1_00024_c_3_cad01_681634__project__labels ;;
    relationship: one_to_many
  }

  join: gcp_billing_export_resource_v1_00024_c_3_cad01_681634__project__ancestors {
    view_label: "Gcp Billing Export Resource V1 00024 C 3 Cad01 681634: Project Ancestors"
    sql: LEFT JOIN UNNEST(${gcp_billing_export_resource_v1_00024_c_3_cad01_681634.project__ancestors}) as gcp_billing_export_resource_v1_00024_c_3_cad01_681634__project__ancestors ;;
    relationship: one_to_many
  }
}

explore: cloud_pricing_export {
  join: cloud_pricing_export__product_taxonomy {
    view_label: "Cloud Pricing Export: Product Taxonomy"
    sql: LEFT JOIN UNNEST(${cloud_pricing_export.product_taxonomy}) as cloud_pricing_export__product_taxonomy ;;
    relationship: one_to_many
  }

  join: cloud_pricing_export__geo_taxonomy__regions {
    view_label: "Cloud Pricing Export: Geo Taxonomy Regions"
    sql: LEFT JOIN UNNEST(${cloud_pricing_export.geo_taxonomy__regions}) as cloud_pricing_export__geo_taxonomy__regions ;;
    relationship: one_to_many
  }

  join: cloud_pricing_export__list_price__tiered_rates {
    view_label: "Cloud Pricing Export: List Price Tiered Rates"
    sql: LEFT JOIN UNNEST(${cloud_pricing_export.list_price__tiered_rates}) as cloud_pricing_export__list_price__tiered_rates ;;
    relationship: one_to_many
  }

  join: cloud_pricing_export__sku__destination_migration_mappings {
    view_label: "Cloud Pricing Export: Sku Destination Migration Mappings"
    sql: LEFT JOIN UNNEST(${cloud_pricing_export.sku__destination_migration_mappings}) as cloud_pricing_export__sku__destination_migration_mappings ;;
    relationship: one_to_many
  }

  join: cloud_pricing_export__billing_account_price__tiered_rates {
    view_label: "Cloud Pricing Export: Billing Account Price Tiered Rates"
    sql: LEFT JOIN UNNEST(${cloud_pricing_export.billing_account_price__tiered_rates}) as cloud_pricing_export__billing_account_price__tiered_rates ;;
    relationship: one_to_many
  }
}