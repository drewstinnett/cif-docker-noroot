# CIF-Http Docker

This is meant to be a minimal container to run the cif router and http server
as non-root users

## Local Testing

You can use the included `docker-compose.yaml` to test out functionality, and
get a feel for other containers that will be needed here

## Origin

Originally used the [sfinlon/cif-docker](https://github.com/sfinlon/cif-docker)
image, however I was needing to make a ton of changes to get it working in a
way that k8s/okd would like.  Hoping to contribute it back once I've got all
the pieces in place
