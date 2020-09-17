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

	function drawDate(dc, dateLabel) {
	
		// Get the date
       	var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
       	var dateString = Lang.format("$1$ $2$", [today.day_of_week, today.day]);
       	
       	// Calculate position
       	var bigFontHeight = dc.getFontHeight(bigFont);
       	var dateTextWidth = dc.getTextWidthInPixels(dateString, Graphics.FONT_SMALL);
       	var dateLocX = dc.getWidth() / 2 - dateTextWidth - 10;
       	var dateLocY = (dc.getHeight() - bigFontHeight) / 2 - 5;
       	
       	// Set date text
       	dateLabel.setColor(Graphics.COLOR_WHITE);
       	dateLabel.setFont(Graphics.FONT_SMALL);
       	dateLabel.setText(dateString);
       	dateLabel.setLocation(dateLocX, dateLocY);
	
	}

}