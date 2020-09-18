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
			dc.drawBitmap(dc.getWidth() / 2 - 7.5, dc.getHeight() - 15, icons[0]);
		} else if (numberToDisplay == 2) {
		
			var x = dc.getWidth() / 2 - 17;
			dc.drawBitmap(x, getYOnCircle(x, dc.getWidth() / 2) - 15, icons[0]);
			dc.drawBitmap(x + 19, getYOnCircle(x, dc.getWidth() / 2) - 15, icons[1]);
			
		} else if (numberToDisplay == 3) {
			
			var x = dc.getWidth() / 2;
			dc.drawBitmap(x - 7.5, dc.getHeight() - 15, icons[0]);
			dc.drawBitmap(x - 25, getYOnCircle(x - 25, dc.getWidth() / 2) - 15, icons[1]);
			dc.drawBitmap(x + 12.5, getYOnCircle(x + 12.5, dc.getWidth() / 2) - 15, icons[2]);
			
		} else if (numberToDisplay == 4) {
			
			var x = dc.getWidth() / 2;
			dc.drawBitmap(x - 31, getYOnCircle(x - 31, dc.getWidth() / 2) - 15, icons[0]);
			dc.drawBitmap(x - 17, getYOnCircle(x - 17, dc.getWidth() / 2) - 15, icons[1]);
			dc.drawBitmap(x + 2, getYOnCircle(x + 2, dc.getWidth() / 2) - 15, icons[2]);
			dc.drawBitmap(x + 19, getYOnCircle(x + 19, dc.getWidth() / 2) - 15, icons[3]);
			
		}
	
	}
	
	function getYOnCircle(x, radius) {
		x = x - radius;
		var y = Math.sqrt((radius * radius) - (x * x));
		return y + radius;
	}

}