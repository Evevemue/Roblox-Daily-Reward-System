-- this service handles the daily reward system for players

local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataService = require(RS.Packages.DataService).server

local DailyRewardServiceServer = {}

local DAY_IN_SECONDS = 24 * 60 * 60
local DAILY_REWARD = 100

-- function to check if the player can claim the daily reward
local function canClaimDailyReward(plr: Player): boolean
	local lastClaim = DataService:get(plr, "lastDailyRewardClaim")
	if lastClaim == 0 or lastClaim == nil then
		return true
	end

	if lastClaim + DAY_IN_SECONDS < os.time() then
		return true
	end

	return false
end

-- function for claiming the daily reward
local function claimDailyReward(plr: Player): boolean
	if not canClaimDailyReward(plr) then
		return false
	end

	DataService:set(plr, "lastDailyRewardClaim", os.time())
	DataService:set(plr, "coins", DataService:get(plr, "coins") + DAILY_REWARD)
	return true
end

-- initialize the service
function DailyRewardServiceServer.init(): ()
	Players.PlayerAdded:Connect(function(plr: Player): ()
		DataService:waitForData(plr)
		claimDailyReward(plr)
		print(DataService:get(plr, "coins"), DataService:get(plr, "lastDailyRewardClaim"))
	end)
end

return table.freeze(DailyRewardServiceServer)
