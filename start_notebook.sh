#!/bin/sh
cd /root/notebooks
jupyter lab --ip=0.0.0.0 --port=9999 --no-browser --allow-root --NotebookApp.token='supersecret'
