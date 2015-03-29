# metrics_spy

**Metrics Spy
**

Metrics spy is a simple sinatra server. On starting the server, it takes stage on http://localhost:9191 and tracks all the GET requests to the staged port.

On calling http://localhost:9191/getmetrics , it provides the captured requests with query strings as hash. After returning the stored metrics, it clears the store and starts listening fresh.

The server is under development and more features will be added soon!

**Installation**

gem install metrics_spy

**Usage**

The gem comes with a binary metrics_spy_service. One can use this to start and stop the server.
