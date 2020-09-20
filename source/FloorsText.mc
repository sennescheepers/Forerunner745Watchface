using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module FloorsText {

	//var bigFont = WatchUi.loadResource(Rez.Fonts.big_filled_font);
	//var font = WatchUi.loadResource(Rez.Fonts.complication_font);
	//var iconFont = WatchUi.loadResource(Rez.Fonts.icon_font);
	var accentColor;
	var useAccentColor;
	
	var icon = "B";
	var iconWidth;
	
	var LocX;
	var LocY;
	
	var floorsString;

	function drawFloors(dc, position) {
	
		useAccentColor = Application.getApp().getProperty("AccentColorComplication");
		accentColor = (useAccentColor) ? Application.getApp().getProperty("AccentColor") : Graphics.COLOR_WHITE;
	
		// Get the notificationsCount
		floorsString = Lang.format("$1$", [ActivityMonitor.getInfo().floorsClimbed]);
       	
       	// Calculate position
       	var bigFontHeight = dc.getFontHeight(Fonts.bigFilledFont);
       	var floorsTextWidth = dc.getTextWidthInPixels(floorsString, Fonts.complicationFont);
       	iconWidth = dc.getTextWidthInPixels(icon, Fonts.iconFont);
       	if (position == 0) {// Left
       		LocX = dc.getWidth() / 2 - floorsTextWidth - iconWidth - 10;
       	} else { // Right
       		LocX = dc.getWidth() / 2 + 10;
       	}
       	LocY = (dc.getHeight() - bigFontHeight) / 2 - 5;
       	
       	// Set date text
       	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
       	dc.drawText(LocX + 5 + iconWidth, LocY, Fonts.complicationFont, floorsString, Graphics.TEXT_JUSTIFY_LEFT);
       	dc.setColor(accentColor, Graphics.COLOR_BLACK);
       	dc.drawText(LocX, LocY, Fonts.iconFont, icon, Graphics.TEXT_JUSTIFY_LEFT);
	
	}

}