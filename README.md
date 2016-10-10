# docker-electrum-daemon [![](https://images.microbadger.com/badges/image/osminogin/electrum-daemon.svg)](https://microbadger.com/images/osminogin/electrum-daemon)

Electrum client as a daemon docker container.

Don't confuse with [Electrum server](https://github.com/spesmilo/electrum-server) that use bitcoind and full blockchain data. [Electrum client](https://electrum.org/) is light bitcoin wallet software operates through supernodes (Electrum server instances actually).

### Ports

* ``7000`` - JSONRPC port.

### Volumes

* ``/data`` - usually on host it has a path ``/home/user/.electrum``.


## Running

```bash
docker run --rm -p 7000:7000 --name electrum osminogin/electrum-daemon
```

**Warning**: Always link electrum daemon to containers directly and not expose 7000 port for security reasons.


## Usage

```bash
curl --data-binary '{"id":"1","method":"help"}' http://localhost:7000
```

## API

* [API related sources](https://github.com/spesmilo/electrum/blob/master/lib/commands.py).

## License

MIT
