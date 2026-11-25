local module, L = BigWigs:ModuleDeclaration("Dark Reaver of Karazhan", "Deadwind Pass")

module.revision = 30052
module.enabletrigger = module.translatedName
module.toggleoptions = {"forlornspirit", "lurkingshadow", -1, "enrage", -1, "deterrence", "nimblereflexes", -1, "unbalancingstrike", "piercearmor", "bosskill"}
module.zonename = {
	AceLibrary("AceLocale-2.2"):new("BigWigs")["Outdoor Raid Bosses Zone"],
	AceLibrary("Babble-Zone-2.2")["Deadwind Pass"],
}

L:RegisterTranslations("enUS", function() return {
	cmd = "DarkReaverOfKarazhan",

	forlornspirit_cmd = "forlornspirit",
	forlornspirit_name = "Forlorn Spirit adds Alert",
	forlornspirit_desc = "Warn for Forlorn Spirit adds",

	lurkingshadow_cmd = "lurkingshadow",
	lurkingshadow_name = "Lurking Shadow adds Alert",
	lurkingshadow_desc = "Warn for Lurking Shadow adds",

	enrage_cmd = "enrage",
	enrage_name = "Enrage Alert",
	enrage_desc = "Warns for Enrage",

	deterrence_cmd = "deterrence",
	deterrence_name = "Deterrence Alert",
	deterrence_desc = "Warns for Deterrence",

	nimblereflexes_cmd = "nimblereflexes",
	nimblereflexes_name = "Nimble Reflexes Alert",
	nimblereflexes_desc = "Warns for Nimble Reflexes",

	unbalancingstrike_cmd = "unbalancingstrike",
	unbalancingstrike_name = "Unbalancing Strike Alert",
	unbalancingstrike_desc = "Warns for Unbalancing Strike",

	piercearmor_cmd = "piercearmor",
	piercearmor_name = "Pierce Armor Alert",
	piercearmor_desc = "Warns for Pierce Armor",

	trigger_engage = "You desecrate the Master's lands with your filthy footsteps!",--CHAT_MSG_MONSTER_YELL

	trigger_forlornSpiritSpawn = "Spirits, rise, and drive back this rabble!",--CHAT_MSG_MONSTER_YELL
	trigger_forlornSpiritSpawn2 = "Rise, spirits. Defend the Master's lands!",--CHAT_MSG_MONSTER_YELL
	bar_forlornSpiritSpawnCd = "Forlorn Spirit CD",
	bar_forlornSpiritSpawnSoon = "Calling Forlorn Spirit",
	msg_forlornSpiritSpawn = "Forlorn Spirit Spawned!",

	trigger_lurkingShadowSpawn = "A (.+) shadow appears next to (.+)...",--CHAT_MSG_MONSTER_EMOTE
	bar_lurkingShadowSpawn = "Lurking Shadow",

	msg_lurkingShadowSpawn = " Lurking Shadow!",

	trigger_enrage = "Dark Reaver of Karazhan gains Furious Anger.",--CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS

	trigger_deterrence = "Dark Reaver of Karazhan gains Deterrence.",--CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS
	trigger_deterrenceFade = "Deterrence fades from Dark Reaver of Karazhan.",--CHAT_MSG_SPELL_AURA_GONE_OTHER
	bar_deterrence = "Deterrence 25% Dodge/Parry",

	trigger_nimbleReflexes = "Dark Reaver of Karazhan gains Nimble Reflexes.",--CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS
	trigger_nimbleReflexesFade = "Nimble Reflexes fades from Dark Reaver of Karazhan.",--CHAT_MSG_SPELL_AURA_GONE_OTHER
	bar_nimbleReflexes = "Reflexes 75% Parry",

	trigger_unbalancingStrike = "(.+) is afflicted by Unbalancing Strike.",--CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE // CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE
	trigger_unbalancingStrikeYou = "You are afflicted by Unbalancing Strike.",--CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
	trigger_unbalancingStrikeFade = "Unbalancing Strike fades from (.+).",--CHAT_MSG_SPELL_AURA_GONE_SELF // CHAT_MSG_SPELL_AURA_GONE_PARTY // CHAT_MSG_SPELL_AURA_GONE_OTHER
	bar_unbalancingStrike = " Unbalancing",

	trigger_pierceArmor = "(.+) is afflicted by Pierce Armor.",--CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE // CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE
	trigger_pierceArmorYou = "You are afflicted by Pierce Armor.",--CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
	trigger_pierceArmorFade = "Pierce Armor fades from (.+).",--CHAT_MSG_SPELL_AURA_GONE_OTHER
	bar_pierceArmor = " Pierce Armor",

    you = "you",
} end )


L:RegisterTranslations("zhCN", function() return {
    cmd = "卡拉赞黑暗掠夺者",

    forlornspirit_cmd = "弃灵",
    forlornspirit_name = "弃灵",
    forlornspirit_desc = "弃灵增援时进行警告",

    lurkingshadow_cmd = "潜伏暗影",
    lurkingshadow_name = "潜伏暗影",
    lurkingshadow_desc = "生成一个潜伏之影,只能指定职业造成伤害.",

    enrage_cmd = "狂暴怒火",
    enrage_name = "狂暴怒火",
    enrage_desc = "对敌人造成的物理伤害提高15点.攻击速度提高4%.",

    deterrence_cmd = "威慑",
    deterrence_name = "威慑",
    deterrence_desc = "威慑出现时进行警告",

    nimblereflexes_cmd = "迅捷反射",
    nimblereflexes_name = "迅捷反射",
    nimblereflexes_desc = "使施法者的招架几率提高50%/60%/70%,持续8秒.",

    unbalancingstrike_cmd = "重压打击",
    unbalancingstrike_name = "重压打击",
    unbalancingstrike_desc = "对敌人造成350%的武器伤害,并使其失去平衡,防御值降低100点,持续6秒.",

    piercearmor_cmd = "刺穿护甲",
    piercearmor_name = "刺穿护甲",
    piercearmor_desc = "使敌人的护甲降低50%/75%,持续20秒.",

	--YELL触发不要进行trigger汉化
    trigger_engage = "You desecrate the Master's lands with your filthy footsteps!",--CHAT_MSG_MONSTER_YELL

    --YELL触发不要进行trigger汉化
    trigger_forlornSpiritSpawn = "Spirits, rise, and drive back this rabble!",--CHAT_MSG_MONSTER_YELL
    trigger_forlornSpiritSpawn2 = "Rise, spirits. Defend the Master's lands!",--CHAT_MSG_MONSTER_YELL
    bar_forlornSpiritSpawnCd = "弃灵冷却",
	bar_forlornSpiritSpawnSoon = "召唤弃灵",
    msg_forlornSpiritSpawn = "弃灵出现",

    --EMOTE触发不要进行trigger汉化
    trigger_lurkingShadowSpawn = "A (.+) shadow appears next to (.+)...",--CHAT_MSG_MONSTER_EMOTE
    bar_lurkingShadowSpawn = "潜伏暗影",
    msg_lurkingShadowSpawn = " 被暗影指名",

    trigger_enrage = "卡拉赞黑暗掠夺者获得了狂暴怒火的效果。",--CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS

    trigger_deterrence = "卡拉赞黑暗掠夺者获得了威慑的效果。",--CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS
    trigger_deterrenceFade = "威慑效果从卡拉赞黑暗掠夺者身上消失。",--CHAT_MSG_SPELL_AURA_GONE_OTHER
    bar_deterrence = "威慑(闪避/招架+25%)",

    trigger_nimbleReflexes = "卡拉赞黑暗掠夺者获得了迅捷反射的效果。",--CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS
    trigger_nimbleReflexesFade = "迅捷反射效果从卡拉赞黑暗掠夺者身上消失。",--CHAT_MSG_SPELL_AURA_GONE_OTHER
    bar_nimbleReflexes = "迅捷反射(招架+75%)",

    trigger_unbalancingStrike = "(.+)受到了重压打击效果的影响。",--CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE // CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE
    trigger_unbalancingStrikeYou = "你受到了重压打击效果的影响。",--CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
    trigger_unbalancingStrikeFade = "重压打击效果从(.+)身上消失了。",--CHAT_MSG_SPELL_AURA_GONE_SELF // CHAT_MSG_SPELL_AURA_GONE_PARTY // CHAT_MSG_SPELL_AURA_GONE_OTHER
    bar_unbalancingStrike = "(重压打击)",

    trigger_pierceArmor = "(.+)受到了刺穿护甲效果的影响。",--CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE // CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE
    trigger_pierceArmorYou = "你受到了刺穿护甲效果的影响。",--CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
    trigger_pierceArmorFade = "刺穿护甲效果从(.+)身上消失了。",--CHAT_MSG_SPELL_AURA_GONE_OTHER
    bar_pierceArmor = "(护甲降低75%)",

    you = "你",
} end )
local timer = {
	--forlornSpiritSpawnCd = 22,
	lurkingShadowSpawn = 10,
	deterrence = 10,
	nimbleReflexes = 8,
	unbalancingStrike = 6,
	pierceArmor = 20,
}
local icon = {
	forlornSpiritSpawnCd = "spell_shadow_burningspirit",
	forlornSpiritSpawnSoon = "spell_shadow_burningspirit",
	lurkingShadowSpawn = "ability_creature_poison_05",
	enrage = "Spell_Shadow_UnholyFrenzy",
	deterrence = "ability_whirlwind",
	nimbleReflexes = "ability_meleedamage",
	unbalancingStrike = "ability_warrior_decisivestrike",
	pierceArmor = "spell_shadow_vampiricaura",
}
local color = {
	forlornSpiritSpawnCd = "Black",
	forlornSpiritSpawnSoon = "Red",
	lurkingShadowSpawn = "White",
	deterrence = "Orange",
	nimbleReflexes = "Green",
	unbalancingStrike = "Red",
	pierceArmor = "Blue",
}
local syncName = {
	forlornSpiritSpawn = "DrkForlornSpiritSpawn"..module.revision,
	lurkingShadowSpawn = "DrkLurkingShadowSpawn"..module.revision,
	enrage = "DrkEnrage"..module.revision,
	deterrence = "DrkDeterrence"..module.revision,
	deterrenceFade = "DrkDeterrenceFade"..module.revision,
	nimbleReflexes = "DrkNimbleReflexes"..module.revision,
	nimbleReflexesFade = "DrkNimbleReflexesFade"..module.revision,
	unbalancingStrike = "DrkUnbalancingStrike"..module.revision,
	unbalancingStrikeFade = "DrkUnbalancingStrikeFade"..module.revision,
	pierceArmor = "DrkPierceArmor"..module.revision,
	pierceArmorFade = "DrkPierceArmorFade"..module.revision,
}

local forlornCount = 0

function module:OnEnable()
	self:RegisterEvent("CHAT_MSG_SAY", "Event")--Debug

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")--trigger_engage, trigger_addsSpawn
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")--trigger_lurkingShadowSpawn
	
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", "Event")--trigger_enrage, trigger_deterrence, trigger_nimbleReflexes
	
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "Event")--trigger_unbalancingStrikeYou, trigger_pierceArmorYou
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "Event")--trigger_unbalancingStrike, trigger_pierceArmor
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "Event")--trigger_unbalancingStrike, trigger_pierceArmor
	
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF", "Event")-- trigger_unbalancingStrikeFade, trigger_pierceArmorFade
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_PARTY", "Event")--trigger_unbalancingStrikeFade, trigger_pierceArmorFade
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER", "Event")--trigger_deterrenceFade, trigger_nimbleReflexesFade, trigger_unbalancingStrikeFade, trigger_pierceArmorFade
	
	self:ThrottleSync(10, syncName.forlornSpiritSpawn)
	self:ThrottleSync(1, syncName.lurkingShadowSpawn)
	self:ThrottleSync(3, syncName.enrage)
	self:ThrottleSync(3, syncName.deterrence)
	self:ThrottleSync(3, syncName.deterrenceFade)
	self:ThrottleSync(3, syncName.nimbleReflexes)
	self:ThrottleSync(3, syncName.nimbleReflexesFade)
	self:ThrottleSync(3, syncName.unbalancingStrike)
	self:ThrottleSync(3, syncName.unbalancingStrikeFade)
	self:ThrottleSync(3, syncName.pierceArmor)
	self:ThrottleSync(3, syncName.pierceArmorFade)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
	if self.db.profile.forlornspirit then
		forlornCount = 0
		self:Bar(L["bar_forlornSpiritSpawnCd"], 20, icon.forlornSpiritSpawnCd, true, color.forlornSpiritSpawnCd)
	end
end

function module:OnDisengage()
end

function module:CHAT_MSG_MONSTER_YELL(msg, sender)
	if msg == L["trigger_engage"] then
		module:SendEngageSync()
	elseif msg == L["trigger_forlornSpiritSpawn"] or msg == L["trigger_forlornSpiritSpawn2"] then
		self:Sync(syncName.forlornSpiritSpawn)
	end
end

function module:CHAT_MSG_MONSTER_EMOTE(msg, sender)
	if string.find(msg, L["trigger_lurkingShadowSpawn"]) then
		local _,_, lurkingClass, lurkingPlayer = string.find(msg, L["trigger_lurkingShadowSpawn"])
		self:Sync(syncName.lurkingShadowSpawn .. " " .. lurkingClass)
	end
end

function module:Event(msg)
	if msg == "test" then
		module:SendEngageSync()
	elseif msg == L["trigger_forlornSpiritSpawn"] or msg == L["trigger_forlornSpiritSpawn2"] then
		self:Sync(syncName.forlornSpiritSpawn)
	end

	if msg == L["trigger_enrage"] then
		self:Sync(syncName.enrage)
	
	elseif string.find(msg, L["trigger_deterrence"]) then
		self:Sync(syncName.deterrence)
	elseif string.find(msg, L["trigger_deterrenceFade"]) then
		self:Sync(syncName.deterrenceFade)
		
	elseif string.find(msg, L["trigger_nimbleReflexes"]) then
		self:Sync(syncName.nimbleReflexes)
	elseif string.find(msg, L["trigger_nimbleReflexesFade"]) then
		self:Sync(syncName.nimbleReflexesFade)
		
	elseif string.find(msg, L["trigger_unbalancingStrike"]) then
		local _,_, unbalTarget, _ = string.find(msg, L["trigger_unbalancingStrike"])
		self:Sync(syncName.unbalancingStrike .. " " .. unbalTarget)
	elseif string.find(msg, L["trigger_unbalancingStrikeYou"]) then
		self:Sync(syncName.unbalancingStrike .. " " .. UnitName("Player"))
	elseif string.find(msg, L["trigger_unbalancingStrikeFade"]) then
		local _,_, unbalFadeTarget, _ = string.find(msg, L["trigger_unbalancingStrikeFade"])
		if unbalFadeTarget == L["you"] then unbalFadeTarget = UnitName("Player") end
		self:Sync(syncName.unbalancingStrikeFade .. " " .. unbalFadeTarget)

	elseif string.find(msg, L["trigger_pierceArmor"]) then
		local _,_, pierceTarget, _ = string.find(msg, L["trigger_pierceArmor"])
		self:Sync(syncName.pierceArmor .. " " .. pierceTarget)
	elseif string.find(msg, L["trigger_pierceArmorYou"]) then
		self:Sync(syncName.pierceArmor .. " " .. UnitName("Player"))
	elseif string.find(msg, L["trigger_pierceArmorFade"]) then
		local _,_, pierceFadeTarget, _ = string.find(msg, L["trigger_pierceArmorFade"])
		if pierceFadeTarget == L["you"] then pierceFadeTarget = UnitName("Player") end
		self:Sync(syncName.pierceArmorFade .. " " .. pierceFadeTarget)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.forlornSpiritSpawn and self.db.profile.forlornspirit then
		self:ForlornSpiritSpawn()
	elseif sync == syncName.lurkingShadowSpawn and rest and self.db.profile.lurkingshadow then
		self:LurkingShadowSpawn(rest)
	elseif sync == syncName.enrage and self.db.profile.enrage then
		self:Enrage()
	elseif sync == syncName.deterrence and self.db.profile.deterrence then
		self:Deterrence()
	elseif sync == syncName.deterrenceFade and self.db.profile.deterrence then
		self:DeterrenceFade()
	elseif sync == syncName.nimbleReflexes and self.db.profile.nimblereflexes then
		self:NimbleReflexes()
	elseif sync == syncName.nimbleReflexesFade and self.db.profile.nimblereflexes then
		self:NimbleReflexesFade()
	elseif sync == syncName.unbalancingStrike and rest and self.db.profile.unbalancingstrike then
		self:UnbalancingStrike(rest)
	elseif sync == syncName.unbalancingStrikeFade and rest and self.db.profile.unbalancingstrike then
		self:UnbalancingStrikeFade(rest)
	elseif sync == syncName.pierceArmor and rest and self.db.profile.piercearmor then
		self:PierceArmor(rest)
	elseif sync == syncName.pierceArmorFade and rest and self.db.profile.piercearmor then
		self:PierceArmorFade(rest)	
	end
end


function module:ForlornSpiritSpawn()
	forlornCount = forlornCount + 1
	if forlornCount > 10 then forlornCount = 1 end
	self:RemoveBar(L["bar_forlornSpiritSpawnCd"])
	self:Bar(L["bar_forlornSpiritSpawnSoon"], 2 * forlornCount, icon.forlornSpiritSpawnSoon, true, color.forlornSpiritSpawnSoon)
	
	self:DelayedBar(2 * forlornCount, L["bar_forlornSpiritSpawnCd"], 20 - (2 * forlornCount), icon.forlornSpiritSpawnCd, true, color.forlornSpiritSpawnCd)
	self:DelayedMessage(2 * forlornCount, L["msg_forlornSpiritSpawn"], "Positive", false, nil, false)
end

function module:LurkingShadowSpawn(rest)
	self:Bar(rest.." "..L["bar_lurkingShadowSpawn"], timer.lurkingShadowSpawn, icon.lurkingShadowSpawn, true, color.lurkingShadowSpawn)
	self:SetCandyBarOnClick("BigWigsBar "..rest.." "..L["bar_lurkingShadowSpawn"], function(name, button, extra) TargetByName(extra, true) end, "Lurking Shadow")
	
	self:Message(rest..L["msg_lurkingShadowSpawn"], "Attention", false, nil, false)
	
	if string.lower(UnitClass("Player")) == rest then
		self:Sound("Beware")
		self:WarningSign(icon.lurkingShadowSpawn, 1)
	end
end

function module:Enrage()
	self:WarningSign(icon.enrage, 0.7)
end

function module:Deterrence()
	self:Bar(L["bar_deterrence"], timer.deterrence, icon.deterrence, true, color.deterrence)
end

function module:DeterrenceFade()
	self:RemoveBar(L["bar_deterrence"])
end

function module:NimbleReflexes()
	self:Bar(L["bar_nimbleReflexes"], timer.nimbleReflexes, icon.nimbleReflexes, true, color.nimbleReflexes)
end

function module:NimbleReflexesFade()
	self:RemoveBar(L["bar_nimbleReflexes"])
end

function module:UnbalancingStrike(rest)
	self:Bar(rest..L["bar_unbalancingStrike"], timer.unbalancingStrike, icon.unbalancingStrike, true, color.unbalancingStrike)
end

function module:UnbalancingStrikeFade(rest)
	self:RemoveBar(rest..L["bar_unbalancingStrike"])
end

function module:PierceArmor(rest)
	self:Bar(rest..L["bar_pierceArmor"], timer.pierceArmor, icon.pierceArmor, true, color.pierceArmor)
end

function module:PierceArmorFade(rest)
	self:RemoveBar(rest..L["bar_pierceArmor"])
end

function module:Test()
	BigWigs:ToggleActive(true)
	self:Engage()
	local events = {
		{ time = 20,  func = function()
			print("大喊")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL","Spirits, rise, and drive back this rabble!")
		end },
		{ time = 40,  func = function()
			print("大喊")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL","Spirits, rise, and drive back this rabble!")
		end },
		{ time = 60,  func = function()
			print("大喊")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL","Spirits, rise, and drive back this rabble!")
		end },
		{ time = 80,  func = function()
			print("大喊")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL","Spirits, rise, and drive back this rabble!")
		end },
		{ time = 100,  func = function()
			print("大喊")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL","Spirits, rise, and drive back this rabble!")
		end },
		{ time = 120,  func = function()
			print("大喊")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL","Spirits, rise, and drive back this rabble!")
		end },
		{ time = 140,  func = function()
			print("大喊")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL","Spirits, rise, and drive back this rabble!")
		end },
		{ time = 160,  func = function()
			print("大喊")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL","Spirits, rise, and drive back this rabble!")
		end },
		{ time = 180,  func = function()
			print("大喊")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL","Spirits, rise, and drive back this rabble!")
		end },
		{ time = 200,  func = function()
			print("大喊")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL","Spirits, rise, and drive back this rabble!")
		end },
		{ time = 220,  func = function()
			print("大喊")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL","Spirits, rise, and drive back this rabble!")
		end },
		{ time = 240,  func = function()
			print("大喊")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL","Spirits, rise, and drive back this rabble!")
		end },
		{ time = 260,  func = function()
			print("大喊")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL","Spirits, rise, and drive back this rabble!")
		end },
		{ time = 280,  func = function()
			print("大喊")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL","Spirits, rise, and drive back this rabble!")
		end },
		{ time = 300,  func = function()
			print("大喊")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL","Spirits, rise, and drive back this rabble!")
		end },
	}
	for i, event in ipairs(events) do
		self:ScheduleEvent("RexTest" .. i, event.func, event.time)
	end
	self:Message(module.translatedName .. " 模拟测试开始", "Positive")
end
--/run BigWigs:GetModule("卡拉赞黑暗掠夺者"):Test()