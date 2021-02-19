# Secure and Minimal image of Postgres
# https://hub.docker.com/repository/docker/huggla/sam-postgres

# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="2.0.5"
ARG IMAGETYPE="application"
ARG INITIMAGE="node:alpine"
ARG INITCMDS=\
'   find / -path "/finalfs/*" -mindepth 2 -maxdepth 2 -exec cp -a "{}" / \; '\
#'&& rm -rf /finalfs/* '\
'&& mkdir -p /finalfs/usr/local/bin'
ARG CLONEGITS="https://github.com/origo-map/origo-server.git"
ARG RUNDEPS="nodejs-current"
ARG BUILDDEPS="python2"
ARG BUILDCMDS=\
"   cd origo-server "\
"&& npm install "\
"&& npm --depth 8 update "\
"&& cp -a ../origo-server /finalfs/"
ARG STARTUPEXECUTABLES="/usr/bin/node"
# ARGs (can be passed to Build/Final) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${CONTENTIMAGE4:-scratch} as content4
FROM ${CONTENTIMAGE5:-scratch} as content5
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-base}} as init
RUN mkdir -p /environment
# Generic template (don't edit) </END>

# =========================================================================
# Build
# =========================================================================
# Generic template (don't edit) <BEGIN>
FROM ${BUILDIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-build} as build
FROM ${BASEIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-base} as final
COPY --from=build /finalfs /
# Generic template (don't edit) </END>

# =========================================================================
# Final
# =========================================================================
ENV VAR_FINAL_COMMAND="cd origo-server && node app.js" \
    VAR_CONFIG_DIR="/etc/origo-server"

# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>
