#! bin/bash

#======================================================================
# FILE: install.sh
#
# USAGE: ./install.sh
#        or install.sh
#
# DESCRIPTION: Sets up VPN using OpenVPN
#
# OPTIONS:
# AUTHOR: 
# CREATED: 01.04.2019
# BUGS: 
#======================================================================

# install OpenVPN if it is not installed already
if [ !$(which openvpn)] then
    brew install openvpn
fi

openvpn --config myvpn.conf 
openvpn myvpn.conf 

# Set up UDP connection
 proto udp 

 # If setting up TCP connection

 # Set up TCP client and server
 # proto tcp-server
 # proto tcp-client

 # Provide official OpenVPN port number
 port 1194

 # Provide OpenVPN a remote to connect to for client configuration, will try all until a connection is established
 remote myvpn.example.com
 remote 192.168.200.200

 # For server side listen for clients
 listen 



