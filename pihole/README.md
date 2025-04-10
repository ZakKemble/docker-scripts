# Pi-Hole

Pi-Hole v6 configured for DHCP, NTP and DNS with bridged networking. dhcp-helper is used to relay DHCP broadcast packets to the Pi-Hole container, and Bind9 or Unbound configured as a recursive DNS resolver (not just a forwarder).

Web interface should be reachable at https://pi.hole:8443/admin/login

### Network setup

See `.env`:

- `WEB_ACL`: Access control for pi.hole web interface
- `ROUTER_IP`: Your router IP
- `HOST_IP`: Must match the static IP of the machine running docker/Pi-Hole (make sure it's not within the DHCP range)
- `DHCP_START`: DHCP Range start
- `DHCP_END`: DHCP Range end

Make sure your ISPs router has been configured with an IP address that matches `ROUTER_IP` and disable the DHCP server. Some routers have a buggy interface where if you want to change the router IP you must also change the DHCP ranges accordingly, even if it's disabled.

### Bind9/Unbound

Comment and uncomment the appropriate sections in `docker-compose.yml` to enable whichever recursive DNS server you wish to use.

### IPv6

If your ISP and router has working IPv6 then you can enable IPv6 DNS connectivity with the following (this will allow Bind9/Unbound to connect to other nameservers via IPv6):

- `docker-compose.yml` > `networks` > `dhcp-relay-net` > add `enable_ipv6: true`
- `docker-compose.yml` > `services` > `bind9` > remove `command: "-4"`
- `unbound/config/unbound.conf` > add `do-ip6: yes`

### Other info

Because Pi-Hole is running in a container with bridged networking it will have different IP than your LAN network, so a few workarounds have been included:

- `FTLCONF_dns_interface` must be set to `eth0` (the container interface) so that DHCP works, otherwise it outputs this error `no address range available for DHCP request via eth0`
- `FTLCONF_dns_reply_host_force4` and `FTLCONF_dns_reply_host_IPv4` must be set to `HOST_IP` so that `pi.hole` resolves to the correct IP
- `FTLCONF_misc_dnsmasq_lines` overrides `ntp-servers` and `dns-servers` with the docker host IP and enables `dhcp-proxy` so that DHCP responses have the correct `server-identifier` IP
