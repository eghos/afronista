php56 Cookbook
==============
This cookbook makes PHP 5.4 appear on your server.

Usage
-----
#### php56::default
Just include `php56` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php56]"
  ]
}
```

License and Authors
-------------------
Authors:
* Adam Bidwell
