# ElasticSearch docker image based on Alpine Linux

This repo builds a docker image working similar to the [official docker one](https://github.com/docker-library/docs/tree/master/elasticsearch)
but with a much smaller footprint. It achieves that by basing itself off the great
[alpine](https://github.com/gliderlabs/docker-alpine) docker image by GliderLabs.


# Build

```bash
$ make build
```

# Usage

The default command simply runs elasticsearch and exposes port 9200 and 9300:

```
$ docker run -d ukhomeoffice/elastic
```

You can decide to pass it additional flags by passing in a different command:

```
$ docker run -d ukhomeoffice/elastic elasticsearch -Des.node.name="TestNode"
```

This image uses a default set of config files but if you with to provide your own you can do so by mounting them to the `/usr/share/elasticsearch/config` directory:

```
$ docker run -d -v "$PWD/config":/usr/share/elasticsearch/config ukhomeoffice/elastic
```

Same thing goes for the data directory, if you want to keep you data mounted in a
volume:

```
$ docker run -d -v "$PWD/esdata":/usr/share/elasticsearch/data ukhomeoffice/elastic
```

This image includes `EXPOSE 9200 9300`, so standard container linking will make it automatically available to the linked containers

# License

MIT. See `LICENSE` file. Except for the `docker-entrypoint.sh` file that originates
from the official docker elasticsearch repo and is Apache licensed.
