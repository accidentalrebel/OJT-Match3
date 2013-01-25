package ;
import jkEngine.JKGame;
import jkEngine.JKSprite;
import jkEngine.JKText;
import nme.events.Event;
import nme.Lib;
import nme.text.TextFormatAlign;
/**
 * ...
 * @author Karlo
 */

class Game extends JKGame
{	
	public var playArea : PlayArea;	
	public var isGameOver : Bool = false;	
	var countdownTimer : CountdownTimer;
	var guiArea : JKSprite;	
	var scoreView : JKText;
	var scoreCount : Int;	
	
	public function new() 
	{
		Registry.game = this;
		guiArea = new JKSprite();
		scoreView = new JKText(260, 20, 100, "0", 0xFFFFFF, 50, TextFormatAlign.RIGHT, "Arial", guiArea);
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
	
	public function gameOver()
	{
		isGameOver = true;
	}
}