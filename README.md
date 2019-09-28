# flvk 1.1

[![Latest release: 1.1](https://img.shields.io/badge/release-flvk--1.1-brightgreen.svg?style=flat)](https://github.com/izarif/flvk/releases/latest) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) [![Luarocks page: https://luarocks.org/modules/izarif/flvk](https://img.shields.io/badge/luarocks-1.1--0-brightgreen.svg)](https://luarocks.org/modules/iZarif/flvk) [![Gitter chat: https://gitter.im/flvk-chat/Lobby](https://badges.gitter.im/flvk-chat/Lobby.svg)](https://gitter.im/flvk-chat/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

![flvk logo](flvk%20logo.png)

Lua VK API library / Lua Vkontakte SDK

Functional style fork of [lvk](https://github.com/last-khajiit/lvk).

## Prerequisites

* Lua >= 5.1 or LuaJIT >= 2
* LuaRocks

## Install

```
luarocks install flvk
```

### Usage

Add flvk to your code:
```lua
local flvk = require("flvk")
```

For example, wall.post method call to create a post with the text "Hello!":
```lua

--[[
First call the flvk.make_account function passing it the username and password
--]]

local account = flvk.make_account("+79533359544", "4|sY4!pKiO3#Xt")

--[[
You can also set

account.api_version (default "5.101")
account.client_id (default "2274003")
account.client_secret (default "hHbZxrka2uZ6jB1inYsH")

Then you need to authorize using the flvk.auth function
--]]

flvk.auth(account)

--[[
And if you don't want to call flvk.auth you can set the access_token directly

account.access_token

After that you can call any VK API method using the flvk.call function
Where the first parameter is the name of the method and the second parameters of the corresponding method
--]]

if account.access_token then
   local post = flvk.call(account, "wall.post", {message = "Hello!"})

   print(post.response.post_id)
end

--[[
Some parameter values will be converted:

Numbers
3.14 -> "3.14"

Booleans
true -> "1"
false -> "0"

Tables
{"one", "two", "three"} -> "one,two,three"
--]]

```

## Documentation

VK API documentation available at https://vk.com/dev/methods

## Author

Copyright © 2017-2019 Aydar (iZarif) Zarifullin \<aydar.js@gmail.com\>

## License

This work is free. You can redistribute it and/or modify it under the
terms of the MIT license. See the [license](LICENSE) file for more details.
