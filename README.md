# docker-electrum-daemon

[![](https://img.shields.io/docker/build/osminogin/electrum-daemon.svg)](https://hub.docker.com/r/osminogin/electrum-daemon/builds/) [![](https://img.shields.io/docker/stars/osminogin/electrum-daemon.svg)](https://hub.docker.com/r/osminogin/electrum-daemon) [![](https://images.microbadger.com/badges/image/osminogin/electrum-daemon.svg)](https://microbadger.com/images/osminogin/electrum-daemon) [![License: MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg)](https://opensource.org/licenses/MIT)

**Electrum client running as a daemon in docker container with JSON-RPC enabled.**

Don't confuse with [Electrum server](https://github.com/spesmilo/electrum-server) that use bitcoind and full blockchain data. [Electrum client](https://electrum.org/) is light bitcoin wallet software operates through supernodes (Electrum server instances actually).

Star this project on Docker Hub :star2: https://hub.docker.com/r/osminogin/electrum-daemon/

### Ports

* ``7000`` - JSON-RPC port.

### Volumes

* ``/data`` - usually on host it has a path ``/home/user/.electrum``.


## Running

```bash
docker run --rm -p 127.0.0.1:7000:7000 --name electrum osminogin/electrum-daemon
```

:exclamation:**Warning**:exclamation:

Always link electrum daemon to containers or bind to localhost directly and not expose 7000 port for security reasons.


## Usage

```bash
docker exec -it electrum electrum daemon status
docker exec -it electrum electrum create
curl --data-binary '{"id":"1","method":"listaddresses"}' http://localhost:7000
```

## API

* [Electrum protocol specs](http://docs.electrum.org/en/latest/protocol.html)
* [API related sources](https://github.com/spesmilo/electrum/blob/master/lib/commands.py)

## License

MIT
