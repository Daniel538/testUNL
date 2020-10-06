# README

For launch project

    git clone https://github.com/Daniel538/testUNL.git -b develop
    
Then build the image:  

    docker-compose build 
    
Up containers:
    
    docker-compose up
    
Make migrations: 

    docker exec -it $YOUR_WEB_CONTAINER bin/rails db:migrate

Seed fake data:

    docker exec -it $YOUR_WEB_CONTAINER rake db:seed
    
**Admin user**

* Login: ***dane105@mail.ru***

* Password: ***123123***
    
**Standard user**

* Login: ***test105@mail.ru***

* Password: ***123123***