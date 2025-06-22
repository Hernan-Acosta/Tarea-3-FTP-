from scapy.all import *
ip = IP(dst="172.19.0.2", src="172.19.0.3", ttl=2)
tcp = TCP(sport=12347, dport=21, flags="PA", seq=1002, ack=100)
payload = b"STOR prueba.txt\r\n"
pkt = ip/tcp/payload
send(pkt)
