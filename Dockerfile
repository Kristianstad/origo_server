# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_REPO=${SaM_REPO:-ghcr.io/kristianstad/secure_and_minimal}
ARG ALPINE_VERSION=${ALPINE_VERSION:-3.22}
ARG APP_VERSION=${APP_VERSION:-260522}
# Remember to check the version of package nodejs-current. Should match NODEJS_VERSION.
ARG NODEJS_VERSION="23.11"
ARG IMAGETYPE="application"
ARG INITIMAGE="node:${NODEJS_VERSION}-alpine${ALPINE_VERSION}"
ARG CLONEGITS="https://github.com/origo-map/origo-server.git"
ARG RUNDEPS="nodejs-current"
ARG BUILDDEPS="python3 py3-setuptools"
ARG BUILDCMDS=\
"   cd origo-server "\
"&& npm install "\
"&& chmod -R g+w conf "\
"&& sed -i '/var config = {/a \\    ssl: dbConfig.ssl || { rejectUnauthorized: false },' ../origo-server/lib/pg.js "\
"&& cp -a ../origo-server /finalfs/"
ARG STARTUPEXECUTABLES="/usr/bin/node"
# ARGs (can be passed to Build/Final) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} AS content1
FROM ${CONTENTIMAGE2:-scratch} AS content2
FROM ${CONTENTIMAGE3:-scratch} AS content3
FROM ${CONTENTIMAGE4:-scratch} AS content4
FROM ${CONTENTIMAGE5:-scratch} AS content5
FROM ${BASEIMAGE:-$SaM_REPO:base-${ALPINE_VERSION}} AS base
FROM ${INITIMAGE:-scratch} AS init
# Generic template (don't edit) </END>

# =========================================================================
# Build
# =========================================================================
# Generic template (don't edit) <BEGIN>
FROM ${BUILDIMAGE:-$SaM_REPO:build-${ALPINE_VERSION}} AS build
FROM ${BASEIMAGE:-$SaM_REPO:base-${ALPINE_VERSION}} AS final
COPY --from=build /finalfs /
# Generic template (don't edit) </END>

# =========================================================================
# Final
# =========================================================================
# Re-declare ARGs
ARG ALPINE_VERSION
ARG APP_VERSION

ENV VAR_FINAL_COMMAND="node /origo-server/app.js" \
    VAR_CONFIG_DIR="/etc/origo-server"

WORKDIR /origo-server

# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>

LABEL org.opencontainers.image.version="${APP_VERSION}" \
      org.opencontainers.image.title="origo_server" \
      org.opencontainers.image.description="Origo Server ${APP_VERSION} based on secure_and_minimal ${ALPINE_VERSION}"
