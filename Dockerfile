# Secure and Minimal image of Postgres
# https://hub.docker.com/repository/docker/huggla/sam-postgres

# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="2.0.4"
ARG IMAGETYPE="application"
ARG BASEIMAGE="node:alpine"
ARG CLONEGITS="https://github.com/origo-map/origo-server.git"
ARG BUILDCMDS=\
"   cd origo-server "\
"&& npm install "\
#"&& npm --depth 8 update "\
"&& cp -a ./ /finalfs/origo-server"
#ARG REMOVEDIRS="/origo/origo-documentation /origo/examples"
# ARGs (can be passed to Build/Final) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${CONTENTIMAGE4:-scratch} as content4
FROM ${CONTENTIMAGE5:-scratch} as content5
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-base}} as init
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
ENV VAR_ORIGO_CONFIG_DIR="/etc/origo-server"

# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>
