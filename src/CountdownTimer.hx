package ;
import jkEngine.JKText;
import nme.display.DisplayObjectContainer;
/**
 * ...
 * @author Karlo
 */

class CountdownTimer extends JKText
{	
	public function new( xPos : Float = 0, yPos : Float = 0, ?layer : DisplayObjectContainer ) 
	{
		super(xPos, yPos, 300, "00:00", 0xFFFFFF, 50, "Arial", layer);
	}	
}