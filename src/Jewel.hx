package ;
import jkEngine.JKSprite;
import nme.display.DisplayObjectContainer;

/**
 * ...
 * @author Karlo
 */

class Jewel extends JKSprite
{

	public function new(?theLayer : DisplayObjectContainer) 
	{
		super(0, 0, "img/red.png", theLayer);
		
		//w( xPos : Float = 0, yPos : Float = 0, ?theWidth : Float
		//, ?theHeight : Float, ?graphicFileLocation : String, ?theLayer : DisplayObjectContainer ) 
	}
	
}