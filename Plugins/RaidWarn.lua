assert(BigWigs, "BigWigs not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigsRaidWarn")
local sentWhispers = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["RaidWarning"] = true,

	["raidwarn"] = true,
	["broadcast"] = true,
	["whisper"] = true,
	["showwhispers"] = true,
	["useraidchannel"] = true,

	["Broadcast over RaidWarning"] = true,
	["Broadcast"] = true,
	["Toggle broadcasting over Raidwarning."] = true,

	["Whisper"] = true,
	["Whisper warnings"] = true,
	["Toggle whispering warnings to players."] = true,

	["Show whispers"] = true,
	["Toggle showing whispers sent by BigWigs locally."] = true,

	["Use Raidchannel"] = true,
	["Toggle using the raid channel instead of the raid warning channel for boss messages."] = true,

	["Options for RaidWarning."] = true,
} end )
L:RegisterTranslations("zhCN", function() return {
	["RaidWarning"] = "团队警报",

	["raidwarn"] = "团队警报",
	["broadcast"] = "广播",
	["whisper"] = "密语",
	["showwhispers"] = "显示密语",
	["useraidchannel"] = "使用团队聊天",

	["Broadcast over RaidWarning"] = "通过团队警告频道发送信息",
	["Broadcast"] = "广播",
	["Toggle broadcasting over Raidwarning."] = "通过团队警告频道发送信息",

	["Whisper"] = "密语",
	["Whisper warnings"] = "密语警报",
	["Toggle whispering warnings to players."] = "通过密语向玩家发送信息",

	["Show whispers"] = "显示密语",
	["Toggle showing whispers sent by BigWigs locally."] = "显示由BigWigs本地发送的密语。",

	["Use Raidchannel"] = "使用团队聊天",
	["Toggle using the raid channel instead of the raid warning channel for boss messages."] = "切换是否使用团队聊天来代替团队警告频道来播放Boss的信息",

	["Options for RaidWarning."] = "团队警告设置",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

BigWigsRaidWarn = BigWigs:NewModule(L["RaidWarning"], "AceHook-2.1")
BigWigsRaidWarn.defaultDB = {
	whisper = false,
	broadcast = false,
	useraidchannel = false,
	showwhispers = true,
}
BigWigsRaidWarn.consoleCmd = L["raidwarn"]
BigWigsRaidWarn.consoleOptions = {
	type = "group",
	name = L["RaidWarning"],
	desc = L["Options for RaidWarning."],
	args   = {
		[L["broadcast"]] = {
			type = "toggle",
			name = L["Broadcast"],
			desc = L["Toggle broadcasting over Raidwarning."],
			get = function() return BigWigsRaidWarn.db.profile.broadcast end,
			set = function(v) BigWigsRaidWarn.db.profile.broadcast = v end,
		},
		[L["whisper"]] = {
			type = "toggle",
			name = L["Whisper"],
			desc = L["Toggle whispering warnings to players."],
			get = function() return BigWigsRaidWarn.db.profile.whisper end,
			set = function(v) BigWigsRaidWarn.db.profile.whisper = v end,
		},
		[L["showwhispers"]] = {
			type = "toggle",
			name = L["Show whispers"],
			desc = L["Toggle showing whispers sent by BigWigs locally."],
			get = function() return BigWigsRaidWarn.db.profile.showwhispers end,
			set = function(v) BigWigsRaidWarn.db.profile.showwhispers = v end,
		},
		[L["useraidchannel"]] = {
			type = "toggle",
			name = L["Use Raidchannel"],
			desc = L["Toggle using the raid channel instead of the raid warning channel for boss messages."],
			get = function() return BigWigsRaidWarn.db.profile.useraidchannel end,
			set = function(v) BigWigsRaidWarn.db.profile.useraidchannel = v end,
		},
	}
}

------------------------------
--      Initialization      --
------------------------------

function BigWigsRaidWarn:OnEnable()
	self:RegisterEvent("BigWigs_Message")
	self:RegisterEvent("BigWigs_SendTell")

	sentWhispers = {}

	if ChatFrame_MessageEventHandler ~= nil and type(ChatFrame_MessageEventHandler) == "function" then
		self:Hook("ChatFrame_MessageEventHandler", "WhisperHandler", true)
	else
		self:Hook("ChatFrame_OnEvent", "WhisperHandler", true)
	end
end

function BigWigsRaidWarn:BigWigs_Message(msg, color, noraidsay)
	if not self.db.profile.broadcast or not msg or noraidsay or ( not IsRaidLeader() and not IsRaidOfficer() ) then
		return
	end
	if self.db.profile.useraidchannel then
		SendChatMessage("*** "..msg.." ***", "RAID")
	else
		SendChatMessage("*** "..msg.." ***", "RAID_WARNING")
	end
end

function BigWigsRaidWarn:BigWigs_SendTell(player, msg)
	if not self.db.profile.whisper or not player or not msg or string.find(player,"%s") or not UnitIsInRaidByName(player) or ( not IsRaidLeader() and not IsRaidOfficer() ) then return end
	sentWhispers[msg] = true
	SendChatMessage(msg, "WHISPER", nil, player)
end

function BigWigsRaidWarn:WhisperHandler(event)
	if not self.db.profile.showwhispers and sentWhispers[arg1] then
		self:Debug("Suppressing self-sent whisper.", event, arg1)
		return
	end

	if type(self.hooks["ChatFrame_OnEvent"]) == "function" then
		self.hooks["ChatFrame_OnEvent"](event)
	else
		return self.hooks["ChatFrame_MessageEventHandler"](event)
	end
end

function UnitIsPetByName(msg)
	local j = GetNumRaidMembers()
	local k = GetNumPartyMembers()
	if j == 0 then
		if k == 0 then
			if UnitName("pet") == msg then
				if UnitPlayerControlled("pet") then
					if UnitIsPlayer("pet") then
						return false
					end
					return true
				end
				return true
			end
			return false
		else
			if UnitName("pet") == msg then
				if UnitPlayerControlled("pet") then
					if UnitIsPlayer("pet") then
						return false
					end
					return true
				end
				return true
			end
			for i =1, k do
				local partypetno = string.format("partypet%s", i)
				if UnitName(partypetno) == msg then
					if UnitPlayerControlled(partypetno) then
						if UnitIsPlayer(partypetno) then
							return false
						end
						return true
					end
					return true
				end
			end
			return false
		end
	else
		for i =1, j do
			local raidpetno = string.format("raidpet%s", i)
			if UnitName(raidpetno) == msg then
				if UnitPlayerControlled(raidpetno) then
					if UnitIsPlayer(raidpetno) then
						return false
					end
					return true
				end
				return true
			end
		end
		return false
	end
end

function UnitIsInRaidByName(name)
	local j = GetNumRaidMembers()
	local k = GetNumPartyMembers()
	if j == 0 then
		if k == 0 then
			if UnitName("player") == name then
				return true
			end
			return false
		else
			if UnitName("player") == name then
				return true
			end
			for i =1, k do
				local partyno = string.format("party%s", i)
				if UnitName(partyno) == name then
					return true
				end
			end
			return false
		end
	else
		for i =1, j do
			local raidno = string.format("raid%s", i)
			if UnitName(raidno) == name then
				return true
			end
		end
		return false
	end
end
