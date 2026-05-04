tclsh
##
## Enters Script to a file
##
puts [ open "flash:Sw1-Config.tcl" w+ ] {
 ##
 ios_config "line con 0" "logging synchronous" "no exec-timeout"
 ##
 ios_config "hostname Sw1" "no ip domain-lookup"
 ##
 ## Configure vlans
 ##
 set vlan_list {
    10  PC1
    20  PC2
    30  Management
    5   Native
    99  Void
}
foreach {vlan_id vlan_name} $vlan_list {
    ios_config "vlan $vlan_id" "name $vlan_name"git 
}
##
## Configure gigabit ports
##
ios_config "interface vlan 30" "ip address 192.168.3.3 255.255.255.0" "no shutdown"
ios_config "ip default-gateway 10.100.100.1"
ios_config "interface FastEthernet0/1" "switchport mode access" "switchport access vlan 10"
ios_config "interface GigabitEthernet0/2" "switchport mode trunk" "switchport trunk native vlan 5"
ios_config "interface GigabitEthernet0/1" "switchport mode trunk" "switchport trunk native vlan 5"
##
## Shutdown unused ports
##
foreach port {
    FastEthernet0/5  FastEthernet0/6  FastEthernet0/7  FastEthernet0/8
    FastEthernet0/9  FastEthernet0/10 FastEthernet0/11 FastEthernet0/12
    FastEthernet0/13 FastEthernet0/14 FastEthernet0/15 FastEthernet0/16
    FastEthernet0/17 FastEthernet0/18 FastEthernet0/19 FastEthernet0/20
    FastEthernet0/21 FastEthernet0/22 FastEthernet0/23 FastEthernet0/24
} {
    ios_config "int $port" "spanning-tree portfast" "spanning-tree bpduguard enable" 
    ios_config "int $port" "shutdown"
}
write memory
}
tclquit
