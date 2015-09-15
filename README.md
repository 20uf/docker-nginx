Symfony sandbox
=======

![enter image description here](https://circleci.com/gh/20uf/symfony-sandbox.svg?style=shield&circle-token=:circle-token)
![Status](https://circleci.com/gh/20uf/symfony-sandbox.png?circle-token=66be005260b763277c38022c1ae994488287e8a0)

Build image:
---------------

    docker build -t "20uf/symfony-sandbox" . 

Run
---------------
    docker run -d -p 80:80 20uf/symfony-sandbox

Run console mode
---------------

    docker run -p 80:80 -a stdin -a stdout -i -t 20uf/symfony-sandbox /bin/bash

