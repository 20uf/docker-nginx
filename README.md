Build image:

    docker build -t "20uf/sandbox-symfony" . 


    docker run -a -p 80:80 stdin -a stdout -i -t 20uf/sandbox-symfony /bin/bash


    docker run -d -p 80:80 20uf/sandbox-symfony nginx




