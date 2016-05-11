## PREREQUISITES

* Java7 or Java8

## INSTALLATION

Install embulk with embulk-input-vertica (this uses jdbc driver) plugin.

```
curl -o embulk -L http://dl.embulk.org/embulk-latest.jar
chmod +x embulk
./embulk bundle install --path vendor
```


## RUN

Modify embulk.yml to configure vertica host, port, user, password. Then,

```
./embulk run -b . embulk.yml
```

wait until num of records overflows (it took about 40 mins on my environment)
