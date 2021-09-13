FROM postgres:13.4-alpine
RUN localedef -i es_MX -c -f UTF-8 -A /usr/share/locale/locale.alias es_MX.UTF-8
ENV LANG es_MX.utf8