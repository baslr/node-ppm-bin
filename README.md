node-ppm-bin
============

Portable pixmap Binary to png converter.

<https://en.wikipedia.org/wiki/Netpbm_format>

Supports Magic Number P6. Produced by qemu qmp command:

```
screendump
----------

Save screen into PPM image.

Arguments:

- "filename": file path (json-string)

Example:

-> { "execute": "screendump", "arguments": { "filename": "/tmp/image" } }
<- { "return": {} }
```


usage:

```
ppmbin = require 'ppm-bin'

ppmbin.convert 'image.ppm', 'image.png', (err) ->
  console.log err
```