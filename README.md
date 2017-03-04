# flvk 1.0

[![Latest release: 1.0](https://img.shields.io/badge/release-flvk--1.0-brightgreen.svg?style=flat)](https://github.com/izarif/flvk/releases/latest) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) [![Luarocks page: https://luarocks.org/modules/izarif/flvk](https://img.shields.io/badge/luarocks-1.0--0-brightgreen.svg)](https://luarocks.org/modules/iZarif/flvk) [![Gitter chat: https://gitter.im/flvk-chat/Lobby](https://badges.gitter.im/flvk-chat/Lobby.svg)](https://gitter.im/flvk-chat/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

![flvk logo](flvk%20logo.png)

[VK.com](https://vk.com/) Lua API wrapper

Functional style fork of [lvk](https://github.com/last-khajiit/lvk).

## Prerequisites

* [Lua](https://www.lua.org/) >= 5.1 or [LuaJIT](http://luajit.org/) >= 2
* [LuaRocks](https://luarocks.org/)

## Install

```
luarocks install flvk
```

### Usage

Add flvk to your code:
```lua
local flvk = require("flvk")
```

For example, wall.post method call to create a record with the text "Hello!":
```lua
local access_token = "ee272c9214611c082d397def7da4368d2baa5d1805aa3dcbb989a2e52bf0cec8c69da547b5d54b524da56"
local api_version = 5.69
local post = flvk.call("wall.post", {message = "Hello!"}, access_token, api_version)
local post_table = flvk.to_table(post)
print(post_table.response.post_id)
```

## Documentation

Full documentation available at https://vk.com/dev/methods

## Additional functions

### `get_version`

This function gets this library version.

#### Parameters



#### Result

Returns the version `number` of this library.

### `to_json`

This function converts table to json.

#### Parameters

`_table`&emsp;`table`&emsp;`required parameter`

#### Result

Returns a `string` containing the JSON representation.

### `to_string`

This function converts json to table.

#### Parameters

`json`&emsp;`string`&emsp;`required parameter`

#### Result

Returns a `table` containing the JSON representation.

## Author

Copyright © 2017 Aydar (iZarif) Zarifullin \<aydar.js@gmail.com\>

## License

This work is free. You can redistribute it and/or modify it under the
terms of the MIT license. See the [license](LICENSE) file for more details.