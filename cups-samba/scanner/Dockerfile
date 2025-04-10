FROM debian:bookworm-slim

RUN --mount=src=./pkgs,dst=./pkgs \
	   apt update \
	&& apt install -y \
		beep \
		sane-utils \
		imagemagick \
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir /scanner \
	&& dpkg -i --force-all \
		./pkgs/brscan4-0.4.11-1.amd64.deb \
		./pkgs/brscan-skey-0.3.2-0.amd64.deb

# make sure "brother4" has been added to /etc/sane.d/dll.conf

COPY --chmod=755 scantofile.sh entrypoint.sh .
COPY brscan-skey.config /opt/brother/scanner/brscan-skey/

ENTRYPOINT ["/entrypoint.sh"]
