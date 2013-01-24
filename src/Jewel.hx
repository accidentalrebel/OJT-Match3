package ;
import jkEngine.JKSprite;
import nme.display.DisplayObjectContainer;

/**
 * ...
 * @author Karlo
 */
 
enum JewelColor 
{
	blue;
	green;
	orange;
	pink;
	red;
	white;
	yellow;
}
 
class Jewel extends JKSprite
{
	var xCoord : Int;
	var yCoord : Int;
	var currentColor : JewelColor;
	var parentTile : Tile;
	
	/********************************************************************************
	 * MAIN
	 * ******************************************************************************/
	public function new(XCoord : Int, YCoord : Int, theParent : Tile, ?theLayer : DisplayObjectContainer) 
	{		
		xCoord = XCoord;
		yCoord = YCoord;
		theParent = parentTile;
		
		super(0, 0, theLayer);
				
		loadRandomColor();
		
		x = xCoord * width;
		y = yCoord * height;
	}
	
	override private function update():Dynamic 
	{
		super.update();
		
		if ( checkIfCanFall() )
		{
			applyGravity();
		}
	}
	
	/********************************************************************************
	 * INITIALIZATION
	 * ******************************************************************************/
	function loadRandomColor()
	{
		var rolled : Int = Std.int(Math.random() * 7);
		switch(rolled)
		{
			case 0 : 
				loadGraphic("img/red.png");
				currentColor = JewelColor.red;	
			case 1 : 
				loadGraphic("img/green.png");
				currentColor = JewelColor.green;
			case 2 :
				loadGraphic("img/orange.png");
				currentColor = JewelColor.orange;
			case 3 : 
				loadGraphic("img/pink.png");
				currentColor = JewelColor.pink;
			case 4 : 
				loadGraphic("img/blue.png");
				currentColor = JewelColor.blue;
			case 5 : 
				loadGraphic("img/white.png");
				currentColor = JewelColor.white;
			case 6 : 
				loadGraphic("img/yellow.png");
				currentColor = JewelColor.yellow;
		}
	}	
	
	/********************************************************************************
	 * MOVEMENT
	 * ******************************************************************************/
	function checkIfCanFall() : Bool
	{
		return false;
	}
	 
	function applyGravity()
	{
		
	}
}