package ;
import jkEngine.JKText;
import nme.display.DisplayObjectContainer;
import nme.text.TextFormatAlign;
/**
 * ...
 * @author Karlo
 */

class ScoreIndicator extends JKText
{

	public function new(xPos : Float = 0, yPos : Float = 0, ?layer : DisplayObjectContainer) 
	{
		super(xPos, yPos, 100, "0", 0xFFFFFF, 50, TextFormatAlign.RIGHT, "Arial", layer);
	}
	
}