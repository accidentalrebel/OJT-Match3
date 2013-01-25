package ;
import jkEngine.JKText;
import nme.display.DisplayObjectContainer;
import nme.events.TimerEvent;
import nme.utils.Timer;
/**
 * ...
 * @author Karlo
 */

class CountdownTimer extends JKText
{	
	var timer : Timer;
	var minutes : Float = 2;			
	var seconds : Float = 0;			
	
	public function new( xPos : Float = 0, yPos : Float = 0, ?layer : DisplayObjectContainer ) 
	{		
		timer = new Timer(1000, 0);
		timer.addEventListener(TimerEvent.TIMER, onTimerTick);
		super(xPos, yPos, 300, "00:00", 0xFFFFFF, 50, "Arial", layer);
		
		setTimerText();
	}
	
	public function startCountdown()
	{
		timer.start();
	}
	
	function onTimerTick( e: TimerEvent )
	{
		seconds--;						// We decrease the timerValue
		if ( seconds < 0 )
		{
			seconds = 59;
			minutes--;
		}
		
		if ( seconds <= 0 && minutes <= 0 )
		{
			timer.stop();
			trace("timer has ended");
			Registry.game.gameOver();
		}
		
		setTimerText();		
	}
		
	
	function setTimerText()
	{
		var secondsText : String = "";
		var minutesText : String = "";
		if ( seconds < 10 )
			secondsText = "0" + Std.string(seconds);
		else
			secondsText = Std.string(seconds);
		
		if ( minutes < 10 )
			minutesText = "0" + Std.string(minutes);
		else
			minutesText = Std.string(minutes);
			
		setText(minutesText + ":" + secondsText);
	}
	
	public function reset()
	{
		seconds = 0;
		minutes = 2;
		setTimerText();
	}
}