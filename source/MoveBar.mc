using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module MoveBar {

	var maxWidth;
	var fillWidth;
	var accentColor;

	function drawBar(dc) {
		
		// Calculate position
		maxWidth = dc.getWidth() * 0.7;
		var barLocX = (dc.getWidth() - maxWidth) / 2;
		var barLocY = (dc.getHeight() + dc.getFontHeight(Fonts.bigFilledFont)) / 2 - 20;
		
		// Calculate percentage
		var activityInfo = ActivityMonitor.getInfo();
		var current = activityInfo.moveBarLevel.toFloat();
		var total = activityInfo.MOVE_BAR_LEVEL_MAX - activityInfo.MOVE_BAR_LEVEL_MIN;
		var percentage = current / total;
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
		/*var smallFontHeight = dc.getFontHeight(Fonts.accentFont);
		var stepsString = Lang.format("Steps $1$/$2$", [currentSteps.toNumber(), goal.toNumber()]);
		var textWidth = dc.getTextWidthInPixels(stepsString, Fonts.accentFont);
		var textLocX = dc.getWidth() / 2;
		var textLocY = barLocY + 9;
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
		dc.drawText(textLocX, textLocY, Fonts.accentFont, stepsString, Graphics.TEXT_JUSTIFY_CENTER);*/
	
	}
	
	function setSettings() {
	
		accentColor = Application.getApp().getProperty("AccentColor");
	
	}

}