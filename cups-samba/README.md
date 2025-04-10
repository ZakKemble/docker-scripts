# Samba File Sharing & CUPS Printer Sharing

```shell
docker compose up -d
```

## File Sharing

This uses the image from https://github.com/ServerContainers/samba

```cmd
net use x: \\(server-ip)\storage1 /user:myuser mypassword /persistent:no
```

## Printer Sharing

CUPS printer and scanner stuff has been configured for a Brother DCP-7055 USB laser printer/scanner.

Web interface should be reachable at http://(server-ip):631/

Handy Windows cmds for adding/removing printers:

```cmd
SET PRINTSERVER=192.168.1.142
RUNDLL32 printui.dll,PrintUIEntry /if /f %windir%\inf\ntprint.inf /b "DCP7055" /r "http://%PRINTSERVER%:631/printers/DCP7055" /m "Brother DCP-7055 Printer"
```

Remove:

```cmd
RUNDLL32 printui.dll,PrintUIEntry /n "DCP7055" /dl
```

## Scanner

To automatically start the scanner container when the printer/scanner is plugged in modify `scanner/70-scanner.rules` so that it points to the correct `scanner/run.sh` and then copy `70-scanner.rules` into `/etc/udev/rules.d/`.

Make sure the user `saned` exists on your host system and set execute permission on `scanner/run.sh`. The user (`BRSCAN_USER`) and output location (`OUTPUT_DIR`) can also be changed in `scanner/run.sh`.

```
nano scanner/70-scanner.rules
# (edit 70-scanner.rules as needed)
cp scanner/70-scanner.rules /etc/udev/rules.d/
useradd -r -M saned -s /sbin/nologin
chmod +x scanner/run.sh
```

Pre-build the image:

```shell
docker build --progress=plain -t scanner scanner/
```

Press the scan button on the printer to start a scan.
