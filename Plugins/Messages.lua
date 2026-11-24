assert(BigWigs, "BigWigs not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigsMessages")
local paint = AceLibrary("PaintChips-2.0")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function()
	return {
		["Messages"] = true,

		["msg"] = true,
		["enable"] = true,
		["Enable"] = true,
		["Enable message display."] = true,
		["anchor"] = true,
		["reset"] = true,
		["rw"] = true,
		["color"] = true,
		["scale"] = true,

		["Options for the message frame."] = true,
		["Anchor"] = true,
		["Show the message anchor frame."] = true,
		["Use RaidWarning"] = true,
		["Toggle sending messages to the RaidWarnings frame."] = true,
		["Use colors"] = true,
		["Toggles white only messages ignoring coloring."] = true,
		["Message frame scale"] = true,

		["Reset position"] = true,
		["Reset the anchor position, moving it to the default location"] = true,

		["Message frame"] = true,
		["Show anchor"] = true,
		["Send messages to RaidWarning frame"] = true,
		["Set the message frame scale."] = true,
		["Colorize messages"] = true,
		["Scale"] = true,

		["|cffff0000Co|cffff00fflo|cff00ff00r|r"] = true,
		["White"] = true,
		["BigWigs frame"] = true,
		["RaidWarning frame"] = true,
		["Scale is set to %s"] = true,
		["Messages are now sent to the %2$s"] = true,
		["Messages are currently sent to the %2$s"] = true,

		["display"] = true,
		["Display"] = true,
		["Set where messages are displayed."] = true,
		["Display is now set to %2$s"] = true,
		["Display is currently set to %2$s"] = true,

		["Mik's Scrolling Battle Text"] = true,
		["Scrolling Combat Text"] = true,
		["Floating Combat Text"] = true,

		["Test"] = true,
		["Edit"] = true,
		["Close"] = true,
	}
end)
L:RegisterTranslations("zhCN", function()
	return {
		["Messages"] = "消息",

		["msg"] = "消息",
		["enable"] = "启用",
		["Enable"] = "启用",
		["Enable message display."] = "启用消息显示",
		["anchor"] = "框体锚点",
		["reset"] = "重置",
		["rw"] = "团队警报频道",
		["color"] = "颜色",
		["scale"] = "大小",

		["Options for the message frame."] = "消息显示模式及相关设置.",
		["Anchor"] = "信息框锚点",
		["Show the message anchor frame."] = "显示信息框锚点.",
		["Use RaidWarning"] = "使用团队通知",
		["Toggle sending messages to the RaidWarnings frame."] = "选择是否通过团队通知发送消息.",
		["Use colors"] = "发送彩色消息",
		["Toggles white only messages ignoring coloring."] = "选择是否只发送单色消息.",
		["Message frame scale"] = "信息框架缩放",

		["Reset position"] = "重置位置",
		["Reset the anchor position, moving it to the default location"] = "重置锚点位置，移到默认位置",

		["Message frame"] = "信息框",
		["Show anchor"] = "显示信息框锚点",
		["Send messages to RaidWarning frame"] = "发送消息到团队通知频道",
		["Set the message frame scale."] = "调整消息框架缩放",
		["Colorize messages"] = "彩色消息",
		["Scale"] = "大小",

		["|cffff0000Co|cffff00fflo|cff00ff00r|r"] = "|cffff0000颜色|cffff00ff颜色|cff00ff00颜色|r",
		["White"] = "白色",
		["BigWigs frame"] = "BigWigs窗口模式",
		["RaidWarning frame"] = "团队通告模式",
		["Scale is set to %s"] = "缩放比例设置为 %s",
		["Messages are now sent to the %2$s"] = "将当前消息设置发送到 %2$s",
		["Messages are currently sent to the %2$s"] = "将当前消息设置发送到 %2$s",

		["display"] = "显示",
		["Display"] = "显示",
		["Set where messages are displayed."] = "设置显示消息的位置.",
		["Display is now set to %2$s"] = "显示现在设置为 %2$s",
		["Display is currently set to %2$s"] = "显示当前设置为 %2$s",

		["Mik's Scrolling Battle Text"] = "MSBT式战斗信息",
		["Scrolling Combat Text"] = "SCT式战斗信息",
		["Floating Combat Text"] = "浮动战斗信息",

		["Test"] = "测试",
		["Edit"] = "编辑",
		["Close"] = "关闭",
	}
end)

----------------------------------
--      Module Declaration      --
----------------------------------

BigWigsMessages = BigWigs:NewModule(L["Messages"])
BigWigsMessages.frames = {}
BigWigsMessages.defaultDB = {
	enable = true,
	display = L["BigWigs frame"],
	usecolors = true,
	scale = 1.0,
}
BigWigsMessages.consoleCmd = L["msg"]
BigWigsMessages.consoleOptions = {
	type = "group",
	name = L["Messages"],
	desc = L["Options for the message frame."],
	args = {
		[L["enable"]] = {
			type = "toggle",
			name = L["Enable"],
			desc = L["Enable message display."],
			order = 1,
			get = function()
				return BigWigsMessages.db.profile.enable
			end,
			set = function(v)
				BigWigsMessages.db.profile.enable = v
			end,
		},
		[L["anchor"]] = {
			type = "execute",
			name = L["Anchor"],
			desc = L["Show the message anchor frame."],
			order = 2,
			func = function()
				BigWigsMessages:BigWigs_ShowAnchors()
			end,
			disabled = function()
				return (BigWigsMessages.db.profile.enable == false or BigWigsMessages.db.profile.display ~= L["BigWigs frame"])
			end,
		},
		[L["color"]] = {
			type = "toggle",
			name = L["Use colors"],
			desc = L["Toggles white only messages ignoring coloring."],
			order = 3,
			get = function()
				return BigWigsMessages.db.profile.usecolors
			end,
			set = function(v)
				BigWigsMessages.db.profile.usecolors = v
			end,
			map = { [true] = L["|cffff0000Co|cffff00fflo|cff00ff00r|r"], [false] = L["White"] },
			disabled = function()
				return (BigWigsMessages.db.profile.enable == false)
			end,
		},
		[L["scale"]] = {
			type = "range",
			name = L["Message frame scale"],
			desc = L["Set the message frame scale."],
			order = 4,
			min = 0.2,
			max = 2.0,
			step = 0.1,
			get = function()
				return BigWigsMessages.db.profile.scale
			end,
			set = function(v)
				BigWigsMessages.db.profile.scale = v
				if BigWigsMessages.msgframe then
					BigWigsMessages.msgframe:SetScale(v)
				end
			end,
			disabled = function()
				return (BigWigsMessages.db.profile.enable == false or BigWigsMessages.db.profile.display ~= L["BigWigs frame"])
			end,
		},
		[L["display"]] = {
			type = "text",
			name = L["Display"],
			desc = L["Set where messages are displayed."],
			order = 5,
			get = function()
				return BigWigsMessages.db.profile.display
			end,
			validate = { L["BigWigs frame"], L["RaidWarning frame"] },
			set = function(v)
				BigWigsMessages.db.profile.display = v
			end,
			message = L["Display is now set to %2$s"],
			current = L["Display is currently set to %2$s"],
			disabled = function()
				return (BigWigsMessages.db.profile.enable == false)
			end,
		},
		[L["reset"]] = {
			type = "execute",
			name = L["Reset position"],
			desc = L["Reset the anchor position, moving it to the default location"],
			order = 6,
			func = function()
				BigWigsMessages:ResetAnchor()
			end,
			disabled = function()
				return (BigWigsMessages.db.profile.enable == false)
			end,
		},
	},
}

------------------------------
--   Optional Dependancies  --
------------------------------

if MikSBT then
	table.insert(BigWigsMessages.consoleOptions.args[L["display"]].validate, L["Mik's Scrolling Battle Text"])
end

if SCT_Display_Message or (SCT and SCT.DisplayMessage) then
	table.insert(BigWigsMessages.consoleOptions.args[L["display"]].validate, L["Scrolling Combat Text"])
end

if CombatText_AddMessage then
	table.insert(BigWigsMessages.consoleOptions.args[L["display"]].validate, L["Floating Combat Text"])
end

------------------------------
--      Initialization      --
------------------------------

function BigWigsMessages:OnRegister()
	self:SetupFrames()
	self:CreateMsgFrame()
end

function BigWigsMessages:OnEnable()
	self:RegisterEvent("BigWigs_Message")
	self:RegisterEvent("BigWigs_ShowAnchors")
	self:RegisterEvent("BigWigs_HideAnchors")
end

function BigWigsMessages:CreateMsgFrame()
	self.msgframe = CreateFrame("MessageFrame")
	self.msgframe:SetWidth(512)
	self.msgframe:SetHeight(200)

	self.msgframe:SetPoint("TOP", self.frames.anchor, "BOTTOM", 0, 0)
	self.msgframe:SetScale(self.db.profile.scale or 1)
	self.msgframe:SetInsertMode("TOP")
	self.msgframe:SetFrameStrata("HIGH")
	self.msgframe:SetToplevel(true)
	self.msgframe:SetFontObject(GameFontNormalLarge)
	self.msgframe:Show()
end


------------------------------
--      Event Handlers      --
------------------------------

function BigWigsMessages:BigWigs_ShowAnchors()
	self.frames.anchor:Show()
end

function BigWigsMessages:BigWigs_HideAnchors()
	self.frames.anchor:Hide()
end

function BigWigsMessages:ResetAnchor()
	self.db.profile.posx = 200
	self.db.profile.posy = 500
	self:RestorePosition()
end

function BigWigsMessages:BigWigs_Message(text, color, noraidsay, sound, broadcastonly)
	if self.db.profile.enable == false then
		return
	end
	if not text then
		return
	end
	if broadcastonly then
		return
	end

	local r, g, b
	if color ~= nil and type(color) == "table" and type(color.r) == "number" and type(color.g) == "number" and type(color.b) == "number" then
		r, g, b = color.r, color.g, color.b
	else
		if self.db.profile.usecolors and type(BigWigsColors) == "table" and type(BigWigsColors.MsgColor) == "function" then
			color = BigWigsColors:MsgColor(color)
		end
		_, r, g, b = paint:GetRGBPercent(color or "white")
	end

	if self.db.profile.display == L["RaidWarning frame"] then
		RaidWarningFrame:AddMessage(text, r, g, b, 1, UIERRORS_HOLD_TIME)
	elseif MikSBT and self.db.profile.display == L["Mik's Scrolling Battle Text"] then
		if r == nil then
			r = 1
		end
		if g == nil then
			g = 1
		end
		if b == nil then
			b = 1
		end
		MikSBT.DisplayMessage(text, MikSBT.DISPLAYTYPE_NOTIFICATION, false, r * 255, g * 255, b * 255)
	elseif SCT_Display_Message and self.db.profile.display == L["Scrolling Combat Text"] then
		-- SCT 4.x
		local colorStruct = {}
		colorStruct.r, colorStruct.g, colorStruct.b = r, g, b
		SCT_Display_Message(text, colorStruct)
	elseif SCT and SCT_MSG_FRAME and self.db.profile.display == L["Scrolling Combat Text"] then
		-- SCT 5.x
		SCT_MSG_FRAME:AddMessage(text, r, g, b, 1)
	elseif CombatText_AddMessage and self.db.profile.display == L["Floating Combat Text"] then
		-- Blizzards FCT
		CombatText_AddMessage(text, COMBAT_TEXT_SCROLL_FUNCTION, r, g, b, "sticky", nil)
	else
		-- Default BigWigs Frame fallback
		self.msgframe:AddMessage(text, r, g, b, 1, UIERRORS_HOLD_TIME)
	end
end

------------------------------
--    Create the Anchor     --
------------------------------

function BigWigsMessages:SetupFrames()
	local f, t

	f, _, _ = GameFontNormal:GetFont()

	self.frames = {}
	self.frames.anchor = CreateFrame("Frame", "BigWigsMessageAnchor", UIParent)
	self.frames.anchor.owner = self
	self.frames.anchor:Hide()

	self.frames.anchor:SetWidth(170)
	self.frames.anchor:SetHeight(75)
	self.frames.anchor:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	self.frames.anchor:SetBackdropBorderColor(.5, .5, .5)
	self.frames.anchor:SetBackdropColor(0, 0, 0)
	self.frames.anchor:ClearAllPoints()
	self.frames.anchor:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
	self.frames.anchor:EnableMouse(true)
	self.frames.anchor:RegisterForDrag("LeftButton")
	self.frames.anchor:SetMovable(true)
	self.frames.anchor:SetScript("OnDragStart", function()
		this:StartMoving()
	end)
	self.frames.anchor:SetScript("OnDragStop", function()
		this:StopMovingOrSizing()
		this.owner:SavePosition()
	end)

	self.frames.cheader = self.frames.anchor:CreateFontString(nil, "OVERLAY")
	self.frames.cheader:SetFont(f, 14)
	self.frames.cheader:SetWidth(150)
	self.frames.cheader:SetText(L["Messages"])
	self.frames.cheader:SetTextColor(1, .8, 0)
	self.frames.cheader:ClearAllPoints()
	self.frames.cheader:SetPoint("TOP", self.frames.anchor, "TOP", 0, -10)

	self.frames.leftbutton = CreateFrame("Button", nil, self.frames.anchor)
	self.frames.leftbutton.owner = self
	self.frames.leftbutton:SetWidth(40)
	self.frames.leftbutton:SetHeight(25)
	self.frames.leftbutton:SetPoint("BOTTOMLEFT", self.frames.anchor, "BOTTOMLEFT", 10, 10)
	self.frames.leftbutton:SetScript("OnClick", function()
		self:TriggerEvent("BigWigs_Test")
	end)

	t = self.frames.leftbutton:CreateTexture()
	t:SetWidth(50)
	t:SetHeight(32)
	t:SetPoint("CENTER", self.frames.leftbutton, "CENTER")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	self.frames.leftbutton:SetNormalTexture(t)

	t = self.frames.leftbutton:CreateTexture(nil, "BACKGROUND")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(self.frames.leftbutton)
	self.frames.leftbutton:SetPushedTexture(t)

	t = self.frames.leftbutton:CreateTexture()
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(self.frames.leftbutton)
	t:SetBlendMode("ADD")
	self.frames.leftbutton:SetHighlightTexture(t)
	self.frames.leftbuttontext = self.frames.leftbutton:CreateFontString(nil, "OVERLAY")
	self.frames.leftbuttontext:SetFontObject(GameFontHighlight)
	self.frames.leftbuttontext:SetText(L["Test"])
	self.frames.leftbuttontext:SetAllPoints(self.frames.leftbutton)

	self.frames.middlebutton = CreateFrame("Button", nil, self.frames.anchor)
	self.frames.middlebutton.owner = self
	self.frames.middlebutton:SetWidth(40)
	self.frames.middlebutton:SetHeight(25)
	self.frames.middlebutton:SetPoint("BOTTOMLEFT", self.frames.anchor, "BOTTOMLEFT", 65, 10)
	self.frames.middlebutton:SetScript("OnClick", function()
		BigWigsOptions:OpenMenu(self.frames.middlebutton)
	end)

	t = self.frames.middlebutton:CreateTexture()
	t:SetWidth(50)
	t:SetHeight(32)
	t:SetPoint("CENTER", self.frames.middlebutton, "CENTER")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	self.frames.middlebutton:SetNormalTexture(t)

	t = self.frames.middlebutton:CreateTexture(nil, "BACKGROUND")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(self.frames.middlebutton)
	self.frames.middlebutton:SetPushedTexture(t)

	t = self.frames.middlebutton:CreateTexture()
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(self.frames.middlebutton)
	t:SetBlendMode("ADD")
	self.frames.middlebutton:SetHighlightTexture(t)
	self.frames.middlebuttontext = self.frames.middlebutton:CreateFontString(nil, "OVERLAY")
	self.frames.middlebuttontext:SetFontObject(GameFontHighlight)
	self.frames.middlebuttontext:SetText(L["Edit"])
	self.frames.middlebuttontext:SetAllPoints(self.frames.middlebutton)

	self.frames.rightbutton = CreateFrame("Button", nil, self.frames.anchor)
	self.frames.rightbutton.owner = self
	self.frames.rightbutton:SetWidth(40)
	self.frames.rightbutton:SetHeight(25)
	self.frames.rightbutton:SetPoint("BOTTOMLEFT", self.frames.anchor, "BOTTOMLEFT", 120, 10)
	self.frames.rightbutton:SetScript("OnClick", function()
		self:BigWigs_HideAnchors()
	end)

	t = self.frames.rightbutton:CreateTexture()
	t:SetWidth(50)
	t:SetHeight(32)
	t:SetPoint("CENTER", self.frames.rightbutton, "CENTER")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	self.frames.rightbutton:SetNormalTexture(t)

	t = self.frames.rightbutton:CreateTexture(nil, "BACKGROUND")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(self.frames.rightbutton)
	self.frames.rightbutton:SetPushedTexture(t)

	t = self.frames.rightbutton:CreateTexture()
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(self.frames.rightbutton)
	t:SetBlendMode("ADD")
	self.frames.rightbutton:SetHighlightTexture(t)
	self.frames.rightbuttontext = self.frames.rightbutton:CreateFontString(nil, "OVERLAY")
	self.frames.rightbuttontext:SetFontObject(GameFontHighlight)
	self.frames.rightbuttontext:SetText(L["Close"])
	self.frames.rightbuttontext:SetAllPoints(self.frames.rightbutton)

	self:RestorePosition()
end

function BigWigsMessages:SavePosition()
	local f = self.frames.anchor
	local s = f:GetEffectiveScale()

	self.db.profile.posx = f:GetLeft() * s
	self.db.profile.posy = f:GetTop() * s
end

function BigWigsMessages:RestorePosition()
	local x = self.db.profile.posx
	local y = self.db.profile.posy

	if not x or not y then
		return
	end

	local f = self.frames.anchor
	local s = f:GetEffectiveScale()

	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x / s, y / s)
end
