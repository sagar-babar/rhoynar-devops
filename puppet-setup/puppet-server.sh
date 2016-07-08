#!/bin/bash
#This script designed for setup of puppet serveer in debian jessie#

if [ $1 == ""]
  then
  echo "Please provide memory(e.g 1g or 512m ) to allocate for puppetserver"
  exit 1
fi

memsize="-Xms$1 -Xmx$1"
masterhost='192.168.32.5    master.example.com master puppet'
agent1host='192.168.32.6    agent1.example.com agent1'
certname='certname = master.example.com'
dns_alt_name='dns_alt_names = puppet,master,master.example.com'
hostname1='master'

#setting hostname of server 
echo $hostname1 > /etc/hostname
hostname $hostname1

#Adding hostentries
echo $masterhost >> /etc/hosts
echo $agent1host >> /etc/hosts

#installing puppetserver
apt-get install ca-certificates
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-jessie.deb
sudo dpkg -i puppetlabs-release-pc1-jessie.deb
apt-get update
apt-get install puppetserver

#configuring puppet-server
export PATH=/opt/puppetlabs/bin:$PATH
sed -i "s/Xms2g -Xmx2g/$memsize/g" /etc/default/puppetserver
echo $certname >> /etc/puppetlabs/puppet/puppet.conf
echo $dns_alt_name >> /etc/puppetlabs/puppet/puppet.conf

# Starting puppetserver
/etc/init.d/puppetserver start

echo 'Pupet server is installed and configured successfully..!!'
