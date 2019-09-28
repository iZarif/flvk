local flvk = {}

local https = require("ssl.https")
local ltn12 = require("ltn12")
local dkjson = require("dkjson")

local function to_vkvalues(table1)
   local result = {}

   for key, value in pairs(table1) do
      if type(value) == "number" then
	 value = tostring(value)
      elseif type(value) == "boolean" then
	 value = value and "1" or "0"
      elseif type(value) == "table" then
	 value = table.concat(value, ",")
      end

      result[key] = value
   end

   return result
end

local function build_query_string(parameters)
   local parameters_strings = {}

   for key, value in pairs(parameters) do
      table.insert(parameters_strings, key .. "=" .. value)
   end

   return table.concat(parameters_strings, "&")
end

local function request(url, parameters)
   local vkvalues_parameters = to_vkvalues(parameters)
   local query_string = build_query_string(vkvalues_parameters)
   local response = {}

   https.request{
      url = url,
      method = "POST",
      headers =
	 {
            ["Content-Type"] = "application/x-www-form-urlencoded",
            ["Content-Length"] = #query_string
	 },
      source = ltn12.source.string(query_string),
      sink = ltn12.sink.table(response)
   }

   local response_string = table.concat(response)

   return dkjson.decode(response_string, 1, nil)
end

local function merge_tables(table1, table2)
   local result = {}

   for key, value in pairs(table1) do
      result[key] = value
   end

   for key, value in pairs(table2) do
      result[key] = value
   end

   return result
end

function flvk.make_account(username, password)
   return {username = username, password = password, client_id = "2274003", client_secret = "hHbZxrka2uZ6jB1inYsH",
	   api_version = "5.101"}
end

function flvk.auth(account, parameters)
   local parameters = parameters or {}

   local required_parameters = {grant_type = "password", client_id = account.client_id,
				client_secret = account.client_secret, username = account.username, password = account.password}
   local all_parameters = merge_tables(required_parameters, parameters)

   local response = request("https://oauth.vk.com/token", all_parameters)

   if response.access_token then
      account.access_token = response.access_token
      account.expires_in = response.expires_in
      account.user_id = response.user_id
   end

   return response
end


function flvk.call(account, method_name, parameters)
   local required_parameters = {access_token = account.access_token, v = account.api_version}
   local all_parameters = merge_tables(required_parameters, parameters)

   return request("https://api.vk.com/method/" .. method_name, all_parameters)
end

return flvk
