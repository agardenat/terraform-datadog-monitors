data "template_file" "filter" {
  template = "$${filter}"

  vars {
    filter = "${var.filter_tags_use_defaults == "true" ?
             format("dd_monitoring:enabled,dd_azure_apimanagement:enabled,env:%s", var.environment) :
             "${var.filter_tags_custom}"}"
  }
}

resource "datadog_monitor" "apimgt_status" {
  name    = "[${var.environment}] API Management is down"
  message = "${var.message}"

  query = <<EOF
      avg(last_5m):avg:azure.apimanagement_service.status{${data.template_file.filter.rendered}} by {resource_group,region,name} < 1
      EOF

  type = "metric alert"

  thresholds {
    critical = 1
  }

  silenced = "${var.status_silenced}"

  notify_no_data      = true
  evaluation_delay    = "${var.delay}"
  renotify_interval   = 0
  notify_audit        = false
  timeout_h           = 0
  include_tags        = true
  locked              = false
  require_full_window = false
  new_host_delay      = "${var.delay}"
  no_data_timeframe   = 20

  tags = ["env:${var.environment}", "resource:apimanagement", "team:azure", "provider:azure"]
}

resource "datadog_monitor" "apimgt_failed_requests" {
  name    = "[${var.environment}] API Management too many failed requests {{comparator}} {{#is_alert}}{{threshold}}%{{/is_alert}}{{#is_warning}}{{warn_threshold}}%{{/is_warning}} ({{value}}%)"
  message = "${var.message}"

  query = <<EOF
    sum(last_5m): (
      avg:azure.apimanagement_service.failed_requests{${data.template_file.filter.rendered}} by {resource_group,region,name}.as_count() /
      avg:azure.apimanagement_service.total_requests{${data.template_file.filter.rendered}} by {resource_group,region,name}.as_count() * 100
    ) > ${var.failed_requests_threshold_critical}
    EOF

  thresholds {
    critical = "${var.failed_requests_threshold_critical}"
    warning  = "${var.failed_requests_threshold_warning}"
  }

  silenced = "${var.failed_requests_silenced}"

  type                = "metric alert"
  notify_no_data      = false
  notify_audit        = false
  timeout_h           = 1
  include_tags        = true
  locked              = false
  require_full_window = false
  new_host_delay      = "${var.delay}"
  evaluation_delay    = "${var.delay}"
  renotify_interval   = 0
  no_data_timeframe   = 20

  tags = ["env:${var.environment}", "resource:apimanagement", "team:azure", "provider:azure"]
}

resource "datadog_monitor" "apimgt_other_requests" {
  name    = "[${var.environment}] API Management too many other requests {{comparator}} {{#is_alert}}{{threshold}}%{{/is_alert}}{{#is_warning}}{{warn_threshold}}%{{/is_warning}} ({{value}}%)"
  message = "${var.message}"

  query = <<EOF
    sum(last_5m): (
      avg:azure.apimanagement_service.other_requests{${data.template_file.filter.rendered}} by {resource_group,region,name}.as_count() /
      avg:azure.apimanagement_service.total_requests{${data.template_file.filter.rendered}} by {resource_group,region,name}.as_count() * 100
    ) > ${var.other_requests_threshold_critical}
    EOF

  thresholds {
    critical = "${var.other_requests_threshold_critical}"
    warning  = "${var.other_requests_threshold_warning}"
  }

  silenced = "${var.other_requests_silenced}"

  type                = "metric alert"
  notify_no_data      = false
  notify_audit        = false
  timeout_h           = 1
  include_tags        = true
  locked              = false
  require_full_window = false
  new_host_delay      = "${var.delay}"
  evaluation_delay    = "${var.delay}"
  renotify_interval   = 0
  no_data_timeframe   = 20

  tags = ["env:${var.environment}", "resource:apimanagement", "team:azure", "provider:azure"]
}

resource "datadog_monitor" "apimgt_unauthorized_requests" {
  name    = "[${var.environment}] API Management too many unauthorized requests {{comparator}} {{#is_alert}}{{threshold}}%{{/is_alert}}{{#is_warning}}{{warn_threshold}}%{{/is_warning}} ({{value}}%)"
  message = "${var.message}"

  query = <<EOF
    sum(last_5m): (
      avg:azure.apimanagement_service.unauthorized_requests{${data.template_file.filter.rendered}} by {resource_group,region,name}.as_count() /
      avg:azure.apimanagement_service.total_requests{${data.template_file.filter.rendered}} by {resource_group,region,name}.as_count() * 100
    ) > ${var.unauthorized_requests_threshold_critical}
    EOF

  thresholds {
    critical = "${var.unauthorized_requests_threshold_critical}"
    warning  = "${var.unauthorized_requests_threshold_warning}"
  }

  silenced = "${var.unauthorized_requests_silenced}"

  type                = "metric alert"
  notify_no_data      = false
  notify_audit        = false
  timeout_h           = 1
  include_tags        = true
  locked              = false
  require_full_window = false
  new_host_delay      = "${var.delay}"
  evaluation_delay    = "${var.delay}"
  renotify_interval   = 0
  no_data_timeframe   = 20

  tags = ["env:${var.environment}", "resource:apimanagement", "team:azure", "provider:azure"]
}

resource "datadog_monitor" "apimgt_successful_requests" {
  name    = "[${var.environment}] API Management successful requests rate too low {{comparator}} {{#is_alert}}{{threshold}}%{{/is_alert}}{{#is_warning}}{{warn_threshold}}%{{/is_warning}} ({{value}}%)"
  message = "${var.message}"

  query = <<EOF
    sum(last_5m): (
      avg:azure.apimanagement_service.successful_requests{${data.template_file.filter.rendered}} by {resource_group,region,name}.as_count() /
      avg:azure.apimanagement_service.total_requests{${data.template_file.filter.rendered}} by {resource_group,region,name}.as_count() * 100
    ) < ${var.successful_requests_threshold_critical}
    EOF

  thresholds {
    critical = "${var.successful_requests_threshold_critical}"
    warning  = "${var.successful_requests_threshold_warning}"
  }

  silenced = "${var.successful_requests_silenced}"

  type                = "metric alert"
  notify_no_data      = false
  notify_audit        = false
  timeout_h           = 1
  include_tags        = true
  locked              = false
  require_full_window = false
  new_host_delay      = "${var.delay}"
  evaluation_delay    = "${var.delay}"
  renotify_interval   = 0
  no_data_timeframe   = 20

  tags = ["env:${var.environment}", "resource:apimanagement", "team:azure", "provider:azure"]
}