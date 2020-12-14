# metapy-container

MeTA + metapy Docker Container for a consistent metapy build and use experience.

## Contents

* `Dockerfile`
* Instructions for easy usage

## Artifacts

Published artifacts from this repo can be found here: <https://hub.docker.com/r/armhoeft/metapy-container>

## Usage Instructions

1. Download this image using Docker:

    ```{bash}
    docker pull armhoeft/metapy-container:latest
    ````

1. Run this container using Docker (default). This will run an interactive Python 3.9 session.

    ```{bash}
    docker run --rm -it --name some-name armhoeft/metapy-container
    ```

1. Run this container using Docker (custom). This will run an interactive Bash session, from which `python` and other commands can be executed.

    ```{bash}
    docker run --rm -it --name some-name armhoeft/metapy-container /bin/bash
    ```

1. Run a persisted copy of this container in the background (for continual use with environment changes persisted):

    ```{bash}
    docker run -d --name some-name armhoeft/metapy-container tail -f /dev/null
    ```

   To interact wih this container, run:

   ```{bash}
   docker exec -it some-name /bin/bash
   ```
