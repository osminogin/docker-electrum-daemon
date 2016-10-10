# docker-electrum-daemon [![](https://images.microbadger.com/badges/image/osminogin/electrum-daemon.svg)](https://microbadger.com/images/osminogin/electrum-daemon)


## Running

```bash
docker run --rm -p 7000:7000 --name electrum_daemon electrum
```

**Warning**: Always link this electrum daemon to containers directly and not expose 7000 port for security reasons.

## License

MIT
