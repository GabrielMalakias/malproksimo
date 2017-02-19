# Malproksimo
An application to calculate shipping cost based on Dijkstra algorithm

Redis is used as cache to store calculated routes and Sidekiq to recalculate routes when an edge is created or changed, trying to avoid calculate dijkstra when the shipping cost is requested.
This solution has inspirations in CQRS and eventual consistency.

## Dijkstra algorithm
![Dijkstra](https://upload.wikimedia.org/wikipedia/commons/5/57/Dijkstra_Animation.gif)

## Dependencies
* Ruby(2.3.3)
* Hanami(0.9.2)
* Postgres(9.6)
* Redis(3.2)
* Docker-compose version 1.8.1(optional)

### Running server
``` shell
docker-compose up

or bundle exec hanami s && bundle exec sidekiq -e development -r ./config/boot.rb
```

### Running tests

``` shell
docker-compose run web rspec spec

or bundle exec rspec spec
```

### Resources

POST /api/edges

``` json
{"source" : "B", "destination" : "C", "length" : 10}
```

GET /api/cost?origin=A&destination=C&weight=5

### Sidekiq admin

GET /sidekiq
