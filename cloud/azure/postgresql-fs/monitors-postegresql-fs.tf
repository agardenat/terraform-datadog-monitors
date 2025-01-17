resource "datadog_monitor" "postgresql-fs_cpu_usage" {
  count   = var.cpu_usage_enabled == "true" ? 1 : 0
  name    = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] Postgresql FlexibleServer CPU usage {{#is_alert}}{{{comparator}}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{{comparator}}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"
  message = coalesce(var.cpu_usage_message, var.message)
  type    = "query alert"

  query = <<EOQ
    ${var.cpu_usage_time_aggregator}(${var.cpu_usage_timeframe}): (
      avg:azure.dbforpostgresql_flexibleservers.cpu_percent${module.filter-tags.query_alert} by {resource_group,region,name}
    ) > ${var.cpu_usage_threshold_critical}
EOQ

  monitor_thresholds {
    critical = var.cpu_usage_threshold_critical
    warning  = var.cpu_usage_threshold_warning
  }

  evaluation_delay    = var.evaluation_delay
  new_host_delay      = var.new_host_delay
  new_group_delay     = var.new_group_delay
  notify_no_data      = false
  renotify_interval   = 0
  notify_audit        = false
  timeout_h           = var.timeout_h
  include_tags        = true
  require_full_window = false

  tags = concat(["env:${var.environment}", "type:cloud", "provider:azure", "resource:postgresql-fs", "team:claranet", "created-by:terraform"], var.cpu_usage_extra_tags)
}

resource "datadog_monitor" "postgresql-fs_no_connection" {
  count   = var.no_connection_enabled == "true" ? 1 : 0
  name    = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] Postgresql FlexibleServer has no connection"
  message = coalesce(var.no_connection_message, var.message)
  type    = "query alert"

  query = <<EOQ
    ${var.no_connection_time_aggregator}(${var.no_connection_timeframe}): (
      avg:azure.dbforpostgresql_flexibleservers.active_connections${module.filter-tags.query_alert} by {resource_group,region,name}
    ) < 1
EOQ

  evaluation_delay    = var.evaluation_delay
  new_host_delay      = var.new_host_delay
  new_group_delay     = var.new_group_delay
  notify_no_data      = var.notify_no_data
  no_data_timeframe   = var.postgresql_no_connection_no_data_timeframe
  renotify_interval   = 0
  notify_audit        = false
  timeout_h           = var.timeout_h
  include_tags        = true
  require_full_window = false

  tags = concat(["env:${var.environment}", "type:cloud", "provider:azure", "resource:postgresql", "team:claranet", "created-by:terraform"], var.no_connection_extra_tags)
}

resource "datadog_monitor" "postgresql-fs_free_storage" {
  count   = var.free_storage_enabled == "true" ? 1 : 0
  name    = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] Postgresql FlexibleServer storage {{#is_alert}}{{{comparator}}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{{comparator}}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"
  message = coalesce(var.free_storage_message, var.message)
  type    = "query alert"

  query = <<EOQ
    ${var.free_storage_time_aggregator}(${var.free_storage_timeframe}): (
      100 - avg:azure.dbforpostgresql_flexibleservers.storage_percent${module.filter-tags.query_alert} by {resource_group,region,name}
    ) < ${var.free_storage_threshold_critical}
EOQ

  monitor_thresholds {
    critical = var.free_storage_threshold_critical
    warning  = var.free_storage_threshold_warning
  }

  evaluation_delay    = var.evaluation_delay
  new_host_delay      = var.new_host_delay
  new_group_delay     = var.new_group_delay
  notify_no_data      = false
  renotify_interval   = 0
  notify_audit        = false
  timeout_h           = var.timeout_h
  include_tags        = true
  require_full_window = false

  tags = concat(["env:${var.environment}", "type:cloud", "provider:azure", "resource:postgresql", "team:claranet", "created-by:terraform"], var.free_storage_extra_tags)
}

resource "datadog_monitor" "postgresql-fs_memory_usage" {
  count   = var.memory_usage_enabled == "true" ? 1 : 0
  name    = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] Postgresql FlexibleServer memory usage {{#is_alert}}{{{comparator}}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{{comparator}}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"
  message = coalesce(var.memory_usage_message, var.message)
  type    = "query alert"

  query = <<EOQ
    ${var.memory_usage_time_aggregator}(${var.memory_usage_timeframe}): (
      avg:azure.dbforpostgresql_flexibleservers.memory_percent${module.filter-tags.query_alert} by {resource_group,region,name}
    ) > ${var.memory_usage_threshold_critical}
EOQ

  monitor_thresholds {
    critical = var.memory_usage_threshold_critical
    warning  = var.memory_usage_threshold_warning
  }

  evaluation_delay    = var.evaluation_delay
  new_host_delay      = var.new_host_delay
  new_group_delay     = var.new_group_delay
  notify_no_data      = false
  renotify_interval   = 0
  notify_audit        = false
  timeout_h           = var.timeout_h
  include_tags        = true
  require_full_window = false

  tags = concat(["env:${var.environment}", "type:cloud", "provider:azure", "resource:postgresql-fs", "team:claranet", "created-by:terraform"], var.memory_usage_extra_tags)
}

