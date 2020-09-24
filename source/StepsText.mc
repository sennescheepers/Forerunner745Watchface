using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;
 
module StepsText {

	var accentColor;
	var useAccentColor;
	
	var icon = "K";
	var iconWidth;
	
	var distanceLocX;
	var distanceLocY;

	function drawText(dc, position) {
	
		// Get the steps
		var info = ActivityMonitor.getInfo();
		var steps = info.steps.toNumber();
		var stepsString = Lang.format("$1$", [steps]);
       	
       	// Calculate position
       	var bigFontHeight = dc.getFontHeight(Fonts.bigFilledFont);
       	var distanceTextWidth = dc.getTextWidthInPixels(stepsString, Fonts.complicationFont);
       	iconWidth = dc.getTextWidthInPixels(icon, Fonts.iconFont);
       	if (position == 0) {// Left
       		distanceLocX = dc.getWidth() / 2 - distanceTextWidth - iconWidth - 10;
       	} else { // Right
       		distanceLocX = dc.getWidth() / 2 + 10;
       	}
       	distanceLocY = (dc.getHeight() - bigFontHeight) / 2 - 5;
       	
       	// Set date text
       	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
       	dc.drawText(distanceLocX + 5 + iconWidth, distanceLocY, Fonts.complicationFont, stepsString, Graphics.TEXT_JUSTIFY_LEFT);
       	dc.setColor(accentColor, Graphics.COLOR_BLACK);
       	dc.drawText(distanceLocX, distanceLocY, Fonts.iconFont, icon, Graphics.TEXT_JUSTIFY_LEFT);
 	
 	}

	function setSettings() {
	
		useAccentColor = Application.getApp().getProperty("AccentColorComplication");
		accentColor = (useAccentColor) ? Application.getApp().getProperty("AccentColor") : Graphics.COLOR_WHITE;
		
	}
 
 }