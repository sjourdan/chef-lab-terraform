# Configure the DigitalOcean Provider
provider "digitalocean" {
    token = "${var.do_token}"
}

# Create a node that will be managed by Chef
# Configure the SSH Key
resource "digitalocean_ssh_key" "chef-lab-key" {
    name = "Chef Lab Key"
    public_key = "${file("${var.do_ssh_key_file}.pub")}"
}
resource "digitalocean_droplet" "chef" {
  count = 1
  image = "centos-7-0-x64"
  name = "chef"
  region = "lon1"
  size = "512mb"
  ssh_keys = [ "728562" ]
    
  connection {
    user = "root"
    type = "ssh"
    key_file = "${var.do_ssh_key_file}"
    timeout = "5m"
    host = "${digitalocean_droplet.chef.ipv4_address}"
    port = 22
  }

  provisioner "remote-exec" {
    
    inline = [
      "yum update -y",
      "curl -L https://www.chef.io/chef/install.sh | sudo bash"
    ]
    
  }
}
