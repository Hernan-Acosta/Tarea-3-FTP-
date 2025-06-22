from scapy.all import *
import random
import string

ip_dst = "172.19.0.2"
ip_src = "172.19.0.4"
port_dst = 21
port_src = 12345

for _ in range(10):
    fuzz_payload = ''.join(random.choices(string.printable, k=20))
    pkt = IP(dst=ip_dst, src=ip_src) / TCP(dport=port_dst, sport=port_src, flags="PA") / Raw(fuzz_payload.encode())
    send(pkt)
