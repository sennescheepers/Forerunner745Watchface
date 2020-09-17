using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.UserProfile;
using Toybox.ActivityMonitor;

class Forerunner745WatchFaceView extends WatchUi.WatchFace {

	var bigFont = WatchUi.loadResource(Rez.Fonts.big_filled_font);

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    	dc.clear();
    
    	var hourLabel = View.findDrawableById("hourLabel");
    	var minutesLabel = View.findDrawableById("minutesLabel");
    	var secondsLabel = View.findDrawableById("secondsLabel");
    	TimeText.drawTime(dc, hourLabel, minutesLabel, secondsLabel);
    	
        var dateLabel = View.findDrawableById("dateLabel");
        DateText.drawDate(dc, dateLabel);
        
        // Display upper right complication
        // 0: empty
        // 1: battery
        /*var upperRightComplication = Application.getApp().getProperty("UpperRightComplication");
        var upperRightComplicationLabel = View.findDrawableById("upperRightComplication");
		var bigFontHeight = dc.getFontHeight(bigFont);
        var locX = dc.getWidth() / 2 + 5;
        var locY = (dc.getHeight() - bigFontHeight) / 2 - 5;
        if (upperRightComplication == 1) {
        	BatteryText.drawBattery(upperRightComplicationLabel, locX, locY);
        }*/
        
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        // Display big complication
        // 0: Weekly active minutes
        // 1: Daily steps/goal
        // 2: Daily burned calories/goal
        var bigComplication = Application.getApp().getProperty("BigComplication");
        if (bigComplication == 0) {
        	IntensityMinutesBar.drawBar(dc);
        } else if (bigComplication == 1) {
        	StepsBar.drawBar(dc);
        } else if (bigComplication == 2) {
        	CaloriesBar.drawBar(dc);
        }
        
        // Display status icons
        StatusIcons.drawIcons(dc);
        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    	TimeText.lowPower = false;
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    	TimeText.lowPower = true;
    }

}
