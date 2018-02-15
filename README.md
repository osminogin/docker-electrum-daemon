# docker-electrum-daemon

[![](https://img.shields.io/docker/build/osminogin/electrum-daemon.svg)](https://hub.docker.com/r/osminogin/electrum-daemon/builds/) [![](https://images.microbadger.com/badges/version/osminogin/electrum-daemon.svg)](https://microbadger.com/images/osminogin/electrum-daemon) [![](https://images.microbadger.com/badges/commit/osminogin/electrum-daemon.svg)](https://microbadger.com/images/osminogin/electrum-daemon) [![](https://img.shields.io/docker/stars/osminogin/electrum-daemon.svg)](https://hub.docker.com/r/osminogin/electrum-daemon) [![](https://images.microbadger.com/badges/image/osminogin/electrum-daemon.svg)](https://microbadger.com/images/osminogin/electrum-daemon) [![License: MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg)](https://opensource.org/licenses/MIT)


**Electrum client running as a daemon in docker container with JSON-RPC enabled.**

[Electrum client](https://electrum.org/) is light bitcoin wallet software operates through supernodes (Electrum server instances actually).

Don't confuse with [Electrum server](https://github.com/spesmilo/electrum-server) that use bitcoind and full blockchain data.

Star this project on Docker Hub :star2: https://hub.docker.com/r/osminogin/electrum-daemon/

### Ports

* `7000` - JSON-RPC port.

### Volumes

* `/data` - usually on host it has a path ``/home/user/.electrum``.


## Getting started

#### docker

Running with Docker:

```bash
docker run --rm --name electrum-daemon \
    --publish 127.0.0.1:7000:7000 \
    --volume /srv/electrum:/data \
    osminogin/electrum-daemon
```
```bash
docker exec -it electrum-daemon electrum create
docker exec -it electrum-daemon electrum daemon load_wallet
docker exec -it electrum-daemon electrum daemon status
{
    "auto_connect": true,
    "blockchain_height": 505136,
    "connected": true,
    "fee_per_kb": 427171,
    "path": "/home/electrum/.electrum",
    "server": "us01.hamster.science",
    "server_height": 505136,
    "spv_nodes": 10,
    "version": "3.0.6",
    "wallets": {
        "/home/electrum/.electrum/wallets/default_wallet": true
    }
}
```


#### docker-compose

Take a look at `docker-compose.yml` to see how this is setup. When running in production, you can use this as a guide.

```bash
docker-compose up
docker-compose exec electrum electrum daemon status
docker-compose exec electrum electrum create
docker-compose exec electrum electrum daemon load_wallet
curl --data-binary '{"id":"1","method":"listaddresses"}' http://electrum:electrumz@localhost:7000
```

:exclamation:**Warning**:exclamation:

Always link electrum daemon to containers or bind to localhost directly and not expose 7000 port for security reasons.

## API

* [Electrum protocol specs](http://docs.electrum.org/en/latest/protocol.html)
* [API related sources](https://github.com/spesmilo/electrum/blob/master/lib/commands.py)

## License

MIT
