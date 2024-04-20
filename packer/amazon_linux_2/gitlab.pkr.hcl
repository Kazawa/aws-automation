packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "al2" {
  ami_name      = "gitlab-${formatdate("YYYY-MM-DD-hhmmss", timestamp())}"
  instance_type = "t3.large"
  region        = "us-east-2"
  subnet_id = "subnet-083c91b87650dc369" # make this a data point
  associate_public_ip_address = true
  vpc_id = "vpc-0e4c9f7484c1582b3" # could make this an environment variable
  source_ami_filter {
    filters = {
      name = "amzn2-ami-hvm*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
      architecture = "x86_64"
    }
    most_recent = true
    owners      = ["137112412989"]
  }
  tags = {
    Name = "GitLab"
  }
  ssh_username = "ec2-user"
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.al2"
  ]

  # Gitlab Install's Here
  provisioner "shell" {
    scripts = fileset(".", "scripts/{gitlab-ee,}.sh")
  }
  provisioner "file" {
    source = "scripts/gitlab-config.sh"
    destination = "/tmp/gitlab-config.sh"
  }
  provisioner "file" {
    source = "config/gitlab-config.service"
    destination = "/tmp/gitlab-config.service"
  }
  provisioner "file" {
    source = "config/gitlab.rb"
    destination = "/tmp/gitlab.rb"
  }
  provisioner "shell" {
    inline = [
      "sudo mv /tmp/gitlab-config.sh /usr/lib/systemd/scripts/gitlab-config.sh",
      "sudo chown root:root /usr/lib/systemd/scripts/gitlab-config.sh",
      "sudo chmod 755 /usr/lib/systemd/scripts/gitlab-config.sh",
      "sudo mv /tmp/gitlab-config.service /usr/lib/systemd/system/gitlab-config.service",
      "sudo chown root:root /usr/lib/systemd/system/gitlab-config.service",
      "sudo chmod 644 /usr/lib/systemd/system/gitlab-config.service",
      "sudo mv /tmp/gitlab.rb /etc/gitlab/gitlab.rb",
      "sudo chown root:root /etc/gitlab/gitlab.rb",
      "sudo chmod 600 /etc/gitlab/gitlab.rb",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable gitlab-config",
    ]
  }
}
