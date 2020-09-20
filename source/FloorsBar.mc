using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module FloorsBar {

	var maxWidth;
	var fillWidth;
	var bigFont = WatchUi.loadResource(Rez.Fonts.big_filled_font);
	var accentColor;

	function drawBar(dc) {
	
		accentColor = Application.getApp().getProperty("AccentColor");
		
		// Calculate position
		maxWidth = dc.getWidth() * 0.7;
		var barLocX = (dc.getWidth() - maxWidth) / 2;
		var barLocY = (dc.getHeight() + dc.getFontHeight(bigFont)) / 2 - 20;
		
		// Calculate percentage
		var activityInfo = ActivityMonitor.getInfo();
		var activityHistory = ActivityMonitor.getHistory();
		var currentFloors = activityInfo.floorsClimbed.toFloat();
		var goal = activityInfo.floorsClimbedGoal.toFloat();
		var percentage = currentFloors / goal;
		percentage = (percentage >= 1) ? 1 : percentage;
		
		// Draw background bar
		dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
		dc.fillPolygon([
			[barLocX + 3, barLocY], //LU
			[barLocX, barLocY + 6], //LD
			[barLocX + maxWidth - 3, barLocY + 6], //RD
			[barLocX + maxWidth, barLocY] //RU
		]);
		
		//Draw foreground bar
		dc.setColor(accentColor, Graphics.COLOR_BLACK);
		dc.fillPolygon([
			[barLocX + 3, barLocY], //LU
			[barLocX, barLocY + 6], //LD
			[barLocX + maxWidth * percentage - 3, barLocY + 6], //RD
			[barLocX + maxWidth * percentage, barLocY] //RU
		]);
		
		//Draw Triangles
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
		dc.fillPolygon([
			[barLocX + maxWidth * percentage + 3, barLocY - 8], // U
			[barLocX + maxWidth * percentage - 8, barLocY + 13], // L
			[barLocX + maxWidth * percentage + 14, barLocY + 13] // R
		]);
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
		dc.fillPolygon([
			[barLocX + maxWidth * percentage + 3, barLocY - 3], // U
			[barLocX + maxWidth * percentage - 3, barLocY + 9], // L
			[barLocX + maxWidth * percentage + 9, barLocY + 9] // R
		]);
		
		// Draw text
		var font = WatchUi.loadResource(Rez.Fonts.accent_font);
		var smallFontHeight = dc.getFontHeight(font);
		var floorsString = Lang.format("Fl. climbed $1$/$2$", [currentFloors.toNumber(), goal.toNumber()]);
		var textWidth = dc.getTextWidthInPixels(floorsString, font);
		var textLocX = dc.getWidth() / 2;
		var textLocY = barLocY + 9;
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
		dc.drawText(textLocX, textLocY, font, floorsString, Graphics.TEXT_JUSTIFY_CENTER);
	}

}