//- GUI Documenation: https://community.bistudio.com/wiki/Arma:_GUI_Configuration
//- Control Types:    https://community.bistudio.com/wiki/Arma:_GUI_Configuration#Control_Types
//- Control Styles:   https://community.bistudio.com/wiki/Arma:_GUI_Configuration#Control_Styles

//Eden Editor macros such as background colour and pixel grid
#include "\a3\3DEN\UI\macros.inc"
#include "\a3\3DEN\UI\macroexecs.inc"
//GRIDs
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\A3\ui_f\hpp\defineCommonColors.inc"
//DIK Key Codes
#include "\a3\ui_f\hpp\definedikcodes.inc"
//Eden Editor IDDs and IDCs as well as control types, styles and macros
#include "\a3\3den\ui\resincl.inc"

#define SIZE_X  (((0.81 * 30 * GUI_GRID_W) min (safezoneW*0.5)) / (0.81 * GUI_GRID_W))
#define SIZE_Y  (((0.45 * 30 * GUI_GRID_H) min (safezoneH*0.45)) / (0.45 * GUI_GRID_H))
#define PylonGroupSize_X  (0.81 * (SIZE_X min SIZE_Y) * GUI_GRID_W)
#define PylonGroupSize_Y  (0.45 * (SIZE_X min SIZE_Y) * GUI_GRID_H)
#define PylonWidth  (GUI_GRID_W*5)
#define PylonHeight  (GUI_GRID_H*0.9)

#define SpawnGroupSize_X (GUI_GRID_W*9.5)

//Import Base Controls
import RscButton;
import RscButtonMenu;
import RscCheckBox;
import RscCombo;
import RscControlsGroupNoScrollbars;
import RscPicture;
import RscPictureKeepAspect;
import RscProgress;
import RscText;
import ctrlButtonPictureKeepAspect;
import RscDisplayGarage;

class GarageLoadDisplay: RscDisplayGarage {
	idd = 8765;
	class controls: controls
	{
		class ArrowLeft: ArrowLeft {};
		class ArrowRight: ArrowRight {};
		class BackgroundLeft: BackgroundLeft {};
		class BackgroundRight: BackgroundRight {};
		class LineIcon: LineIcon {};
		class LineTabLeft: LineTabLeft {};
		class LineTabLeftSelected: LineTabLeftSelected {};
		class LineTabRight: LineTabRight {};
		class Tabs: Tabs {};
		class FrameLeft: FrameLeft {};
		class FrameRight: FrameRight {};
		class Load: Load {};
		class LoadCargo: LoadCargo {};
		class Message: Message {};
		class Space: Space {};
		class ControlBar: ControlBar {
			class controls: controls
			{
				class ButtonClose: ButtonClose {};
				class ButtonInterface: ButtonInterface {};
				class ButtonRandom: ButtonRandom {};
				class ButtonSave: ButtonSave {};
				class ButtonLoad: ButtonLoad {};
				class ButtonExport: ButtonExport {};
				class ButtonImport: ButtonImport {};
			};
		};
		class Info: Info { class controls: controls {}; };
		class Stats: Stats { class controls: controls {}; };
		class MouseBlock: MouseBlock {};
		class Template: Template {};
		class MessageBox: MessageBox {};
		class TabCar: TabCar {};
		class IconCar: IconCar {};
		class ListCar: ListCar {};
		class ListDisabledCar: ListDisabledCar {};
		class TabTank: TabTank {};
		class IconTank: IconTank {};
		class ListTank: ListTank {};
		class ListDisabledTank: ListDisabledTank {};
		class TabHelicopter: TabHelicopter {};
		class IconHelicopter: IconHelicopter {};
		class ListHelicopter: ListHelicopter {};
		class ListDisabledHelicopter: ListDisabledHelicopter {};
		class TabPlane: TabPlane {};
		class IconPlane: IconPlane {};
		class ListPlane: ListPlane {};
		class ListDisabledPlane: ListDisabledPlane {};
		class TabNaval: TabNaval {};
		class IconNaval: IconNaval {};
		class ListNaval: ListNaval {};
		class ListDisabledNaval: ListDisabledNaval {};
		class TabStatic: TabStatic {};
		class IconStatic: IconStatic {};
		class ListStatic: ListStatic {};
		class ListDisabledStatic: ListDisabledStatic {};
		class TabCrew: TabCrew {};
		class IconCrew: IconCrew {};
		class ListCrew: ListCrew {};
		class ListDisabledCrew: ListDisabledCrew {};
		class TabAnimationSources: TabAnimationSources {};
		class IconAnimationSources: IconAnimationSources {};
		class ListAnimationSources: ListAnimationSources {};
		class ListDisabledAnimationSources: ListDisabledAnimationSources {};
		class TabTextureSources: TabTextureSources {};
		class IconTextureSources: IconTextureSources {};
		class ListTextureSources: ListTextureSources {};
		class ListDisabledTextureSources: ListDisabledTextureSources {};

		class ControlBarDummy: RscControlsGroupNoScrollbars
		{
			idc=1867;
			x="8 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) + 			(safezoneX)";
			y="23.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
			w="safezoneW";
			h="1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls
			{
				class ButtonTry: RscButtonMenu
				{
					idc=-1;
					text="";
					x="0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y="0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w="((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h="1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class ButtonOK: ButtonTry
				{
					x="0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40) + 1 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
				};
			};
		};

		class GarageStatsGroup: RscControlsGroupNoScrollbars
		{
			idc = 1868;
			x = safezoneX + ((safezoneW - SpawnGroupSize_X) / 2.0);
			y = safezoneY + safezoneH - GUI_GRID_H*7;
			w = SpawnGroupSize_X;
			h = GUI_GRID_H*5.2;
			class controls: controls
			{
				class GarageStatsBackground: RscPicture
				{
					idc = -1;
					colorBackground[] = {0,0,0,0.5};
					text = "#(argb,8,8,3)color(0.2,0.2,0.2,0.8)";
					x = 0;
					y = 0;
					w = SpawnGroupSize_X;
					h = GUI_GRID_H*2.3;
				};

				class GarageStatsModPicture: RscPictureKeepAspect
				{
					idc = 1869;
					colorBackground[] ={0,0,0,0.8};
					x = GUI_GRID_W*0.1;
					y = GUI_GRID_H*0.1;
					w = GUI_GRID_W*2.1;
					h = GUI_GRID_H*2.1;
				};

				class GarageStatsMaxSpeed: RscProgress
				{
					idc = 1870;
					colorFrame[] = {0,0,0,0};
					colorBar[] = {1,1,1,1};
					x = GUI_GRID_W*2.3;
					y = GUI_GRID_H*0.1;
					w = SpawnGroupSize_X - (GUI_GRID_W * 2.45);
					h = GUI_GRID_H;
				};
				class GarageStatsMaxSpeedText: RscText
				{
					idc = -1;
					colorText[]={0,0,0,1};
					colorShadow[]={1,1,1,1};
					colorBackground[]={1,1,1,0.1};
					text = "$STR_A3_RSCDISPLAYGARAGE_STAT_MAX_SPEED";
					x = GUI_GRID_W*2.3;
					y = GUI_GRID_H*0.1;
					w = SpawnGroupSize_X - (GUI_GRID_W * 2.45);
					h = GUI_GRID_H;
					shadow = 0;
				};

				class GarageStatsArmor: GarageStatsMaxSpeed
				{
					idc = 1871;
					y = GUI_GRID_H*1.2;
				};
				class GarageStatsArmorText: GarageStatsMaxSpeedText
				{
					text = "$STR_UI_ABAR";
					y = GUI_GRID_H*1.2;
				};

				class GarageSpawnButton: RscButton
				{
					idc = -1;
					font = "PuristaMedium";
					text = "SPAWN";
					tooltip = "Ready?";
					colorBackground[] = {0,0,0,0.5};
					x = 0;
					y = GUI_GRID_H*2.5;
					w = SpawnGroupSize_X;
					h = GUI_GRID_H*1.5;
					onButtonClick = " \
						_display = uiNamespace getVariable 'Garage_Display_Loadout'; \
						missionNameSpace setVariable ['Garage_Spawn_Flag' ,true]; \
						_display closeDisplay 1; \
					";
				};

				class GarageSpawnType: RscCombo
				{
					idc = -1;
					font = "PuristaMedium";
					text = "Pylons settings";
					tooltip = "Spawn Type";
					x = 0;
					y = GUI_GRID_H*4.2;
					w = SpawnGroupSize_X;
					h = GUI_GRID_H;
					onLBSelChanged = "missionNamespace setVariable ['Garage_SpawnType', _this select 1];";
					onLoad = "(_this select 0) lbSetCurSel (missionNamespace getVariable ['Garage_SpawnType', 0]);";
					class Items
					{
						class OnlySpawn { text = "Only Spawn"; default = 1; };
						class Getin { text = "Get in"; };
						class Flying { text = "Flying"; };
					};
				};
			};
		};
	};
};

class GaragePylonGroup: RscControlsGroupNoScrollbars
{
	idc = 1872;
	x = (safezoneX + safezoneW) - PylonGroupSize_X - (0.6*GUI_GRID_W);
	y = (safezoneY + safezoneH) - PylonGroupSize_Y - (1.8*GUI_GRID_H);
	w = PylonGroupSize_X;
	h = PylonGroupSize_Y;
	class controls: controls
	{
		class GaragePylonBackground: RscPicture
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.5};
			text = "#(argb,8,8,3)color(0.2,0.2,0.2,0.8)";
			x = 0;
			y = 0;
			w = PylonGroupSize_X;
			h = PylonGroupSize_Y;
		};

		class GaragePylonText: RscText
		{
			idc = -1;
			font = "RobotoCondensedLight";
			text = "Pylons settings";
			x = 0;
			y = 0;
			w = PylonGroupSize_X;
			h = PylonGroupSize_Y * 0.07;
		};

		class GaragePylonUIPicture: RscPictureKeepAspect
		{
			idc = 1873;
			x = 0;
			y = PylonGroupSize_Y * 0.07;
			w = PylonGroupSize_X * 0.921;
			h = PylonGroupSize_Y * 0.907;
		};

		class GaragePylonPreset: RscCombo
		{
			idc = 1875;
			colorBackground[] ={0,0,0,0.8};
			font = "RobotoCondensedLight";
			tooltip = "Select Preset";
			x = PylonGroupSize_X*0.03;
			y = PylonGroupSize_Y*0.086;
			w = PylonWidth;
			h = PylonHeight;
			class Items
			{
				class Custom { text = "Custom"; default = 1; };
			};
		};

		class GaragePylonMirror: RscCheckBox
		{
			idc = 1874;
			font = "RobotoCondensedLight";
			tooltip = "Mirroring";
			x = PylonGroupSize_X*0.815;
			y = PylonGroupSize_Y*0.086;
			w = GUI_GRID_W;
			h = GUI_GRID_H;
		};

		class GaragePylonMirrorText: RscText
		{
			idc = -1;
			font = "RobotoCondensedLight";
			text = "Mirror";
			x = PylonGroupSize_X*0.815+PylonHeight;
			y = PylonGroupSize_Y*0.086;
			w = PylonWidth;
			h = PylonHeight;
		};
	};
};

class GaragePylons: RscCombo
{
	idc = -1;
	colorBackground[] = {0,0,0,0.8};
	font = "RobotoCondensedLight";
	w = PylonWidth;
	h = PylonHeight;
};

class GaragePylonTurrets: ctrlButtonPictureKeepAspect
{
	idc = -1;
	colorBackground[] = {0,0,0,0.8};
	font = "RobotoCondensedLight";
	w = PylonHeight;
	h = PylonHeight;
};
