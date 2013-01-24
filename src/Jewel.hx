package ;
import jkEngine.JKSprite;
import nme.display.DisplayObjectContainer;

/**
 * ...
 * @author Karlo
 */

class Jewel extends JKSprite
{
	var xCoord : Int;
	var yCoord : Int;
	
	public function new(XCoord : Int, YCoord : Int, ?theLayer : DisplayObjectContainer) 
	{
		xCoord = XCoord;
		yCoord = YCoord;
		
		super(0, 0, "img/red.png", theLayer);
		
		x = xCoord * width;
		y = yCoord * height;
		
		//w( xPos : Float = 0, yPos : Float = 0, ?theWidth : Float
		//, ?theHeight : Float, ?graphicFileLocation : String, ?theLayer : DisplayObjectContainer ) 
	}
	
}