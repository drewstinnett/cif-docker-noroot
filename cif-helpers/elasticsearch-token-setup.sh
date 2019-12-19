#!/usr/bin/env bash
set -x

# Load up env
until curl -s "http://${CIF_STORE_NODES}/_cluster/health"; do
    echo "Waiting for ${CIF_STORE_NODES} to be up"
    sleep 5
done

USERS="hunter admin smrt http"
for USER in $(echo $USERS); do
    if [[ "${USER}" == "http" ]]; then
        USERNAME=httpd
    else
        USERNAME=${USER}
    fi
    curl http://${CIF_STORE_NODES}/tokens/_search?q=username=${USERNAME} 2>/dev/null| grep token >/dev/null
    if [[ $? != 0 ]]; then
        echo "Creating TOKEN for ${USER}"
        TOKEN=$(head -n 50000 /dev/urandom | openssl dgst -sha512 | awk -F '= ' '{print $2}')
        cif-store -d --store elasticsearch --nodes ${CIF_STORE_NODES} \
            --token-create-${USER} --token ${TOKEN} --token-groups everyone
    fi
done
