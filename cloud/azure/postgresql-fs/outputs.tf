output "postgresql-fs_cpu_usage_id" {
  description = "id for monitor postgresql-fs_cpu_usage"
  value       = datadog_monitor.postgresql-fs_cpu_usage.*.id
}

output "postgresql-fs_free_storage_id" {
  description = "id for monitor postgresql-fs_free_storage"
  value       = datadog_monitor.postgresql-fs_free_storage.*.id
}

output "postgresql-fs_memory_usage_id" {
  description = "id for monitor postgresql-fs_memory_usage"
  value       = datadog_monitor.postgresql-fs_memory_usage.*.id
}

output "postgresql-fs_no_connection_id" {
  description = "id for monitor postgresql-fs_no_connection"
  value       = datadog_monitor.postgresql-fs_no_connection.*.id
}

