## Install ownCloud
```bash
docker build -t owncloud .
```

```bash
docker run -p 8001:80 [-v DATA_DIR:/var/www/owncloud/data] [-v LOG_DIR:/var/log] --name owncloud -it owncloud
```

### Recommendations
Use at least the data mountpoint (user and group should be owned by nobody:nobody)
This means, when the docker container is deleted the data remains.

```bash
chown -R nobody:nobody DATA_DIR
```
