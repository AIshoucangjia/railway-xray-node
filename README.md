# Railway US node — deployment draft (prepared 2026-10-25, NOT yet deployed)

Status: files only. No Railway account login, no domain, no node link, no QR code
exists yet — those are only created after the user logs in and confirms the
protocol, as stated in the 2026-10-25 10:37 chat reply.

## Agreed defaults (pending user confirmation)
- Region: US West (`us-west2`, California) — closer from Guangxi than US East.
- Protocol: VLESS + WS + TLS, port 443, over Railway's `*.up.railway.app` domain.
  Railway terminates TLS at the edge; Xray serves plain WS on `$PORT` inside.
- Cost reality (from the 2026-10-25 chat reply, re-check at deploy time):
  $5 one-time trial, 30 days, no card; then $0 free plan with only $1/month
  usage — a 0.5 GB resident service will not run a full month on $1 alone.

## Deploy steps (delivery agent, after user login + protocol confirmation)
1. User logs in to Railway in their own browser (Muse never fills passwords).
2. Create project → deploy from this folder (Dockerfile build), region US West.
3. In Railway Variables set:
   - `UUID` — generate fresh with `uuidgen` at deploy time; keep it in Railway
     Variables only, do not paste it in chat or commit it here.
   - `WS_PATH` — e.g. `/vless`
   - `PORT` is supplied by Railway automatically.
4. Deploy, copy the assigned `*.up.railway.app` domain from Railway.
5. ONLY then build the Shadowrocket link:
   `vless://<UUID>@<railway-domain>:443?encryption=none&security=tls&sni=<railway-domain>&type=ws&host=<railway-domain>&path=<url-encoded WS_PATH>#Railway-US-West`
   and generate its QR code from that exact link, then test connectivity
   before handing it over.
6. If the user switches protocol to Trojan or Shadowsocks, do NOT reuse this
   config — rebuild the inbound accordingly and re-confirm before deploying.

## Files
- `Dockerfile` — Alpine + Xray-core (version pinned in the file; verify the
  release tag still exists at deploy time).
- `config.template.json` — VLESS+WS inbound, placeholders only.
- `entrypoint.sh` — renders the template from Railway env vars, then runs Xray.
