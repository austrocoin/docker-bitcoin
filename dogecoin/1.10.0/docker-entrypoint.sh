#!/bin/bash
set -e

if [[ "$1" == "dogecoin-cli" || "$1" == "dogecoin-tx" || "$1" == "dogecoind" || "$1" == "test_dogecoin" ]]; then
	mkdir -p "$BITCOIN_DATA"

	cat <<-EOF > "$BITCOIN_DATA/dogecoin.conf"
	printtoconsole=1
	rpcallowip=::/0
	${BITCOIN_EXTRA_ARGS}
	EOF
	chown dogecoin:dogecoin "$BITCOIN_DATA/dogecoin.conf"

	# ensure correct ownership and linking of data directory
	# we do not update group ownership here, in case users want to mount
	# a host directory and still retain access to it
	chown -R dogecoin "$BITCOIN_DATA"
	ln -sfn "$BITCOIN_DATA" /dogecoin/.dogecoin
	chown -h dogecoin:dogecoin /dogecoin/.dogecoin

	exec gosu dogecoin "$@"
else
	exec "$@"
fi
