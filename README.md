# Chef Lab Terraform

This is a simple attempt at quickly bootstrapping a bunch of CentOS 7.0 servers running on Digital Ocean fully updated and with the latest Chef.

## Configure

Rename `terraform.tfvars.example` to `terraform.tfvars`:

    $ cp terraform.tfvars.example terraform.tfvars

Edit the amount of required instances in `terraform.tfvars`:

    num_servers = 2

Or change the region:

    do_region = "fra1"

Etc.

## Run

    $ terraform apply

## Destroy

    $ terraform destroy
