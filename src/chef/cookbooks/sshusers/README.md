sshusers Cookbook
================
This cookbook adds users to your host, with ssh access through public keys and optionally sudo rights through the sudoers recipe.

Usage
-----
#### sshusers::default
Just include `sshusers` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sshusers]"
  ]
}
```

License and Authors
-------------------
Authors:
* Simon Buxton
