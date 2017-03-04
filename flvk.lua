local flvk = {}
flvk._VERSION = 1.0

local https = require("ssl.https")
local ltn12 = require("ltn12")
local dkjson = require("dkjson")

function flvk.get_version()
  return flvk._VERSION
end

function flvk.to_json(_table)
  assert(type(_table) == "table", "bad argument #1 to 'to_json' (table expected, got " .. type(_table) .. ")")

  local encoded_json = dkjson.encode(_table)

  return encoded_json
end

function flvk.to_table(json)
  assert(type(json) == "string", "bad argument #1 to 'to_table' (string expected, got " .. type(json) .. ")")

  local decoded_json = dkjson.decode(json, 1, nil)

  return decoded_json
end

local function concat_pair_table(_table, separator)
  local result_table = {}

  for key, value in pairs(_table) do
    table.insert(result_table, key .. "=" .. value)
  end

  return table.concat(result_table, separator)
end

function flvk.call(method_name, parameters, access_token, api_version)
  assert(type(method_name) == "string", "bad argument #1 to 'call' (string expected, got " .. type(method_name) .. ")")
  assert(type(parameters) == "table", "bad argument #2 to 'call' (table expected, got " .. type(parameters) .. ")")
  assert(type(access_token) == "string", "bad argument #3 to 'call' (string expected, got " .. type(access_token) .. ")")
  assert(type(api_version) == "number", "bad argument #4 to 'call' (number expected, got " .. type(api_version) .. ")")

  local parameters_string = concat_pair_table(parameters, "&")
  local post_data = parameters_string .. "&access_token=" .. access_token .. "&v=" .. api_version
  local response = {}

  https.request{
    url = "https://api.vk.com/method/" .. method_name,
    method = "POST",
    headers =
      {
        ["Content-Type"] = "application/x-www-form-urlencoded",
        ["Content-Length"] = #post_data
      },
      source = ltn12.source.string(post_data),
      sink = ltn12.sink.table(response)
  }

  local response_string = table.concat(response)

  return response_string
end

return flvk