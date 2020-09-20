using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module TimeText {

	var lowPower = false;
	
	var textWidthHour;
	var textWidthMinutes;
	var textWidthSeconds;
	var textHeightBig;
	var textHeightSmall;
	
	var hourFont;
	var minutesFont;
	var secondsFont;
	
	//var bigFilledFont = WatchUi.loadResource(Rez.Fonts.big_filled_font);
	//var bigOutlineFont = WatchUi.loadResource(Rez.Fonts.big_outline_font);
	//var smallFilledFont = WatchUi.loadResource(Rez.Fonts.small_filled_font);
	
	var hourColor;
	var minutesColor;
	var secondsColor;
	var hourFilled;
	var minutesFilled;
	var displaySeconds;
	
	function drawTime(dc) {
	
		hourColor = Application.getApp().getProperty("HourColor");
		minutesColor = Application.getApp().getProperty("MinutesColor");
		secondsColor = Application.getApp().getProperty("SecondsColor");
		hourFilled = Application.getApp().getProperty("HourFilled");
		minutesFilled = Application.getApp().getProperty("MinutesFilled");
		displaySeconds = Application.getApp().getProperty("DisplaySeconds");
		
		secondsFont = Fonts.smallFilledFont;
		
		// Get the time information
		var moment = Gregorian.info(Time.now(), Time.FORMAT_LONG);
		var hourString = moment.hour.format("%02d");
		var minutesString = moment.min.format("%02d");
		var secondsString = (displaySeconds && !lowPower && System.getDeviceSettings().screenWidth >= 240) ? moment.sec.format("%02d") : "";
		
		// Getting text widths and heights
		textWidthHour = dc.getTextWidthInPixels(hourString, Fonts.bigFilledFont);
		textWidthMinutes = dc.getTextWidthInPixels(minutesString, Fonts.bigFilledFont);
		textWidthSeconds = dc.getTextWidthInPixels(secondsString, Fonts.smallFilledFont);
		
		textHeightBig = dc.getFontHeight(Fonts.bigFilledFont);
		textHeightSmall = dc.getFontHeight(Fonts.smallFilledFont);
		
		// Calculating text postions
		var timeWidth = textWidthHour + textWidthMinutes + textWidthSeconds;
		var hourLocX = (dc.getWidth() - timeWidth) / 2;
		var hourLocY = (dc.getHeight() - textHeightBig) / 2 - 5;
		var minutesLocX = (dc.getWidth() - timeWidth) / 2 + textWidthHour;
		var minutesLocY = (dc.getHeight() - textHeightBig) / 2 - 5;
		var secondsLocX = (dc.getWidth() - timeWidth) / 2 + textWidthHour + textWidthMinutes + 2;
		var secondsLocY = (dc.getHeight() - textHeightSmall) / 2 - 5;
		
		// Deciding fonts
		if (hourFilled) {
			dc.setColor(hourColor, Graphics.COLOR_BLACK);
			dc.drawText(hourLocX, hourLocY, Fonts.bigFilledFont, hourString, Graphics.TEXT_JUSTIFY_LEFT);
		} else {
			dc.setColor(hourColor, Graphics.COLOR_BLACK);
			dc.drawText(hourLocX, hourLocY, Fonts.bigOutlineFont, hourString, Graphics.TEXT_JUSTIFY_LEFT);
		}
		if (minutesFilled) {
			dc.setColor(minutesColor, Graphics.COLOR_BLACK);
			dc.drawText(minutesLocX, minutesLocY, Fonts.bigFilledFont, minutesString, Graphics.TEXT_JUSTIFY_LEFT);
		} else {
			dc.setColor(minutesColor, Graphics.COLOR_BLACK);
			dc.drawText(minutesLocX, minutesLocY, Fonts.bigOutlineFont, minutesString, Graphics.TEXT_JUSTIFY_LEFT);
		}
		
		dc.setColor(secondsColor, Graphics.COLOR_BLACK);
		dc.drawText(secondsLocX, secondsLocY, Fonts.smallFilledFont, secondsString, Graphics.TEXT_JUSTIFY_LEFT);
		
	}
	
}