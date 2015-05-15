# Configure the DigitalOcean Provider
provider "digitalocean" {
    token = "${var.do_token}"
}

# Configure the SSH Key
resource "digitalocean_ssh_key" "chef-lab-key" {
    name = "Chef Lab Key"
    public_key = "${file("${var.do_ssh_key_file}.pub")}"
}

# Create a CentOS 7 node
# fully updated and installed with latest Chef
resource "digitalocean_droplet" "chef" {
  count = "${var.num_servers}"
  image = "${var.do_image}"
  name = "cheflab-${count.index+1}"
  region = "${var.do_region}"
  size = "${var.do_size}"
  ssh_keys = [ "${digitalocean_ssh_key.chef-lab-key.id}" ]
  user_data = ""

  connection {
    user = "root"
    key_file = "${var.do_ssh_key_file}"
  }

  provisioner "remote-exec" {

    inline = [
      "yum update -y"
    ]

  }
}
