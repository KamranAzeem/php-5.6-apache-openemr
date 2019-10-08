# About this image:
This iamge caters for the primary needs for the [OpenEMR software](https://www.open-emr.org/), version 5.0.0. This image does not install OpenEMR, but actually creates a suitable base image with necessary OS tools, etc. 
Once we have base image, we avoid compilation of all these base PHP modules for every change we make in the RUN command.

# How to build and use:
Well, on your local computer, do:
```
docker built -t local/php:5.6-apache-openemr
```

Then in your other Dockerfile, which you will use to pull in actual openemr software, reference this image as **FROM**.

i.e.
```
FROM local/php:5.6-apache-openemr

. . . 
(Rest of your Dockerfile)
```

# DockerHub:
This image is available on DockerHub under the user `kamranazeem` . You should be able to pull it by using:
```
docker pull kamranazeem/php:5.6-apache-openemr
```


