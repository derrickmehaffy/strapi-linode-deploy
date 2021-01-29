###################
# Global Settings #
###################
# Linode API Key
linode_api_key = "yourLinodeAPIKey"

# If you already have an SSH key on Linode
# you can use the same public key and it will not be duplicated
#ssh_key = "ssh-rsa yourkey user@host"

# WIP don't use yet
#ssh_key_id = ""

# See the following API for Regions: https://api.linode.com/v4/regions
region = "us-west" # Fremont, CA USA

#######################
# Cloudflare Settings #
#######################
# Cloudflare is disabled by default
# you can enable it and set the settings below
cloudflare_enabled = true
cloudflare_email   = "user@example.com"
cloudflare_api_key = "yourAPIKey"
cloudflare_zone_id = "yourZoneID"
strapi_srv_domain  = "api-test"

#####################
# Instance Settings #
#####################

# See the following API for OS IDs: https://api.linode.com/v4/images
instance_os  = "linode/ubuntu20.04" # Ubuntu 20.04 LTS
instance_tag = "strapi"

##############################
# Strapi App Server Settings #
##############################

# See the following API for Plans: https://api.linode.com/v4/linode/types
strapi_plan           = "g6-standard-1" # Cost ~10$/month
strapi_label          = "my-strapi-srv"
strapi_server_backups = false

###################################
# Strapi Database Server Settings #
###################################

# See the following API for Plans: https://api.linode.com/v4/linode/types
database_plan           = "g6-standard-2" # Cost ~20$/month
database_label          = "my-strapi-db"
strapi_database_backups = false
