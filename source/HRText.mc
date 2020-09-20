using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module HRText {

	var bigFont = WatchUi.loadResource(Rez.Fonts.big_filled_font);
	var font = WatchUi.loadResource(Rez.Fonts.complication_font);
	
	var hrLocX;
	var hrLocY;
	var heartRate;

	function drawHR(dc, position) {
	
		heartRate = 0;
	
		// Get HR
       	var hrIter = ActivityMonitor.getHeartRateHistory(null, true);
        if(hrIter != null){
            var hr = hrIter.next();
            heartRate = (hr.heartRate != ActivityMonitor.INVALID_HR_SAMPLE && hr.heartRate > 0) ? hr.heartRate : 0;
        }
        var hrString = Lang.format("HR: $1$", [heartRate.toString()]);
       	
       	// Calculate position
       	var bigFontHeight = dc.getFontHeight(bigFont);
       	var hrTextWidth = dc.getTextWidthInPixels(hrString, font);
       	if (position == 0) {// Left
       		hrLocX = dc.getWidth() / 2 - hrTextWidth - 10;
       	} else { // Right
       		hrLocX = dc.getWidth() / 2 + 10;
       	}
       	hrLocY = (dc.getHeight() - bigFontHeight) / 2 - 5;
       	
       	// Set date text
       	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
       	dc.drawText(hrLocX, hrLocY, font, hrString, Graphics.TEXT_JUSTIFY_LEFT);
	
	}

}