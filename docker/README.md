The instructions below are for building your own Docker image. A prebuilt Docker image is available on Docker Cloud, if you only want to run the notebooks example image then install Docker and [read the instructions on the main page](../README.md#docker) on how to do this.

## Preflight

You will need [Docker installed](https://www.docker.com/community-edition) on your workstation; make sure it is a recent version.

Check out a copy of the project with:

    git clone https://github.com/KxSystems/mlnotebooks.git

## Building

To build the project locally you run:

    docker build -t notebooks -f docker/Dockerfile .

Once built, you should have a local `notebooks` image, you can run the following to use it:

    docker run -it -p 8888:8888 notebooks

Other build arguments are supported and you should browse the `Dockerfile` to see what they are.

