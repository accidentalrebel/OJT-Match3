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
	
	public function new() 
	{
		Registry.game = this;
		
		super();
		
		playArea = new PlayArea();
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