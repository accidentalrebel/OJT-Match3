package ;
import jkEngine.JKSprite;
import nme.display.DisplayObjectContainer;
/**
 * ...
 * @author Karlo
 */

class Tile extends JKSprite
{

	public function new(xCoord : Int, yCoord : Int, ?theLayer : DisplayObjectContainer ) 
	{
		super(xCoord, yCoord, "img/tile.png", theLayer);
	}
	
}