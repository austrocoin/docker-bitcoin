#!/bin/bash
set -e

if [[ "$1" == "dogecoin-cli" || "$1" == "dogecoin-tx" || "$1" == "dogecoind" || "$1" == "test_dogecoin" ]]; then
	mkdir -p "$BITCOIN_DATA"

	cat <<-EOF > "$BITCOIN_DATA/dogecoin.conf"
	printtoconsole=1
	rpcallowip=::/0
	${BITCOIN_EXTRA_ARGS}
	EOF
	chown bitcoin:bitcoin "$BITCOIN_DATA/dogecoin.conf"

	# ensure correct ownership and linking of data directory
	# we do not update group ownership here, in case users want to mount
	# a host directory and still retain access to it
	chown -R bitcoin "$BITCOIN_DATA"
	ln -sfn "$BITCOIN_DATA" /home/bitcoin/.dogecoin
	chown -h bitcoin:bitcoin /home/bitcoin/.dogecoin

	exec gosu bitcoin "$@"
else
	exec "$@"
fi
