# Docker image to run Jupyter
This image provides an image based on Alpine Linux to run Jupyter. The image has `sparkmagic` installed already so that it can be used against a remote `HDInsight` cluster.

##
Create a directory on your local machine to store your notebooks. e.g. 
```bash
$ mkdir /home/<username>/notebooks
```
## Configuration 
If you are planning to use jupyter against an HDInsight cluster, please Update the username, password and cluster url in the `config.json` file. 

1. Encode password with base64
    ```bash
    $ echo -n 'secret-hdinsight-password' | base64
    ```
2. Copy the encoded base64 password and update the `base64_password` field in `sparkmagic/config.json` for the required kernels.
3. Update the `url` field in `sparkmagic/config.json` with the url of HDInsight cluster.

## Usage
Run the docker container 
```bash
$ docker build . -t jupyter-sparkmagic
$ docker run -d \
    -p 9999:9999 \
    --mount type=bind,source=/home/<username>/notebooks,target=/root/notebooks \
    --mount type=bind,source=$(pwd)/.sparkmagic,target=/root/.sparkmagic,readonly \
    jupyter-sparkmagic
```
Access jupyter by opening `localhost:9999` in a browser and use `supersecret` as the password.

## Add Python Packages
In order to add additional python packages to the container, update the `requirements.txt` file by adding the desired packages. Once all the packages have been added, rebuild the image and start a new container.

#### ToDo: 
- [ ] pre-commit hook to strip output from the notebooks
- [ ] authentication for notebooks
