-- this file is responsible for initializing the DataService and setting up the data template for player data.

local RS = game:GetService("ReplicatedStorage")
local DataService = require(RS.Packages.DataService).server
local DailyRewardServiceServer = require(script.Parent.Services.DailyRewardServiceServer)

local dataTemplate = {
	lastDailyRewardClaim = 0,
	coins = 0,
}

DataService:init({
	template = dataTemplate,
})

DailyRewardServiceServer.init()
