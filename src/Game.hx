package ;
import jkEngine.JKGame;
import jkEngine.JKSprite;
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
}