# Railway Xray deployment — DRAFT, untested in this run.
# Railway terminates TLS at *.up.railway.app:443, so Xray itself serves
# plain VLESS+WS on Railway's $PORT. Do NOT invent a domain or QR code
# before Railway assigns one; the node link is built only after deploy.
FROM alpine:3.20
RUN apk add --no-cache curl unzip
ARG XRAY_VERSION=v25.9.10
RUN curl -L -o /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/download/${XRAY_VERSION}/Xray-linux-64.zip" \
    && unzip /tmp/xray.zip -d /usr/local/bin/ xray \
    && chmod +x /usr/local/bin/xray \
    && rm /tmp/xray.zip
COPY entrypoint.sh /entrypoint.sh
COPY config.template.json /config.template.json
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
