Dbutils Cookbook
================
Recipes for dbutils related configuration and installation


Requirements
------------
Tested on Amazon Linux


Attributes
----------
TODO

Usage
-----
#### dbutils::default
Just include `dbutils` in your node's `run_list`:

```json
{
    "name":"my_node",
    "run_list": [
        "recipe[dbutils]"
    ]
}
```

#### dbutils::dump
Include `dbutils::dump` in your node's `run_list`:

```json
{
    "run_list": [
        "recipe[dbutils::dump]"
    ]
}
```

#### dbutils::import
Include `dbutils::import` in your node's `run_list`:

```json
{
    "run_list": [
        "recipe[dbutils::import]"
    ]
}
```

License and Authors
-------------------
Authors:
* Alexandre Chabert
