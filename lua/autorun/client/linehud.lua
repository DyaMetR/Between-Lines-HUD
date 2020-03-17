--[[-----------------

	BETWEEN LINES HUD
	by DyaMetR

	Version 1.0.5
	17/03/20

]]-------------------

surface.CreateFont( "lineHUD1", {
font = "Britannic Bold",
size = 45,
weight = 500,
blursize = 0,
scanlines = 0,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = false,
additive = false,
outline = false
})

surface.CreateFont( "lineHUD1sm", {
font = "Britannic Bold",
size = 18,
weight = 500,
blursize = 0,
scanlines = 0,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = false,
additive = false,
outline = false
})

surface.CreateFont( "lineHUD1Ch", {
font = "Britannic Bold",
size = 45,
weight = 500,
blursize = 6,
scanlines = 0,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = false,
additive = false,
outline = false
})

surface.CreateFont( "lineHUD2", {
font = "Verdana",
size = 16,
weight = 1000,
blursize = 0,
scanlines = 0,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = false,
additive = false,
outline = false
})

local hpalpha = 0
local hptick = CurTime() + 0.01
local hpreftick = CurTime() + 0.01

local hptickbad = CurTime() + 0.01
local hpbcol = 200

local lasthp = 100

local apalpha = 0
local aptick = CurTime() + 0.01
local apreftick = CurTime() + 0.01

local lastap = 0

local amalpha = 0
local amtick = CurTime() + 0.01
local amreftick = CurTime() + 0.01

local lastam = 0

local ShowUselessElements = CreateClientConVar("linehud_showuseless", 1, true, true)
local ShowSpeedOnKPH = CreateClientConVar("linehud_kph", 1, true, true)
local enabled = CreateClientConVar("linehud_enabled", 1, true, true)

function lineHUD()
if enabled:GetInt() == 1 then
local hp = LocalPlayer():Health()
local ap = LocalPlayer():Armor()

    if hp != lasthp then
        if hptick != CurTime() then
            if lasthp < hp then
                lasthp = lasthp + 1
                hpalpha = 255
            elseif lasthp > hp then
                lasthp = lasthp - 1
                hpalpha = 255
            end
            hptick = CurTime() + 0.01
        end
    end

    if hpreftick < CurTime() then
        if hpalpha > 0 then
            hpalpha = hpalpha - 10
        end
    end

    if hp <= 20 then
        if hpbcol > 200 then
            if hptickbad < CurTime() then
                hpbcol = hpbcol - (1*(20-(hp)))/2
                hptickbad = CurTime() + 0.01
            end
        else
            hpbcol = 255
        end
    end

    if ap != lastap then
        if aptick != CurTime() then
            if lastap < ap then
                lastap = lastap + 1
                apalpha = 255
            elseif lastap > ap then
                lastap = lastap - 1
                apalpha = 255
            end
            aptick = CurTime() + 0.01
        end
    end

    if apreftick < CurTime() then
        if apalpha > 0 then
            apalpha = apalpha - 10
        end
    end

local hpcol = Color(0,255,0,255)
local hpcol2 = Color(0,255,0,hpalpha)
local hpcol3 = Color(0,255,0,100)

    if hp < 50 and hp > 20 then
        hpcol = Color(255,255,0,255)
        hpcol2 = Color(255,255,0,hpalpha)
        hpcol3 = Color(255,255,0,100)
    elseif hp <= 20 then
        hpcol = Color(hpbcol,0,0,255)
        hpcol2 = Color(255,0,0,hpalpha)
        hpcol3 = Color(255,0,0,100)
    else
        hpcol = Color(0,255,0,255)
        hpcol2 = Color(0,255,0,hpalpha)
        hpcol3 = Color(0,255,0,100)
    end

    draw.SimpleText("HEALTH","lineHUD2", 84, ScrH() - 128, hpcol,1)
    if hp > 0 then
        draw.SimpleText(hp,"lineHUD1", 82, ScrH() - 120, hpcol,1)
        draw.SimpleText(hp,"lineHUD1Ch", 82, ScrH() - 120, hpcol2,1)
    else
        draw.SimpleText("0","lineHUD1", 82, ScrH() - 120, Color(255,0,0,255),1)
    end
    draw.RoundedBox(0,10,ScrH() - 100,30,5,Color(0,0,0,255))
    if hp > 50 then
        draw.RoundedBox(0,10,ScrH() - 100,30,5,hpcol)
    else
        draw.RoundedBox(0,10,ScrH() - 100,30*(hp/50),5,hpcol)
    end

    draw.RoundedBox(0,127,ScrH() - 100,30,5,Color(0,0,0,255))
    draw.RoundedBox(0,127,ScrH() - 100,30*(hp - 50)/50,5,hpcol)

    if ap > 0 then
        draw.SimpleText("ARMOR","lineHUD2", 84, ScrH() - 78, Color(0,255,255,255),1)
        draw.SimpleText(ap,"lineHUD1", 82, ScrH() - 70, Color(0,255,255,255),1)
        draw.SimpleText(ap,"lineHUD1Ch", 82, ScrH() - 70, Color(0,255,255,apalpha),1)
        draw.RoundedBox(0,10,ScrH() - 50,30,5,Color(0,0,0,255))
        if ap > 50 then
            draw.RoundedBox(0,10,ScrH() - 50,30,5,Color(0,255,255,255))
        else
            draw.RoundedBox(0,10,ScrH() - 50,30*(ap/50),5,Color(0,255,255,255))
        end

        draw.RoundedBox(0,127,ScrH() - 50,30,5,Color(0,0,0,255))
        draw.RoundedBox(0,127,ScrH() - 50,30*(ap - 50)/50,5,Color(0,255,255,255))
    else
        if ShowUselessElements:GetInt() == 1 then
            draw.SimpleText("ARMOR","lineHUD2", 84, ScrH() - 78, Color(0,0,0,100),1)
            draw.SimpleText(ap,"lineHUD1", 82, ScrH() - 70, Color(0,0,0,100),1)
            draw.RoundedBox(0,10,ScrH() - 50,30,5,Color(0,0,0,100))
            draw.RoundedBox(0,127,ScrH() - 50,30,5,Color(0,0,0,100))
        end
    end

    if IsValid(LocalPlayer():GetActiveWeapon()) and hp > 0 and !LocalPlayer():InVehicle() then
        local max = 0
        local wep = LocalPlayer():GetActiveWeapon()
        local clip = wep:Clip1()

        if LocalPlayer():GetActiveWeapon():GetClass() == "weapon_pistol" then
            max = 18
        elseif LocalPlayer():GetActiveWeapon():GetClass() == "weapon_smg1" then
            max = 45
        elseif LocalPlayer():GetActiveWeapon():GetClass() == "weapon_357" then
            max = 6
        elseif LocalPlayer():GetActiveWeapon():GetClass() == "weapon_ar2" then
            max = 30
        elseif LocalPlayer():GetActiveWeapon():GetClass() == "weapon_shotgun" then
            max = 6
        elseif LocalPlayer():GetActiveWeapon():GetClass() == "weapon_crossbow" then
            max = 1
        else
            if LocalPlayer():GetActiveWeapon().Primary != nil then
                max = LocalPlayer():GetActiveWeapon().Primary.ClipSize
            else
                max = 0
            end
        end

        if clip != lastam then
            if amtick != CurTime() then
                if lastam < clip then
                    lastam = lastam + 1
                    amalpha = 255
                elseif lastam > clip then
                    lastam = lastam - 1
                    amalpha = 255
                end
                amtick = CurTime() + 0.01
            end
        end

        if amreftick < CurTime() then
            if amalpha > 0 then
                amalpha = amalpha - 10
            end
        end

        if LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() != -1 then
            if clip > 0 then
                draw.SimpleText("AMMUNITION","lineHUD2", ScrW() - 84, ScrH() - 128, Color(255,255,0,255),1)
                draw.SimpleText(clip,"lineHUD1", ScrW() - 84, ScrH() - 120, Color(255,255,0,255),1)
                draw.SimpleText(clip,"lineHUD1Ch", ScrW() - 84, ScrH() - 120, Color(255,255,0,amalpha),1)
            else
                if max == 0 then
                    if LocalPlayer():GetAmmoCount(wep:GetPrimaryAmmoType()) > 0 then
                        draw.SimpleText("AMMUNITION","lineHUD2", ScrW() - 84, ScrH() - 128, Color(255,255,0,255),1)
                        draw.SimpleText(LocalPlayer():GetAmmoCount(wep:GetPrimaryAmmoType()),"lineHUD1", ScrW() - 84, ScrH() - 120, Color(255,255,0,255),1)
                        draw.SimpleText(LocalPlayer():GetAmmoCount(wep:GetPrimaryAmmoType()),"lineHUD1Ch", ScrW() - 84, ScrH() - 120, Color(255,255,0,amalpha),1)
                    else
                        draw.SimpleText("AMMUNITION","lineHUD2", ScrW() - 84, ScrH() - 128, Color(255,0,0,255),1)
                        draw.SimpleText("0","lineHUD1", ScrW() - 84, ScrH() - 120, Color(255,0,0,255),1)
                        draw.SimpleText("0","lineHUD1Ch", ScrW() - 84, ScrH() - 120, Color(255,0,0,amalpha),1)
                    end
                else
                    draw.SimpleText("AMMUNITION","lineHUD2", ScrW() - 84, ScrH() - 128, Color(255,0,0,255),1)
                    draw.SimpleText("0","lineHUD1", ScrW() - 84, ScrH() - 120, Color(255,0,0,255),1)
                    draw.SimpleText("0","lineHUD1Ch", ScrW() - 84, ScrH() - 120, Color(255,0,0,amalpha),1)
                end
            end

            if max > 0 then
                draw.RoundedBox(0,ScrW() - 157,ScrH() - 100,30,5,Color(0,0,0,255))
                if clip > (max/2) then
                    draw.RoundedBox(0,ScrW() - 157,ScrH() - 100,30,5,Color(255,255,0,255))
                else
                    draw.RoundedBox(0,ScrW() - 157,ScrH() - 100,30*(clip/(max/2)),5,Color(255,255,0,255))
                end

                draw.RoundedBox(0,ScrW() - 40,ScrH() - 100,30,5,Color(0,0,0,255))
                draw.RoundedBox(0,ScrW() - 40,ScrH() - 100,30*(clip - (max/2))/(max/2),5,Color(255,255,0,255))

                if clip > 0 then
                    draw.RoundedBox(0,ScrW() - 157,ScrH() - 75,50,5,Color(255,255,0,255))
                    draw.RoundedBox(0,ScrW() - 60,ScrH() - 75,50,5,Color(255,255,0,255))
                    draw.SimpleText(LocalPlayer():GetAmmoCount(wep:GetPrimaryAmmoType()),"lineHUD1sm", ScrW() - 84, ScrH() - 80, Color(255,255,0,255),1)
                else
                    draw.RoundedBox(0,ScrW() - 157,ScrH() - 75,50,5,Color(255,0,0,255))
                    draw.RoundedBox(0,ScrW() - 60,ScrH() - 75,50,5,Color(255,0,0,255))
                    draw.SimpleText(LocalPlayer():GetAmmoCount(wep:GetPrimaryAmmoType()),"lineHUD1sm", ScrW() - 84, ScrH() - 80, Color(255,0,0,255),1)
                end

                if LocalPlayer():GetAmmoCount(wep:GetSecondaryAmmoType()) > 0 then
                    draw.SimpleText(LocalPlayer():GetAmmoCount(wep:GetSecondaryAmmoType()),"lineHUD1sm", ScrW() - 84, ScrH() - 60, Color(255,180,0,255),1)
                end
            else
                if LocalPlayer():GetAmmoCount(wep:GetPrimaryAmmoType()) > 0 then
                    draw.RoundedBox(0,ScrW() - 157,ScrH() - 100,30,5,Color(255,255,0,255))
                    draw.RoundedBox(0,ScrW() - 40,ScrH() - 100,30,5,Color(255,255,0,255))
                else
                    draw.RoundedBox(0,ScrW() - 157,ScrH() - 100,30,5,Color(255,0,0,255))
                    draw.RoundedBox(0,ScrW() - 40,ScrH() - 100,30,5,Color(255,0,0,255))
                end
                if ShowUselessElements:GetInt() == 1 then
                    draw.RoundedBox(0,ScrW() - 157,ScrH() - 75,50,5,Color(0,0,0,100))
                    draw.RoundedBox(0,ScrW() - 60,ScrH() - 75,50,5,Color(0,0,0,100))
                    draw.SimpleText("0","lineHUD1sm", ScrW() - 84, ScrH() - 80, Color(0,0,0,100),1)
                end
            end
        else
            if ShowUselessElements:GetInt() == 1 then
                draw.SimpleText("AMMUNITION","lineHUD2", ScrW() - 84, ScrH() - 128, Color(0,0,0,100),1)
                draw.SimpleText("0","lineHUD1", ScrW() - 82, ScrH() - 120, Color(0,0,0,100),1)
                draw.SimpleText("0","lineHUD1Ch", ScrW() - 82, ScrH() - 120, Color(0,0,0,100),1)

                draw.RoundedBox(0,ScrW() - 157,ScrH() - 100,30,5,Color(0,0,0,100))

                draw.RoundedBox(0,ScrW() - 40,ScrH() - 100,30,5,Color(0,0,0,100))

                draw.RoundedBox(0,ScrW() - 157,ScrH() - 75,50,5,Color(0,0,0,100))
                draw.RoundedBox(0,ScrW() - 60,ScrH() - 75,50,5,Color(0,0,0,100))
                draw.SimpleText("0","lineHUD1sm", ScrW() - 84, ScrH() - 80, Color(0,0,0,100),1)
            end
        end
    end

    if LocalPlayer():InVehicle() then
        local vel = LocalPlayer():GetVehicle():GetVelocity():Length()
        local kph = math.Round(vel/(39370.0787 / 3600))
		local mph = math.Round(vel * 3600 / 63360 * 0.75)

        draw.SimpleText("SPEED","lineHUD2", ScrW() - 84, ScrH() - 128, Color(0,225,255,255),1)
		if ShowSpeedOnKPH:GetInt() == 1 then
			draw.SimpleText(kph,"lineHUD1", ScrW() - 82, ScrH() - 120, Color(0,225,255,255),1)
		else
			draw.SimpleText(mph,"lineHUD1", ScrW() - 82, ScrH() - 120, Color(0,225,255,255),1)
		end

        draw.RoundedBox(0,ScrW() - 157,ScrH() - 100,30,5,Color(0,225,255,255))

        draw.RoundedBox(0,ScrW() - 40,ScrH() - 100,30,5,Color(0,225,255,255))
    end

end
end
hook.Add("HUDPaint", "lineHUD", lineHUD)

local tohide = { -- This is a table where the keys are the HUD items to hide
["CHudHealth"] = true,
["CHudBattery"] = true,
["CHudAmmo"] = true,
["CHudSecondaryAmmo"] = true
}
local function HUDShouldDraw(name) -- This is a local function because all functions should be local unless another file needs to run it
  if (enabled:GetInt() <= 0) then return end
  if (tohide[name]) then return false; end
end
hook.Add("HUDShouldDraw", "LineHUD Hide", HUDShouldDraw)

local function TheMenu( Panel )
	Panel:ClearControls()
	//Do menu things here
	Panel:AddControl( "Label" , { Text = "Between Lines HUD Settings", Description = "The options of Between Lines HUD"} )
	Panel:AddControl( "CheckBox", {
		Label = "Enabled",
		Command = "linehud_enabled",
		}
	)

	Panel:AddControl( "CheckBox", {
		Label = "Show 'useless' elements?",
		Command = "linehud_showuseless",
		}
	)

	Panel:AddControl( "CheckBox", {
		Label = "Use KPH for speed-o-meter units (instead of MPH)",
		Command = "linehud_kph",
		}
	)
end

local function createthemenu()
	spawnmenu.AddToolMenuOption( "Options", "DyaMetR", "lineHUD", "Between Lines HUD", "", "", TheMenu )
end
hook.Add( "PopulateToolMenu", "lineHUD", createthemenu )
