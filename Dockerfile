FROM devanlai/diptrace:2.4.0.2

MAINTAINER Devan Lai <devan.lai@gmail.com>

ADD http://ahkscript.org/download/ahk-install.exe /tmp/ahk-install.exe
COPY bin/* /tmp/bin/

RUN xvfb-run wine /tmp/ahk-install.exe /S && /tmp/bin/waitfor.sh wineserver && \
test -f "`winepath 'C:\Program Files\AutoHotkey\AutoHotkey.exe'`" && \
/tmp/bin/waitfor.sh wineserver

RUN rm /tmp/ahk-install.exe

COPY diptrace.reg /tmp/diptrace.reg
RUN xvfb-run wine regedit /tmp/diptrace.reg && \
/tmp/bin/waitfor.sh wineserver

RUN rm /tmp/diptrace.reg

COPY ahk/*.ahk /tmp/ahk/

VOLUME ["/mnt/import/", "/mnt/export/"]