package ;
import jkEngine.JKGame;
import jkEngine.JKSprite;
import jkEngine.JKText;
import nme.events.Event;
import nme.Lib;
/**
 * ...
 * @author Karlo
 */

class Game extends JKGame
{	
	public var playArea : PlayArea;	
	public var isGameOver : Bool = true;	
	var countdownTimer : CountdownTimer;
	var guiArea : JKSprite;	
	public var scoreView : ScoreIndicator;
	
	public function new() 
	{
		Registry.game = this;
		guiArea = new JKSprite();
		scoreView = new ScoreIndicator(260, 20, guiArea);
		countdownTimer = new CountdownTimer(40, 20, guiArea);
		
		super();		
		
		playArea = new PlayArea();
		countdownTimer.startCountdown();
	}
	
	override private function update(e:Event):Void 
	{
		super.update(e);		
	
		if ( keyboard.checkIfKeyPressed(82) && !playArea.isSimulating)
		{			
			playArea.resetBoard();
			playArea.populate();
			countdownTimer.reset();
			scoreView.reset();
			isGameOver = false;
		}
	}
	
	public function gameOver()
	{
		isGameOver = true;
	}
}