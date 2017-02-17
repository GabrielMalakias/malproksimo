# malproksimo
An application to calculate shipping cost based on Dijkstra algorithm

### Resources

POST /api/edges

``` json
{"source" : "B", "destination" : "C", "length" : 10}
```

GET /api/cost?origin=A&destination=C&weight=5
