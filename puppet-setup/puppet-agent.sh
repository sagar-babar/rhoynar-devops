#!/bin/bash
#This script designed for setup of puppet serveer in debian jessie#

hostname='agent1'
masterhost='192.168.32.5    master.example.com master puppet'
agent1host='192.168.32.6    agent1.example.com agent1'
server = 'puppet'
certname = 'agent1.example.com'

#setting hostname of server 
echo $hostname > /etc/hostname
hostname $hostname

#Adding hostentries
echo $masterhost >> /etc/hosts
echo $agent1host >> /etc/hosts

#installing puppet-agent
 apt-get install ca-certificates -y
 wget https://apt.puppetlabs.com/puppetlabs-release-pc1-jessie.deb
 sudo dpkg -i puppetlabs-release-pc1-jessie.deb
 apt-get update -y
 sudo apt-get install puppet-agent -y

#configuring puppet-agent
export PATH=/opt/puppetlabs/bin:$PATH
echo '[agent]' >> /etc/puppetlabs/puppet/puppet.conf
echo $server >> /etc/puppetlabs/puppet/puppet.conf
echo $certname >> /etc/puppetlabs/puppet/puppet.conf

# Starting puppet-agent
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

echo 'Pupet server is installed and configured successfully..!!'
