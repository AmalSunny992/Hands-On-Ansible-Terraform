# Hands-On-Ansible-Terraform
Using Ansible and Terraform Deploy a Java Application
To deploy a Java web application (Weather App) from a GitHub repository using Terraform and Ansible, you need to make adjustments to both the Terraform and Ansible configurations. Here's a detailed guide:

Step 1: Setup Terraform Server
1.1. Launch an EC2 Instance for Terraform
AMI: Amazon Linux 2 AMI
Instance Type: t2.micro (or larger if needed)
Security Group: Allow SSH (port 22)
Key Pair: Use an existing key pair or create a new one
1.2. Connect to the Terraform EC2 Instance
sh
Copy code
ssh -i /path/to/your-key.pem ec2-user@terraform_instance_public_ip
1.3. Install Terraform
sh
Copy code
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
1.4. Setup Terraform Configuration
Create Terraform configuration files on the Terraform server:

main.tf
hcl
Copy code
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"

  key_name = var.key_name

  tags = {
    Name = "WebAppInstance"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.web.public_ip} > ip_address.txt"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow web traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}
variables.tf
hcl
Copy code
variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}
terraform.tfvars
hcl
Copy code
key_name = "your-key-pair-name"
1.5. Initialize and Apply Terraform
sh
Copy code
terraform init
terraform apply
This will create an EC2 instance and output its public IP address.

Step 2: Setup Ansible Server
2.1. Launch an EC2 Instance for Ansible
AMI: Amazon Linux 2 AMI
Instance Type: t2.micro (or larger if needed)
Security Group: Allow SSH (port 22)
Key Pair: Use the same key pair used for the Terraform instance or another if preferred
2.2. Connect to the Ansible EC2 Instance
sh
Copy code
ssh -i /path/to/your-key.pem ec2-user@ansible_instance_public_ip
2.3. Install Ansible
sh
Copy code
sudo amazon-linux-extras install ansible2 -y
2.4. Install Dependencies for Building Java Applications
sh
Copy code
sudo yum install -y git java-1.8.0-openjdk-devel maven
2.5. Setup Ansible Configuration
Create Ansible configuration files on the Ansible server:

inventory
ini
Copy code
[web]
<INSTANCE_IP_ADDRESS>
Replace <INSTANCE_IP_ADDRESS> with the IP address output by Terraform.

playbook.yml
yaml
Copy code
- hosts: web
  become: yes
  tasks:
    - name: Update and upgrade packages
      yum:
        name: "*"
        state: latest

    - name: Install Java JDK
      yum:
        name: java-1.8.0-openjdk-devel
        state: present

    - name: Install Tomcat
      yum:
        name: tomcat
        state: present

    - name: Start and enable Tomcat
      service:
        name: tomcat
        state: started
        enabled: yes

    - name: Install Git
      yum:
        name: git
        state: present

    - name: Clone the Weather App repository
      git:
        repo: 'https://github.com/yourusername/weather-app.git'
        dest: /tmp/weather-app

    - name: Build the Weather App
      command: mvn -f /tmp/weather-app/pom.xml clean package
      args:
        creates: /tmp/weather-app/target/weather-app.war

    - name: Copy the WAR file to Tomcat webapps directory
      copy:
        src: /tmp/weather-app/target/weather-app.war
        dest: /var/lib/tomcat/webapps/weather-app.war

    - name: Restart Tomcat
      service:
        name: tomcat
        state: restarted
ansible.cfg
ini
Copy code
[defaults]
inventory = ./inventory
remote_user = ec2-user
private_key_file = path/to/your/private/key.pem
host_key_checking = False
2.6. Run Ansible Playbook
sh
Copy code
ansible-playbook playbook.yml
Summary
Terraform Server: Provisions the infrastructure on AWS.
Ansible Server: Configures the EC2 instance, installs necessary software, clones the Java application from GitHub, builds it using Maven, and deploys the WAR file to Tomcat.
