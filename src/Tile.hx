package ;
import jkEngine.JKSprite;
import nme.display.DisplayObjectContainer;
/**
 * ...
 * @author Karlo
 */

class Tile extends JKSprite
{
	public function new(xCoord : Int, yCoord : Int, ?layerForTile : DisplayObjectContainer, ?layerForJewel : DisplayObjectContainer ) 
	{
		super(xCoord, yCoord, "img/tile.png", layerForTile);
		
		x = xCoord * width;
		y = yCoord * height;
	}
}