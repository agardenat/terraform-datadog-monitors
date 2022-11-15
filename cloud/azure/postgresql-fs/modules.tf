module "filter-tags" {
  source = "../../../common/filter-tags"

  environment              = var.environment
  resource                 = "azure_postgresql-fs"
  filter_tags_use_defaults = var.filter_tags_use_defaults
  filter_tags_custom       = var.filter_tags_custom
}

