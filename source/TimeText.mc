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
	
	var bigFilledFont = WatchUi.loadResource(Rez.Fonts.big_filled_font);
	var bigOutlineFont = WatchUi.loadResource(Rez.Fonts.big_outline_font);
	var smallFilledFont = WatchUi.loadResource(Rez.Fonts.small_filled_font);
	
	var hourColor;
	var minutesColor;
	var secondsColor;
	var hourFilled;
	var minutesFilled;
	var displaySeconds;
	
	function drawTime(dc, hourLabel, minutesLabel, secondsLabel) {
	
		hourColor = Application.getApp().getProperty("HourColor");
		minutesColor = Application.getApp().getProperty("MinutesColor");
		secondsColor = Application.getApp().getProperty("SecondsColor");
		hourFilled = Application.getApp().getProperty("HourFilled");
		minutesFilled = Application.getApp().getProperty("MinutesFilled");
		displaySeconds = Application.getApp().getProperty("DisplaySeconds");
		
		// Deciding fonts
		if (hourFilled) {
			hourFont = bigFilledFont;
		} else {
			hourFont = bigOutlineFont;
		}
		if (minutesFilled) {
			minutesFont = bigFilledFont;
		} else {
			minutesFont = bigOutlineFont;
		}
		
		secondsFont = smallFilledFont;
		
		// Get the time information
		var time = Time.now();
		var moment = Gregorian.info(time, Time.FORMAT_LONG);
		var hourString = moment.hour.format("%02d");
		var minutesString = moment.min.format("%02d");
		var secondsString = (displaySeconds && !lowPower && System.getDeviceSettings().screenWidth >= 240) ? moment.sec.format("%02d") : "";
		
		// Getting text widths and heights
		textWidthHour = dc.getTextWidthInPixels(hourString, hourFont);
		textWidthMinutes = dc.getTextWidthInPixels(minutesString, minutesFont);
		textWidthSeconds = dc.getTextWidthInPixels(secondsString, secondsFont);
		
		textHeightBig = dc.getFontHeight(hourFont);
		textHeightSmall = dc.getFontHeight(secondsFont);
		
		// Calculating text postions
		var timeWidth = textWidthHour + textWidthMinutes + textWidthSeconds;
		var hourLocX = (dc.getWidth() - timeWidth) / 2;
		var hourLocY = (dc.getHeight() - textHeightBig) / 2 - 5;
		var minutesLocX = (dc.getWidth() - timeWidth) / 2 + textWidthHour;
		var minutesLocY = (dc.getHeight() - textHeightBig) / 2 - 5;
		var secondsLocX = (dc.getWidth() - timeWidth) / 2 + textWidthHour + textWidthMinutes + 2;
		var secondsLocY = (dc.getHeight() - textHeightSmall) / 2 - 5;
		
		// Setting hour text
		hourLabel.setText(hourString);
		hourLabel.setFont(hourFont);
		hourLabel.setColor(hourColor);
		hourLabel.setLocation(hourLocX, hourLocY);
		
		// Setting minutes text
		minutesLabel.setText(minutesString);
		minutesLabel.setFont(minutesFont);
		minutesLabel.setColor(minutesColor);
		minutesLabel.setLocation(minutesLocX, minutesLocY);
		
		// Setting seconds text
		secondsLabel.setText(secondsString);
		secondsLabel.setFont(secondsFont);
		secondsLabel.setColor(secondsColor);
		secondsLabel.setLocation(secondsLocX, secondsLocY);
		
	}
	
}