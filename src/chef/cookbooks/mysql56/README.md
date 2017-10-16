mysql56 Cookbook
==============
This cookbook makes mySQL 5.6 client appear on your server.

Usage
-----
#### mysql56::client
Just include `mysql56::client` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mysql56::client]"
  ]
}
```

License and Authors
-------------------
Authors:
* Alexandre Chabert
