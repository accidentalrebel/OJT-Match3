package ;
import jkEngine.JKGame;
import jkEngine.JKSprite;
import nme.events.Event;
import nme.Lib;
/**
 * ...
 * @author Karlo
 */

class Game extends JKGame
{	
	public var playArea : PlayArea;
	var guiArea : JKSprite;
	var countdownTimer : CountdownTimer;
	
	public function new() 
	{
		Registry.game = this;
		guiArea = new JKSprite();				
		countdownTimer = new CountdownTimer(40, 20, guiArea);
		
		super();		
		
		playArea = new PlayArea();
		countdownTimer.startCountdown();
	}
	
	override private function update(e:Event):Void 
	{
		super.update(e);
		
		if ( keyboard.checkIfKeyPressed(65) )
		{
			playArea.displayAllContent();
		}
	}
}