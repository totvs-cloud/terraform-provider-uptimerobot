provider "uptimerobot" {
  version = "~> 0.1.2"
  api_key = "u637106-5794335daffaad66107ce111"
}

variable uptimerobot_contact_id {
  default = "2723576"
}

resource "uptimerobot_monitor" "topology_monitor_homolog" {
  friendly_name = "Google Monitor"
  type          = "http"
  url           = "https://www.google.com/"
  interval      = 3000

  alert_contact {
    id = "${var.uptimerobot_contact_id}"
  }
}

