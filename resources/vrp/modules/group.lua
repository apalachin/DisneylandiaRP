local cfg = module("cfg/groups")
local groups = cfg.groups

function vRP.getGroupTitle(group) -- ok
	local g = groups[group]
	if g and g._config and g._config.title then
		return g._config.title
	end
	return group
end

function vRP.getUserGroups(user_id) -- ok
	local groups = json.decode(vRP.query("getUserGroups", { id = user_id })[1].groups)
	return groups
end

function vRP.removeUserGroup(user_id,group)
	local user_groups = vRP.getUserGroups(user_id)
	local groupdef = groups[group]
	local gtype
	
	if groupdef then
		if groupdef._config and groupdef._config.gtype ~= nil then
			gtype = groupdef._config.gtype 
		end

		for k,_ in pairs(user_groups) do
			if k == group then
				user_groups[group] = nil
				vRP.execute("updateUserGroups", { groups = json.encode(user_groups), id = user_id })

				TriggerEvent("vRP:playerLeaveGroup",user_id,group,gtype)
			end
		end

	end
end

function vRP.addUserGroup(user_id,group)
	if not vRP.hasGroup(user_id,group) then
		local user_groups = vRP.getUserGroups(user_id)
		local ngroup = groups[group]
		local gtype
		if ngroup then
			-- Remover do mesmo GTYPE
			if ngroup._config and ngroup._config.gtype ~= nil then
				local _user_groups = {}
				for k,v in pairs(user_groups) do
					_user_groups[k] = v
				end

				for k,v in pairs(_user_groups) do
					local kgroup = groups[k]
					if kgroup and kgroup._config and ngroup._config and kgroup._config.gtype == ngroup._config.gtype then
						user_groups[k] = nil
						vRP.removeUserGroup(user_id,k)
					end
				end
				
				gtype = ngroup._config.gtype 

				user_groups[group] = true
				vRP.execute("updateUserGroups", { groups = json.encode(user_groups), id = user_id })
				
				TriggerEvent("vRP:playerJoinGroup",user_id,group,gtype)
			end
		end
	end
end

function vRP.getUserGroupByType(user_id,gtype) -- ok
	local user_groups = vRP.getUserGroups(user_id)
	for k,v in pairs(user_groups) do
		local kgroup = groups[k]
		if kgroup then
			if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == gtype then
				return kgroup._config.title
			end
		end
	end
	return ""
end

function vRP.getUsersByPermission(perm) -- ok
	local users = {}
	for k,v in pairs(vRP.rusers) do
		if vRP.hasPermission(tonumber(k),perm) then
			table.insert(users,tonumber(k))
		end
	end
	return users
end

function vRP.hasGroup(user_id,group) -- ok
	local user_groups = vRP.getUserGroups(user_id)
	return (user_groups[group] ~= nil)
end

function vRP.hasPermission(user_id,perm) -- ok
	local user_groups = vRP.getUserGroups(user_id)

	for k,_ in pairs(user_groups) do
		if k then
			if groups[k] then
				for l,w in pairs(groups[k]) do
					if l ~= "_config" and w == perm then
						return true
					end
				end
			end
		end
	end
	return false
end

function vRP.hasPermissions(user_id, perms) -- ok
	for k,v in pairs(perms) do
		if not vRP.hasPermission(user_id, v) then
			return false
		end
	end
	return true
end

-- DLGames AntiCheat

-- function getUsersByPermission(perm)
-- 	local users = {}
-- 	for k,v in pairs(vRP.rusers) do
-- 		if vRP.hasPermission(tonumber(k),perm) then
-- 			table.insert(users,tonumber(k))
-- 		end
-- 	end
-- 	return users
-- end
-- exports("getUsersByPermission",getUsersByPermission)]
--exports("getUsersByPermission",["vRP.getUsersByPermission"])