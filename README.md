## Docker Images for R with Jupyter Notebook

This repository contains the Dockerfiles for building a lightweight Docker image for R with Jupyter Notebook. It also includes some useful Jupyter Notebook extensions, including LaTeX environment and spell checker.

These images are particularly useful for teaching, learning, and quick prototyping. The prebuilt images are available at <https://quay.io/organization/datacomputing>.

## Using the Prebuilt Images

It is extremely easy to use the prebuilt images. First, make sure that you have Docker on your computer (MacOS, Linux, cloud platforms, etc.) by following the instructions at [docker.com](https://docs.docker.com/engine/getstarted/step_one/). Then follow these two basic steps:

 1. Download the `docker-notebook` script onto your local machine using the following command in a terminal:
 ```
     curl -O https://github.com/datacompsci/r-dockerfiles/raw/master/docker-notebook
```
2. Run the `docker-notebook` command in the directory where you want to save your Notebook files. For example, to open a notebook named r-intro.ipynb, run the following command
```
     docker-notebook r-intro.ipynb
``` 
   It will download and run the r-notebook Docker image, launch Jupyter Notebook within the image, and open up Jupyter Notebook in your default web browser.

## Limitations

* *Note that you should only save files under the shared directory. All other files will be lost when the Docker image exits.
* The `docker-notebook` script does not yet support MS Windows. To run on the Windows platforms, follow the instructions in the r-notebook subdirectory for launching the image manually.
