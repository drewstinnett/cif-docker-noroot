#!/usr/bin/env python
import sys
import os

def main():

    env_prefix = 'CIFENV_'
    cif_env_file = '/etc/cif.env'

    cif_env_conf = {
        'CIF_LOGLEVEL': 'INFO',
        'CIF_RUNTIME_PATH': "/var/run/cif",
        'CIF_DATA_PATH': "/var/lib/cif",
        'CIF_STORE_STORE': "sqlite",
        'CIF_STORE_NODES': "localhost:9200",
        'CIF_ROUTER_CONFIG_PATH': "/etc/cif/cif-router.yml",
        'CIF_HUNTER_EXCLUDE': "osint.bambenekconsulting.com:dga",
        'CIF_HUNTER_THREADS': "",
        'CIF_GATHERER_THREADS': "2",
        'CIF_HUNTER_ADVANCED': "",
        'CIFSDK_CLIENT_ZEROMQ_FIREBALL_SIZE': "500",
        'CIF_HTTPD_LISTEN': "127.0.0.1",
        'CIF_HTTPD_TOKEN': "",
        'CIF_HTTPD_PROXY': 0,
        'CIF_STORE_TRACE': 0,
        'CIF_ROUTER_TRACE': 0,
        'CIF_HUNTER_TRACE': 0,
        'CIF_HTTPD_TRACE': 0
    }

    for item, value in os.environ.items():
        if item.startswith(env_prefix):
            config_name = item.replace(env_prefix, '')
            cif_env_conf[config_name] = value
    with open(cif_env_file, "w") as f:
        for item, value in cif_env_conf.items():
            # Make sure to quote blank values
            if value == "":
                value = '""'

            f.write("%s=%s\n" % (item, value))
    print("Wrote %s" % cif_env_file)



if __name__ == "__main__":
    sys.exit(main())
