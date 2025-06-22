from scapy.all import *

ip = IP(dst="172.19.0.2", src="172.19.0.3")
tcp = TCP(sport=12346, dport=21, flags="PA", seq=1001, ack=100)
payload = b"STOR fake.txt\r\n"
pkt = ip/tcp/payload
send(pkt)
