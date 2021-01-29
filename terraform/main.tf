terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.14.3"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.14.0"
    }
  }
}

# Configure the Linode Provider
provider "linode" {
  token       = var.linode_api_key
  api_version = "v4beta"
}

# Configure Cloudflare
provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

resource "cloudflare_record" "strapi_api_a" {
  count   = var.cloudflare_enabled ? 1 : 0
  zone_id = var.cloudflare_zone_id
  name    = var.strapi_srv_domain
  value   = linode_instance.strapi_server.ip_address
  type    = "A"
  ttl     = "1"
  proxied = false
}

# Linode SSH Key
resource "linode_sshkey" "strapi_ssh_key" {
  label   = "strapi-ssh-key"
  ssh_key = var.ssh_key
}

# Linode Firewall Rules
# Linode Firewall is currently in beta: https://www.linode.com/blog/linode/cloud-firewall-beta-open/
# resource "linode_firewall" "strapi_server" {
#   label = "strapi_server_rules"
#   tags  = [var.instance_tag, "server"]

#   inbound {
#     protocol  = "TCP"
#     ports     = ["80"]
#     addresses = ["0.0.0.0/0"]
#   }

#   inbound {
#     protocol  = "TCP"
#     ports     = ["443"]
#     addresses = ["0.0.0.0/0"]
#   }

#   inbound {
#     protocol  = "TCP"
#     ports     = ["1337"]
#     addresses = ["0.0.0.0/0"]
#   }

#   inbound {
#     protocol  = "TCP"
#     ports     = ["22"]
#     addresses = ["0.0.0.0/0"]
#   }

#   outbound {
#     protocol  = "TCP"
#     ports     = ["1-65535"]
#     addresses = ["0.0.0.0/0"]
#   }

#   outbound {
#     protocol  = "UDP"
#     ports     = ["1-65535"]
#     addresses = ["0.0.0.0/0"]
#   }

#   # outbound {
#   #   protocol  = "ICMP"
#   #   addresses = ["0.0.0.0/0"]
#   # }

#   linodes = [linode_instance.strapi_server.id]
# }

# resource "linode_firewall" "strapi_database" {
#   label = "strapi_database_rules"
#   tags  = [var.instance_tag, "database"]

#   inbound {
#     protocol  = "TCP"
#     ports     = ["3306"]
#     addresses = [linode_instance.strapi_server.private_ip_address]
#   }

#   inbound {
#     protocol  = "TCP"
#     ports     = ["22"]
#     addresses = ["0.0.0.0/0"]
#   }

#   outbound {
#     protocol  = "TCP"
#     ports     = ["1-65535"]
#     addresses = ["0.0.0.0/0"]
#   }

#   outbound {
#     protocol  = "UDP"
#     ports     = ["1-65535"]
#     addresses = ["0.0.0.0/0"]
#   }

#   # outbound {
#   #   protocol  = "ICMP"
#   #   addresses = ["0.0.0.0/0"]
#   # }

#   linodes = [linode_instance.strapi_database.id]
# }

# Linode Strapi Server Instance
resource "linode_instance" "strapi_server" {
  region          = var.region
  type            = var.strapi_plan
  label           = var.strapi_label
  tags            = [var.instance_tag]
  authorized_keys = [linode_sshkey.strapi_ssh_key.ssh_key]
  image           = var.instance_os
  private_ip      = true
  backups_enabled = var.strapi_server_backups
}

# Linode Strapi Database Instance
resource "linode_instance" "strapi_database" {
  region          = var.region
  type            = var.database_plan
  label           = var.database_label
  tags            = [var.instance_tag]
  authorized_keys = [linode_sshkey.strapi_ssh_key.ssh_key]
  image           = var.instance_os
  private_ip      = true
  backups_enabled = var.strapi_database_backups
}
