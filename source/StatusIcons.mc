using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module StatusIcons {

	var isSemiRound = Application.getApp().getProperty("SemiRoundDisplay");
	var _dc;
	var bigFontHeight;
	var smallFontHeight;
	var bigFont = WatchUi.loadResource(Rez.Fonts.big_filled_font);
	var smallFont = Graphics.FONT_SMALL;

	var settings = System.getDeviceSettings();
	var isConnected = settings.phoneConnected;
	var alarmEnabled = settings.alarmCount > 0;
	var doNotDisturb = settings.doNotDisturb;
	var notificationCount = settings.notificationCount;
	
	var phoneIcon = WatchUi.loadResource(Rez.Drawables.PhoneIcon);
	var alarmIcon = WatchUi.loadResource(Rez.Drawables.AlarmIcon);
	var notificationIcons = [WatchUi.loadResource(Rez.Drawables.OneNotificationIcon), WatchUi.loadResource(Rez.Drawables.TwoNotificationIcon), WatchUi.loadResource(Rez.Drawables.ThreeNotificationIcon),
							WatchUi.loadResource(Rez.Drawables.FourNotificationIcon), WatchUi.loadResource(Rez.Drawables.FiveNotificationIcon), WatchUi.loadResource(Rez.Drawables.SixNotificationIcon),
							WatchUi.loadResource(Rez.Drawables.SevenNotificationIcon), WatchUi.loadResource(Rez.Drawables.EightNotificationIcon), WatchUi.loadResource(Rez.Drawables.NineNotificationIcon),
							WatchUi.loadResource(Rez.Drawables.MoreNotificationIcon)];
	var doNotDisturbIcon = WatchUi.loadResource(Rez.Drawables.DoNotDisturbIcon);
	
	var icons = new [4];

	function drawIcons(dc) {
	
		_dc = dc;
		bigFontHeight = dc.getFontHeight(bigFont);
		smallFontHeight = dc.getFontHeight(smallFont);
	
		var numberToDisplay = 0;
	
		if (isConnected) {
			icons[numberToDisplay] = phoneIcon;
			numberToDisplay++;
		}
		if (alarmEnabled) {
			icons[numberToDisplay] = alarmIcon;
			numberToDisplay++;
		}
		if (doNotDisturb) {
			icons[numberToDisplay] = doNotDisturbIcon;
			numberToDisplay++;
		}
		if (notificationCount > 0) {
			icons[numberToDisplay] = notificationIcons[notificationCount - 1];
			numberToDisplay++;
		}
		
		if (numberToDisplay == 1) {
			var x = dc.getWidth() / 2;
			dc.drawBitmap(x - 7.5, getY(x - 7.5, dc.getHeight() / 2) - 17, icons[0]);
		} else if (numberToDisplay == 2) {
		
			var x = dc.getWidth() / 2;
			dc.drawBitmap(x - 17, getY(x - 2, dc.getHeight() / 2) - 17, icons[0]);
			dc.drawBitmap(x + 2, getY(x + 2, dc.getHeight() / 2) - 15, icons[1]);
			
		} else if (numberToDisplay == 3) {
			
			var x = dc.getWidth() / 2;
			if (isSemiRound) {x += 26.5;}
			dc.drawBitmap(x - 7.5, getY(x - 7.5, dc.getHeight() / 2) - 17, icons[0]);
			dc.drawBitmap(x - 26.5, getY(x - 26.5, dc.getHeight() / 2) - 17, icons[1]);
			dc.drawBitmap(x + 11.5, getY(x + 26.5, dc.getHeight() / 2) - 17, icons[2]);
			
		} else if (numberToDisplay == 4) {
			
			var x = dc.getWidth() / 2;
			if (isSemiRound) {x += 36;}
			dc.drawBitmap(x - 36, getY(x - 36, dc.getHeight() / 2) - 17, icons[0]);
			dc.drawBitmap(x - 17, getY(x - 2, dc.getHeight() / 2) - 17, icons[1]);
			dc.drawBitmap(x + 2, getY(x + 2, dc.getHeight() / 2) - 17, icons[2]);
			dc.drawBitmap(x + 21, getY(x + 36, dc.getHeight() / 2) - 17, icons[3]);
			
		}
	
	}
	
	function getY(x, radius) {
		if (isSemiRound) {return (_dc.getHeight() - bigFontHeight) / 2 + 17 + smallFontHeight / 2 - 8;} // 5 + 17 (original)
		x = x - radius;
		var y = Math.sqrt((radius * radius) - (x * x));
		return y + radius;
	}

}