using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module NotificationsText {

	//var bigFont = WatchUi.loadResource(Rez.Fonts.big_filled_font);
	//var font = WatchUi.loadResource(Rez.Fonts.complication_font);
	//var iconFont = WatchUi.loadResource(Rez.Fonts.icon_font);
	var accentColor;
	var useAccentColor;
	
	var icon = "H";
	var iconWidth;
	
	var LocX;
	var LocY;
	
	var notificationsString;

	function drawNotifications(dc, position) {
	
		// Get the notificationsCount
		notificationsString = Lang.format("$1$", [System.getDeviceSettings().notificationCount.toNumber()]);
       	
       	// Calculate position
       	var bigFontHeight = dc.getFontHeight(Fonts.bigFilledFont);
       	var notificationsTextWidth = dc.getTextWidthInPixels(notificationsString, Fonts.complicationFont);
       	iconWidth = dc.getTextWidthInPixels(icon, Fonts.iconFont);
       	if (position == 0) {// Left
       		LocX = dc.getWidth() / 2 - notificationsTextWidth - iconWidth - 10;
       	} else { // Right
       		LocX = dc.getWidth() / 2 + 10;
       	}
       	LocY = (dc.getHeight() - bigFontHeight) / 2 - 5;
       	
       	// Set date text
       	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
       	dc.drawText(LocX + 5 + iconWidth, LocY, Fonts.complicationFont, notificationsString, Graphics.TEXT_JUSTIFY_LEFT);
       	dc.setColor(accentColor, Graphics.COLOR_BLACK);
       	dc.drawText(LocX, LocY, Fonts.iconFont, icon, Graphics.TEXT_JUSTIFY_LEFT);
	
	}
	
	function setSettings() {
	
		useAccentColor = Application.getApp().getProperty("AccentColorComplication");
		accentColor = (useAccentColor) ? Application.getApp().getProperty("AccentColor") : Graphics.COLOR_WHITE;
		
	}

}