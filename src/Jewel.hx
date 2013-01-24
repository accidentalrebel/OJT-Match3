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
		
		super(0, 0, theLayer);
				
		loadRandomColor();
		
		x = xCoord * width;
		y = yCoord * height;
	}
	
	/********************************************************************************
	 * INITIALIZATION
	 * ******************************************************************************/
	function loadRandomColor()
	{
		var rolled : Int = Std.int(Math.random() * 7);
		switch(rolled)
		{
			case 0 : loadGraphic("img/red.png"); 
			case 1 : loadGraphic("img/green.png");
			case 2 : loadGraphic("img/orange.png");
			case 3 : loadGraphic("img/pink.png");
			case 4 : loadGraphic("img/blue.png");
			case 5 : loadGraphic("img/white.png");
			case 6 : loadGraphic("img/yellow.png");
		}
	}
}