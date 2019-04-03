provider "google" {
  # Версия провайдера
  version = "2.0.0"

  # ID проекта
  project = "${var.project}"
  region  = "${var.region}"
}

module "db" {
  source           = "../modules/db"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone             = "${var.zone}"
  db_disk_image    = "${var.db_disk_image}"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
  mongodb_ip      = "${module.db.mongodb_external_ip}:27017"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["5.8.182.221/32"]
}
