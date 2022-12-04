# SageMath

## Issues

* Unable to run `sage -pip install` due to issues with TLS.
  ```sh
  sage -i ssl
  sage -f python3
  ```
* Unable to open SageMath.app from the Finder.
  ```sh
  sudo spctl --master-disable
  ```
