Fxs.Rest.Build().Fetch('https://api.github.com/repos/fxserver-exclusives/fxs-api/releases/latest', function(success, response, headers)
	local str = ''
	if success then
		if not response.prerelease then
			local latest_version = response.name:gsub("v", "")
			local current_version = GetResourceMetadata(GetCurrentResourceName(), "version")
			str = str .. ('\n^5ltst version: ^2%s^5\ncurr version: ^3%s\n'):format(latest_version, current_version)
			if latest_version == current_version then
				str = str .. '\n^2SUCC: everything is up to date...'
			else
				str = str .. '\n^8WARN: your version of the cfx-api-library is not up to date. you can download the latest version from the link below.'
				str = str .. ('\n^3DOWNLOAD: ^5%s'):format(response.html_url)
			end
		else
			str = str .. '\n^3WARN: be aware of the new prerelease update isn\'t needed yet...'
		end
	else
		str = str .. '\n^3WARN: could not verify the version of your resource...'
	end
	str = str .. '\n^2SUCC: resource is up and running...\n\n^9Created by ^8Sm1Ly^9 for servers build with the ^8CitizenFX Framework^9!\n^0'
	print(str)
end)

local Cache = Fxs.Core.Class({}, {
	__call = function(self, name)
		if self[name] == nil then
			self[name] = Fxs.Rest.Build()
		end
		return self[name]
	end
}, false)

-- exporting function

exports('route', function(...)
	local resource = GetInvokingResource() or GetCurrentResourceName()
	Cache(resource).route(...)
end)

exports('param', function(...)
	local resource = GetInvokingResource() or GetCurrentResourceName()
	Cache(resource).param(...)
end)

exports('fetch', function(...)
	local resource = GetInvokingResource() or GetCurrentResourceName()
	Cache(resource).fetch(...)
end)

exports('post', function(...)
	local resource = GetInvokingResource() or GetCurrentResourceName()
	Cache(resource).post(...)
end)


