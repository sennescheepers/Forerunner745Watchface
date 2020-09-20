using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module DateText {

	var bigFont = WatchUi.loadResource(Rez.Fonts.big_filled_font);
	var font = WatchUi.loadResource(Rez.Fonts.complication_font);
	
	var dateLocX;
	var dateLocY;

	function drawDate(dc, position) {
	
		// Get the date
       	var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
       	var dateString = Lang.format("$1$ $2$", [today.day_of_week, today.day]);
       	
       	// Calculate position
       	var bigFontHeight = dc.getFontHeight(bigFont);
       	var dateTextWidth = dc.getTextWidthInPixels(dateString, font);
       	if (position == 0) {// Left
       		dateLocX = dc.getWidth() / 2 - dateTextWidth - 10;
       	} else { // Right
       		dateLocX = dc.getWidth() / 2 + 10;
       	}
       	dateLocY = (dc.getHeight() - bigFontHeight) / 2 - 5;
       	
       	// Set date text
       	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
       	dc.drawText(dateLocX, dateLocY, font, dateString, Graphics.TEXT_JUSTIFY_LEFT);
	
	}

}