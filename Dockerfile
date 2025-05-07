# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_REPO=${SaM_REPO:-ghcr.io/kristianstad/secure_and_minimal}
ARG ALPINE_VERSION=${ALPINE_VERSION:-3.21}
# Remember to check the version of package nodejs-current. Should match NODEJS_VERSION.
#ARG NODEJS_VERSION="23.2.0"
ARG NODEJS_VERSION="23"
ARG IMAGETYPE="application
ARG INITIMAGE="node:$NODEJS_VERSION-alpine$ALPINE_VERSION"
ARG CLONEGITS="https://github.com/origo-map/origo-server.git"
ARG RUNDEPS="nodejs-current"
ARG BUILDDEPS="python3"
ARG BUILDCMDS=\
"   cd origo-server "\
"&& npm install "\
#"&& npm --depth 8 update "\
"&& chmod -R g+w conf "\
"&& cp -a ../origo-server /finalfs/"
ARG STARTUPEXECUTABLES="/usr/bin/node"
# ARGs (can be passed to Build/Final) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${CONTENTIMAGE4:-scratch} as content4
FROM ${CONTENTIMAGE5:-scratch} as content5
FROM ${BASEIMAGE:-$SaM_REPO:base-$ALPINE_VERSION} as base
FROM ${INITIMAGE:-scratch} as init
# Generic template (don't edit) </END>

# =========================================================================
# Build
# =========================================================================
# Generic template (don't edit) <BEGIN>
FROM ${BUILDIMAGE:-$SaM_REPO:build-$ALPINE_VERSION} as build
FROM ${BASEIMAGE:-$SaM_REPO:base-$ALPINE_VERSION} as final
COPY --from=build /finalfs /
# Generic template (don't edit) </END>

# =========================================================================
# Final
# =========================================================================
ENV VAR_FINAL_COMMAND="node /origo-server/app.js" \
    VAR_CONFIG_DIR="/etc/origo-server"
WORKDIR /origo-server

# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>
