FROM debian:bookworm-slim

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

COPY --chown=root:lp ./configs/* /etc/cups/
COPY --chmod=755 entrypoint.sh /

CMD ["/entrypoint.sh"]
