    docker build -t droda .
    docker run droda  -p 3000:3000
    docker build -t roda . && docker run -p 3000:3000 roda 
    docker run  -ti droda bash
test
# https://www.upcitemdb.com/upc/9780321552686
# localhost:3000/9780321552686aklsdfjalksdocker volume rm $(docker volume ls -q)sldkfjlajlf


docker-compose down
docker rm -f $(docker ps -a -q)
docker volume rm $(docker volume ls -q)


https://medium.com/matic-insurance/communication-layer-design-for-ruby-microservices-98b388174aef

RabbitMQ
https://www.rabbitmq.com/tutorials/tutorial-one-ruby.html
https://www.cloudbees.com/blog/writing-microservice-in-ruby


**Lightweight multi-threaded Ruby application
https://blog.klimenko.site/ruby/2018/10/23/puma-applications.html