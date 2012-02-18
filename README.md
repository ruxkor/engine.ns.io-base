
# engine.ns.io

engine.ns.io takes the concept of having different event for different
types of messages (à la socket.io) back to engine.io

It does so by minimally extending the engine.io Socket prototype, adding a
`Socket.send_ns(type,data)` method which will then on the receiving part be
emitted as the chosen event type. 

Sending of 'raw' strings for performance-critical application parts can still
be done by using `Socket.send_raw` and listening on the `'raw'` event.

## Usage

Server:

```coffee
nsio = require 'engine.ns.io'
server = engine.listen 8080

server.on 'connection', (socket) ->
  # send a 'welcome' message, containing greeting and 
  # a list of users
  data =
    greeting: 'hello there!'
    users: ['alice','bob']

  socket.send_ns 'welcome',data
```

Client/Browser: 

*(use `make dist` in `engine.ns.io-client` to build the module for*
*the browser by using `browserbuild`)*

```js
socket = new nsio.Socket({host: 'localhost', port: 8080});

socket.on('welcome',function(data) {
  // contains sent object
  console.log(data);
});
```

## License 

(The MIT License)

Copyright (c) 2012 Andor Goetzendorff &lt;andor@pokermania.de&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
