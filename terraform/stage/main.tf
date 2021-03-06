terraform {
  # Версия terraform
  required_version = "~> 0.12.19"
}
provider "google" {
  # Версия провайдера
  version = "~> 2.15"
  # ID проекта
  project = var.project
  region  = var.region
}
module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  private_key_path = var.private_key_path
  zone            = var.zone
  app_disk_image  = var.app_disk_image
  reddit_internal_ip = module.db.db_internal_ip
  provision_enabled = false
}
module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  private_key_path = var.private_key_path
  zone            = var.zone
  db_disk_image   = var.db_disk_image
  provision_enabled = false
}
module "vpc" {
  source = "../modules/vpc"
}
