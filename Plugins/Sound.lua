assert(BigWigs, "BigWigs not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigsSound")
--~~ local dewdrop = DewdropLib:GetInstance("1.0")

local sounds = {
	Long = "Interface\\AddOns\\BigWigs\\Sounds\\Long.mp3",
	Info = "Interface\\AddOns\\BigWigs\\Sounds\\Info.mp3",
	Alert = "Interface\\AddOns\\BigWigs\\Sounds\\Alert.mp3",
	Alarm = "Interface\\AddOns\\BigWigs\\Sounds\\Alarm.mp3",
	Victory = "Interface\\AddOns\\BigWigs\\Sounds\\Victory.mp3",

	Beware = "Interface\\AddOns\\BigWigs\\Sounds\\Beware.mp3",
	RunAway = "Interface\\AddOns\\BigWigs\\Sounds\\RunAway.mp3",

	One = "Interface\\AddOns\\BigWigs\\Sounds\\1.mp3",
	Two = "Interface\\AddOns\\BigWigs\\Sounds\\2.mp3",
	Three = "Interface\\AddOns\\BigWigs\\Sounds\\3.mp3",
	Four = "Interface\\AddOns\\BigWigs\\Sounds\\4.mp3",
	Five = "Interface\\AddOns\\BigWigs\\Sounds\\5.mp3",
	Six = "Interface\\AddOns\\BigWigs\\Sounds\\6.mp3",
	Seven = "Interface\\AddOns\\BigWigs\\Sounds\\7.mp3",
	Eight = "Interface\\AddOns\\BigWigs\\Sounds\\8.mp3",
	Nine = "Interface\\AddOns\\BigWigs\\Sounds\\9.mp3",
	Ten = "Interface\\AddOns\\BigWigs\\Sounds\\10.mp3",

	Murloc = "Sound\\Creature\\Murloc\\mMurlocAggroOld.wav",
	Pain = "Sound\\Creature\\Thaddius\\THAD_NAXX_ELECT.wav",

	Plague = "Interface\\AddOns\\BigWigs\\Sounds\\Plague.mp3",

	ShackleBroke = "Interface\\AddOns\\BigWigs\\Sounds\\ShackleBroke.mp3",
	ShackleOne = "Interface\\AddOns\\BigWigs\\Sounds\\ShackleOne.mp3",
	ShackleTwo = "Interface\\AddOns\\BigWigs\\Sounds\\ShackleTwo.mp3",
	ShackleThree = "Interface\\AddOns\\BigWigs\\Sounds\\ShackleThree.mp3",

	MarkOne = "Interface\\AddOns\\BigWigs\\Sounds\\MarkOne.mp3",
	MarkTwo = "Interface\\AddOns\\BigWigs\\Sounds\\MarkTwo.mp3",
	MarkThree = "Interface\\AddOns\\BigWigs\\Sounds\\MarkThree.mp3",
	MarkFour = "Interface\\AddOns\\BigWigs\\Sounds\\MarkFour.mp3",
	MarkFive = "Interface\\AddOns\\BigWigs\\Sounds\\MarkFive.mp3",
	MarkSix = "Interface\\AddOns\\BigWigs\\Sounds\\MarkSix.mp3",
	MarkSeven = "Interface\\AddOns\\BigWigs\\Sounds\\MarkSeven.mp3",
	MarkEight = "Interface\\AddOns\\BigWigs\\Sounds\\MarkEight.mp3",
	MarkNine = "Interface\\AddOns\\BigWigs\\Sounds\\MarkNine.mp3",
	MarkTen = "Interface\\AddOns\\BigWigs\\Sounds\\MarkTen.mp3",
	MarkEleven = "Interface\\AddOns\\BigWigs\\Sounds\\MarkEleven.mp3",
	MarkTwelve = "Interface\\AddOns\\BigWigs\\Sounds\\MarkTwelve.mp3",
	HealerOneRotate = "Interface\\AddOns\\BigWigs\\Sounds\\HealerOneRotate.mp3",
	HealerTwoRotate = "Interface\\AddOns\\BigWigs\\Sounds\\HealerTwoRotate.mp3",
	HealerThreeRotate = "Interface\\AddOns\\BigWigs\\Sounds\\HealerThreeRotate.mp3",
	VoidZoneMove = "Interface\\AddOns\\BigWigs\\Sounds\\VoidZoneMove.mp3",

	ShadowFissure = "Interface\\AddOns\\BigWigs\\Sounds\\ShadowFissure.mp3",
	MindControl = "Interface\\AddOns\\BigWigs\\Sounds\\MindControl.mp3",
	FrostBlast = "Interface\\AddOns\\BigWigs\\Sounds\\FrostBlast.mp3",

	Negative = "Interface\\AddOns\\BigWigs\\Sounds\\Negative.mp3",
	Positive = "Interface\\AddOns\\BigWigs\\Sounds\\Positive.mp3",
	NegativeSwitchSides = "Interface\\AddOns\\BigWigs\\Sounds\\NegativeSwitchSides.mp3",
	PositiveSwitchSides = "Interface\\AddOns\\BigWigs\\Sounds\\PositiveSwitchSides.mp3",

	DispelPoison = "Interface\\AddOns\\BigWigs\\Sounds\\DispelPoison.mp3",

	GoBow = "Interface\\AddOns\\BigWigs\\Sounds\\GoBow.mp3",
	Hide = "Interface\\AddOns\\BigWigs\\Sounds\\hide.mp3",

	Dance = "Interface\\AddOns\\BigWigs\\Sounds\\Dance.mp3",
	FunDance = "Interface\\AddOns\\BigWigs\\Sounds\\FunDance.mp3",
}


----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function()
	return {
		["Sounds"] = true,
		["sounds"] = true,
		["Options for sounds."] = true,

		["toggle"] = true,
		["Use sounds"] = true,
		["Toggle sounds on or off."] = true,
		["default"] = true,
		["Default only"] = true,
		["Use only the default sound."] = true,
	}
end)

L:RegisterTranslations("zhCN", function()
	return {
		["Sounds"] = "声音",
		["sounds"] = "声音",
		["Options for sounds."] = "声音设置.",

		["toggle"] = "开启/关闭",
		["Use sounds"] = "使用声音",
		["Toggle sounds on or off."] = "切换声音开和关.",
		["default"] = "默认",
		["Default only"] = "默认",
		["Use only the default sound."] = "只使用系统声音.",
	}
end)

----------------------------------
--      Module Declaration      --
----------------------------------

BigWigsSound = BigWigs:NewModule(L["Sounds"])
BigWigsSound.defaultDB = {
	defaultonly = false,
	sound = true,
}
BigWigsSound.consoleCmd = L["sounds"]
BigWigsSound.consoleOptions = {
	type = "group",
	name = L["Sounds"],
	desc = L["Options for sounds."],
	args = {
		[L["toggle"]] = {
			type = "toggle",
			name = L["Sounds"],
			desc = L["Toggle sounds on or off."],
			get = function()
				return BigWigsSound.db.profile.sound
			end,
			set = function(v)
				BigWigsSound.db.profile.sound = v
				BigWigs:ToggleModuleActive(L["Sounds"], v)
			end,
		},
		[L["default"]] = {
			type = "toggle",
			name = L["Default only"],
			desc = L["Use only the default sound."],
			get = function()
				return BigWigsSound.db.profile.defaultonly
			end,
			set = function(v)
				BigWigsSound.db.profile.defaultonly = v
			end,
		},
	}
}

------------------------------
--      Initialization      --
------------------------------

function BigWigsSound:OnEnable()
	self:RegisterEvent("BigWigs_Message")
	self:RegisterEvent("BigWigs_Sound")
end
function BigWigsSound:OnDisable()
	BigWigs:DebugMessage("OnDisable")
end

function BigWigsSound:BigWigs_Message(text, color, noraidsay, sound, broadcastonly)
	if self.db.profile.sound then
		if not text or sound == false or broadcastonly then
			return
		end

		if sounds[sound] and not self.db.profile.defaultonly then
			PlaySoundFile(sounds[sound])
		else
			PlaySound("RaidWarning")
		end
	end
end

function BigWigsSound:BigWigs_Sound(sound)
	if self.db.profile.sound then
		if sounds[sound] and not self.db.profile.defaultonly then
			PlaySoundFile(sounds[sound])
		else
			PlaySound("RaidWarning")
		end
	end
end
