------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigsTest")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function()
	return {
		["test"] = true,
		["Test"] = true,
		["Test Bar"] = true,
		["Test Bar 2"] = true,
		["Test Bar 3"] = true,
		["Test Bar 4"] = true,
		["Testing"] = true,
		["OMG Bear!"] = true,
		["*RAWR*"] = true,
		["Victory!"] = true,
		["Options for testing."] = true,
		["local"] = true,
		["Local test"] = true,
		["Perform a local test of BigWigs."] = true,
		["sync"] = true,
		["Sync test"] = true,
		["Perform a sync test of BigWigs."] = true,
		["Testing Sync"] = true,
	}
end)
L:RegisterTranslations("zhCN", function()
	return {
		["test"] = "测试",
		["Test"] = "测试",
		["Test Bar"] = "测试计时条1",
		["Test Bar 2"] = "测试计时条2",
		["Test Bar 3"] = "测试计时条3",
		["Test Bar 4"] = "测试计时条4",
		["Testing"] = "测试中",
		["OMG Bear!"] = "*警告消息*",
		["*RAWR*"] = "*团队消息*",
		["Victory!"] = "胜利了!",
		["Options for testing."] = "测试设置.",
		["local"] = "本地测试",
		["Local test"] = "本地测试",
		["Perform a local test of BigWigs."] = "进行本地测试",
		["sync"] = "同步测试",
		["Sync test"] = "同步测试",
		["Perform a sync test of BigWigs."] = "进行同步测试",
		["Testing Sync"] = "同步测试中",
	}
end)

----------------------------------
--      Module Declaration      --
----------------------------------

BigWigsTest = BigWigs:NewModule("Test")
BigWigsTest.revision = 20003

BigWigsTest.consoleCmd = L["test"]
BigWigsTest.consoleOptions = {
	type = "group",
	name = L["Test"],
	desc = L["Options for testing."],
	args = {
		[L["local"]] = {
			type = "execute",
			name = L["Local test"],
			desc = L["Perform a local test of BigWigs."],
			func = function()
				BigWigsTest:TriggerEvent("BigWigs_Test")
			end,
		},
		[L["sync"]] = {
			type = "execute",
			name = L["Sync test"],
			desc = L["Perform a sync test of BigWigs."],
			func = function()
				BigWigsTest:TriggerEvent("BigWigs_SyncTest")
			end,
			disabled = function()
				return (not IsRaidLeader() and not IsRaidOfficer())
			end,
		},
	}
}

BigWigsTest.testRunning = false

function BigWigsTest:OnEnable()
	self:RegisterEvent("BigWigs_Test")
	self:RegisterEvent("BigWigs_StopTest")
	self:RegisterEvent("BigWigs_RecvSync")
	self:TriggerEvent("BigWigs_ThrottleSync", "TestSync", 5)
	self:RegisterEvent("BigWigs_SyncTest")
end

function BigWigsTest:BigWigs_SyncTest()
	self:TriggerEvent("BigWigs_SendSync", "TestSync")
end

function BigWigsTest:BigWigs_RecvSync(sync, rest, nick)
	if sync == "TestSync" then
		self:Message(L["Testing Sync"], "Positive")
		self:Bar(L["Testing Sync"], 10, "Spell_Frost_FrostShock", true, "Green", "Blue", "Yellow", "Red")
	elseif sync == "TestNumber" and rest then
		--SendChat(rest)
		rest = tonumber(rest)
		if type(rest) == "number" then
			--SendChat(rest * 2)
		end
	end
end

function BigWigsTest:BigWigs_Test()
	if not self.testRunning then
		self:BigWigs_StartTest()
	else
		self:BigWigs_StopTest()
	end
end

function BigWigsTest:BigWigs_StartTest()
	BigWigs:ToggleActive(true) -- make sure bigwigs active

	self.testRunning = true
	self:Message("注意文本", "Attention", true, "Long")
	self:Message("重要文本", "Important", false, nil, false)
	self:Message("紧急文本", "Urgent", true, nil, false)

	self:Bar(L["Test Bar 4"], 12, "Spell_Nature_ResistNature", true, "black")
	self:Bar(L["Test Bar 3"], 15, "Spell_Nature_ResistNature", true, "red")
	self:Bar(L["Test Bar 2"], 45, "Inv_Hammer_Unique_Sulfuras")
	self:Bar(L["Test Bar"], 55, "Spell_Nature_ResistNature")
	self:WarningSign("Inv_Hammer_Unique_Sulfuras", 20, true, L["Test"])

	self:DelayedMessage(10, L["OMG Bear!"], "Important", true, "Alert")
	self:DelayedMessage(15, L["*RAWR*"], "Urgent", true, "Alarm")

	self:Sync("TestNumber 5")

	BigWigs:Proximity()
end

function BigWigsTest:BigWigs_StopTest()
	BigWigs:RemoveProximity()
    if BigWigsMessages and BigWigsMessages.msgframe then
        BigWigsMessages.msgframe:Clear()
    end					
	self:Disengage()
	self.testRunning = false
end
