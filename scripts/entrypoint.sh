#!/usr/bin/env sh
if [ "${AUTO_CONFIG}" = "true" ] || [ "${AUTO_CONFIG}" = 1 ]; then
  /root/scripts/kubectl-config.sh
fi
exec "$@"
