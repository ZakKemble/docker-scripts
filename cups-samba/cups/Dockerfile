FROM debian:bookworm-slim
LABEL repo="https://github.com/ZakKemble/docker-scripts"

EXPOSE 631

RUN --mount=src=./pkgs,dst=./pkgs \
	   apt update \
	&& apt install -y \
		cups=2.4.2-3+deb12u8 \
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& dpkg -i --force-all \
		./pkgs/dcp7055lpr-2.1.0-1.i386.deb \
		./pkgs/cupswrapperDCP7055-2.0.4-2.i386.deb

# TODO could use printer-driver-brlaser package instead?

COPY --chown=root:lp ./configs/* /etc/cups/
COPY --chmod=755 entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
