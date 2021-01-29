output "strapi_server_label" {
  value = linode_instance.strapi_server.label
}

output "strapi_server_public_ip" {
  value = linode_instance.strapi_server.ip_address
}

output "strapi_server_private_ip" {
  value = linode_instance.strapi_server.private_ip_address
}

output "strapi_database_label" {
  value = linode_instance.strapi_database.label
}

output "strapi_database_public_ip" {
  value = linode_instance.strapi_database.ip_address
}

output "strapi_database_private_ip" {
  value = linode_instance.strapi_database.private_ip_address
}

### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
  content = templatefile("templates/inventory.tmpl",
    {
      strapi-label   = linode_instance.strapi_server.label,
      strapi-id      = linode_instance.strapi_server.id,
      strapi-ip      = linode_instance.strapi_server.ip_address,
      database-label = linode_instance.strapi_database.label,
      database-id    = linode_instance.strapi_database.id,
      database-ip    = linode_instance.strapi_database.ip_address
    }
  )
  filename = "../ansible/inventory"
}

### Output vars for Ansible
resource "local_file" "Ansible_All_SSH" {
  content = templatefile("templates/ansible_tf_vars.tmpl",
    {
      public-ssh-key  = linode_sshkey.strapi_ssh_key.ssh_key
      db-name         = trimsuffix(linode_instance.strapi_database.label, "-db")
      db-ip           = linode_instance.strapi_database.private_ip_address
      strapi-app-name = linode_instance.strapi_server.label
      strapi-url      = element(cloudflare_record.strapi_api_a.*.hostname, 0)
    }
  )
  filename = "../ansible/tf_vars/tf_vars.yml"
}
