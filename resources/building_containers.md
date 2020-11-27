### Build the Docker container
```bash
sudo docker build -t eqtlcatalogue/susie-finemapping:v20.08.1 .
```

### Push to DockerHub
```bash
docker push eqtlcatalogue/susie-finemapping:v20.08.1
```

### Tag the container for Quay.io
```bash
docker tag eqtlcatalogue/susie-finemapping:v20.08.1 quay.io/eqtlcatalogue/susie-finemapping:v20.08.1
```

### Push the container to Quay.io
```bash
docker push quay.io/eqtlcatalogue/susie-finemapping:v20.08.1
```

### Build a local copy of the Singularity container
```bash
singularity build susie-finemapping.img docker://quay.io/eqtlcatalogue/susie-finemapping:v20.08.1
```
