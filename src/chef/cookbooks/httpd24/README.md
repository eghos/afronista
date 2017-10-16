httpd24 Cookbook
===============
This cookbook makes httpd 2.4 appear on your server.

Requirements
------------
Tested on Amazon linux

Usage
-----
#### httpd24::default
Just include `http24` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[httpd24]"
  ]
}
```

License and Authors
-------------------
Authors: Adam Bidwell
