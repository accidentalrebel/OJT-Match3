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
	
	public function new( xPos : Float = 0, yPos : Float = 0, ?layer : DisplayObjectContainer ) 
	{
		timer = new Timer(1000, 0);
		timer.addEventListener(TimerEvent.TIMER, onTimerTick);
		super(xPos, yPos, 300, "00:00", 0xFFFFFF, 50, "Arial", layer);
	}
	
	public function startCountdown()
	{
		timer.start();
	}
	
	function onTimerTick( e: TimerEvent )
	{
		trace("tick");
	}
}