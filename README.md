# CIF-Http Docker

This is meant to be a minimal container to run the cif router and http server
as non-root users

## Local Testing

You can use the included `docker-compose.yaml` to test out functionality, and
get a feel for other containers that will be needed here

## Usage

Because both the http and router processes use the same docker image, you can
specify the entrypoint based on which service you need to run.  There is an
example of this in the `docker-compose.yaml` file, but for reference, the entry
points are:

```
/cif-helpers/entrypoint-http
```

```
/cif-helpers/entrypoint-router
```

## Origin

Originally used the [sfinlon/cif-docker](https://github.com/sfinlon/cif-docker)
image, however I was needing to make a ton of changes to get it working in a
way that k8s/okd would like.  Hoping to contribute it back once I've got all
the pieces in place
