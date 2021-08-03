The files in this repository were used to configure the network depicted below.

[NetworkDiagram](images/NetworkDiagram.jpg)

These files have been tested and used to generate a live ELK deployment on Azure. 
They can be used to either recreate the entire deployment pictured above. 
Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat.

  [pentest.yml](ansible/pentest.yml.txt)
  [install-elk.yml](ansible/install-elk.yml.txt)
  [file-playbook.yml](ansible/file-playbook.yml.txt)

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
   - Load Balancers protect application availabilty, allowing client requests to be shared accross a number of servers.
   - Having a jumpbox minimizes the risk of an attack by ensuirng remote connections to the cloud come through a single VM. 
     Lastly, Remote connections to the jumpbox can monitored easily to identify remote connections


Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the configuration and system files.
- filebeat is used to monitor logs files
- Metricbeat is used to collect operating system and service statistics from monitored VMs

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name    | Function | IP address                             | Operating System |
|---------|----------|----------------------------------------|------------------|
| Jumpbox | Gateway  | 10.0.0.4 Private/Public IP:138.91.73.7 | Linux            |
| Web-1   | DVWA     | 10.0.0.5                               | Linux            |
| Web-2   | DVWA     | 10.0.0.6                               | Linux            |
| Web-3   | ELK      | 10.1.0.4                               | Linux            |
### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jumpbox-Box-Provisioner machine can accept connections from the Internet. 
Access to this machine is only allowed from the following IP addresses:[Your home IP address]


Machines within the network can only be accessed by the Jumpbox.
  -The jumpbox can access the ELK VM Elk-1 and the IP address is 10.1.0.4

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 10.0.0.1 10.0.0.2    |
| Web-1    | no                  | 10.0.0.4             |
| Web-2    | no                  | 10.0.0.4             |
| Elk-virt | no                  | 10.0.0.4             |


### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
The main advantage

The playbook implements the following tasks:
-The very first thing I did was ssh into my jumpbox. which is ssh azadmin@[public IP of jumpbox]
-Now once you are in your jumpbox you want to get into your container.
   -the first command is sudo docker start mystifying ritchie
   -now that the containter is started you want to attach to it using the command sudo docker attach mystifying ritchie
-I navigated to /etc/ansible/roles directory and created the install-elk.yml
-While in that directory I was able to run the playbook with the command ansible-playbook install-elk.yml
-Now once ELk is installed i was able to ssh into the ELK-VM to verify the server

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

(Images/dockerps.jpg)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
Web-1:10.0.0.5
web-2:10.0.0.6

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat collects and ships (sends to ELK for collation, persistence and reporting) logs from VMs running the Filebeat agent
- Metricbeat collects and ships system metrics from the operating system and services of VMs running the Metricbeat


### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the playbook file to Ansible Docker container
- Update the ansible hosts file /etc/ansible/hosts to include

[Webserver]
10.0.0.5 ansible_python_interpreter=/usr/bin/python3
10.0.0.6 ansible_python_interpreter=/usr/bin/python3

[elkservers]
10.1.0.4 ansible_python_interpreter=/usr/bin/python3

update the ansible configuration file /etc/ansible.cfg and set the remote_user parameter to the asmin user of the web server
- Run the playbook, and navigate to http://[elk public ip address]:5601/ to check that the installation worked as expected.


- Which file is the playbook? filebeat-playbook.yml 
- Where do you copy it?_ /etc/ansible/roles
- _Which file do you update to make Ansible run the playbook on a specific machine? You would need to navigate to /etc/ansible/hosts file and there you can specify the IP of the virtual machine that needs to run the playbook.
How do I specify which machine to install the ELK server on versus which to install Filebeat on? I would needs to specify two separate goroups in the etc/ansible/hosts file. I would have a wevserver group and underneath i would specify the Ips of the VMs that filebeat will be installed on. The next group that I will create is called [elk] and underneath that group I will specify the Ip of the VM that elk will be installed on.
- _Which URL do you navigate to in order to check that the ELK server is running? http://[elk public-ip]:5601/

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc.__

-ssh into the jumpbox , ssh yourusername@[jumpbox public IP address]

-start the ansible Docker container, sudo docker start [ansible container]

-Attach a shell to the ansible docker container with the command, sudo docker attach [ansible container]

-run the playbooks with following commands
    ansible-playbook /etc/ansible/pentest.yml 

    ansible-playbook /etc/ansible/install-elk.yml-configures the servers listed as [elkserver]

    ansible-playbook /etc/ansible/roles/filebeat-playbook.yml - configures the server listed as [webserver]

-With followiing this order everything should be configured properly and kibana can be access at http://[elk server ip]:5601/app/kibana
