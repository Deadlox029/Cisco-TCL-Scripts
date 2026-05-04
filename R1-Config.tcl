tclsh
##
## Enters Script to a file
##
puts [ open "flash:R1-Config.tcl" w+ ] {
##
## Set Access line Config
##
ios_config "line con 0" "logging synchronous" "no exec-timeout"
##
ios_config "hostname R1-1" "no ip domain-lookup"
##
## Set sub-interfaces
##
ios_config "interface GigabitEthernet0/0/0" "description Link to Next Station" 
ios_config "interface GigabitEthernet0/0/0" "ip address 10.100.100.3 255.255.255.0" "no shutdown"
ios_config "interface GigabitEthernet0/0/1.10" "encap dot1Q 10" "ip address 192.168.1.2 255.255.255.0"
ios_config "interface GigabitEthernet0/0/1.20" "encap dot1Q 20" "ip address 192.168.2.2 255.255.255.0"
ios_config "interface GigabitEthernet0/0/1.30" "encap dot1Q 30" "ip address 192.168.3.4 255.255.255.0"
##
## Set trunk interface
##
ios_config "interface GigabitEthernet0/0/1.5" "encapsulation dot1q 5 native"
##
## Open Gig0/0/1
##
ios_config "interface GigabitEthernet0/0/1" "no shutdown"
##
## Configure OSPF
##
ios_config "router ospf 1" "router-id 3.3.3.3" "network 192.168.1.0 0.0.0.255 area 0"
ios_config "router ospf 1" "network 192.168.2.0 0.0.0.255 area 0"
ios_config "router ospf 1" "network 192.168.3.0 0.0.0.255 area 0"
ios_config "router ospf 1" "network 10.100.100.0 0.0.0.255 area 0"
##
## Save config
##
write memory
}
tclquit
