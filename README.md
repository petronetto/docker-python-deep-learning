```
  _____                    _                           _
 |  __ \                  | |                         (_)
 | |  | | ___  ___ _ __   | |     ___  __ _ _ __ _ __  _ _ __   __ _
 | |  | |/ _ \/ _ \ '_ \  | |    / _ \/ _` | '__| '_ \| | '_ \ / _` |
 | |__| |  __/  __/ |_) | | |___|  __/ (_| | |  | | | | | | | | (_| |
 |_____/ \___|\___| .__/  |______\___|\__,_|_|  |_| |_|_|_| |_|\__, |
                  | |                                           __/ |
                  |_|                                          |___/
```
[![nodesource/node](http://dockeri.co/image/petronetto/docker-python-deep-learning)](https://registry.hub.docker.com/u/petronetto/docker-python-deep-learning/)

[![](https://images.microbadger.com/badges/image/petronetto/docker-python-deep-learning.svg)](https://microbadger.com/images/petronetto/docker-python-deep-learning "Get your own image badge on microbadger.com")
[![GitHub issues](https://img.shields.io/github/issues/petronetto/docker-python-deep-learning.svg)](https://github.com/petronetto/docker-python-deep-learning/issues)
[![GitHub license](https://img.shields.io/github/license/petronetto/docker-python-deep-learning.svg)](https://raw.githubusercontent.com/petronetto/docker-python-deep-learning/master/LICENSE)
[![Twitter](https://img.shields.io/twitter/url/https/github.com/petronetto/docker-python-deep-learning.svg?style=social)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Fpetronetto%2Fdocker-python-deep-learning)
[![CircleCI](https://circleci.com/gh/petronetto/docker-python-deep-learning/tree/master.svg?style=svg)](https://circleci.com/gh/petronetto/docker-python-deep-learning/tree/master)

## What is include
- Python 3.5
- NumPy
- Pandas
- SciPy
- Scikit-learn
- Matplotlib
- Seaborn
- XGBoost
- TensorFlow
- Keras
- PyTorch
- Torch Vision
- Jupyter Notebook

## Running the container

```sh
docker run -it --name deep-learning \
           -v $(PWD):/home/notebooks \
           -p 8888:8888 -d \
           petronetto/docker-python-deep-learning
```


Enjoy :)

License: [BSD 3-Clause](LICENSE)


<a href='https://ko-fi.com/N4N09BMZ' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://az743702.vo.msecnd.net/cdn/kofi1.png?v=0' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>
