using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module BatteryText {

	//var bigFont = WatchUi.loadResource(Rez.Fonts.big_filled_font);
	//var font = WatchUi.loadResource(Rez.Fonts.complication_font);
	//var iconFont = WatchUi.loadResource(Rez.Fonts.icon_font);
	var accentColor;
	var useAccentColor;
	
	var icon = "D";
	var iconWidth;
	
	var LocX;
	var LocY;
	
	var batteryString;

	function drawBattery(dc, position) {
	
		
	
		// Get the notificationsCount
		batteryString = Lang.format("$1$%", [System.getSystemStats().battery.toNumber()]);
       	
       	// Calculate position
       	var bigFontHeight = dc.getFontHeight(Fonts.bigFilledFont);
       	var batteryTextWidth = dc.getTextWidthInPixels(batteryString, Fonts.complicationFont);
       	iconWidth = dc.getTextWidthInPixels(icon, Fonts.iconFont);
       	if (position == 0) {// Left
       		LocX = dc.getWidth() / 2 - batteryTextWidth - iconWidth - 10;
       	} else { // Right
       		LocX = dc.getWidth() / 2 + 10;
       	}
       	LocY = (dc.getHeight() - bigFontHeight) / 2 - 5;
       	
       	// Set date text
       	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
       	dc.drawText(LocX + 5 + iconWidth, LocY, Fonts.complicationFont, batteryString, Graphics.TEXT_JUSTIFY_LEFT);
       	dc.setColor(accentColor, Graphics.COLOR_BLACK);
       	dc.drawText(LocX, LocY, Fonts.iconFont, icon, Graphics.TEXT_JUSTIFY_LEFT);
	
	}
	
	function setSettings() {
	
		useAccentColor = Application.getApp().getProperty("AccentColorComplication");
		accentColor = (useAccentColor) ? Application.getApp().getProperty("AccentColor") : Graphics.COLOR_WHITE;
	
	}

}