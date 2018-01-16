# Docker image to run Jupyter
This image provides an image based on Alpine Linux to run Jupyter. The image has `sparkmagic` installed already so that it can be used against a remote `HDInsight` cluster.

##
Create a directory on your local machine to store your notebooks. e.g. 
```bash
$ mkdir /home/<username>/notebooks
```
## Configuration 
If planning to use jupyter against an hdinsight cluster, please Update the username, password and cluster url in the `config.json` file. 
## Usage
```bash
$ docker build . -t jupyter-hdi
$ docker run -d -p 9999:9999 --mount /home/<username>/notebooks jupyter-hdi
```
## Add Python Packages
In order to add additional python packages to the container, update the `requirements.txt` file by adding the desired packages. Once all the packages have been added, rebuild the image and start a new container.

todo: 
git handling of notebooks, outputs clearing