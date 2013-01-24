package ;
import jkengine.JKPoint;
import jkEngine.JKSprite;
import nme.utils.Timer;
import nme.events.TimerEvent;
import nme.display.DisplayObjectContainer;
import com.eclecticdesignstudio.motion.Actuate;
import nme.Lib;

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
	var isMoving = false;
	var movementSpeed : Float = 0.5;
	var movementTimer : Timer;
	
	/********************************************************************************
	 * MAIN
	 * ******************************************************************************/
	public function new(XCoord : Int, YCoord : Int, theParent : Tile, ?theLayer : DisplayObjectContainer) 
	{		
		xCoord = XCoord;
		yCoord = YCoord;
		parentTile = theParent;
		
		objectName = "Jewel(" + xCoord + "," + yCoord + ")";
		
		super(0, 0, theLayer);
				
		loadRandomColor();
		
		x = xCoord * width;
		y = yCoord * height;
		
		movementTimer = new Timer(movementSpeed * 1000, 1);
		movementTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onMovementFinish);
	}
	
	override private function update():Dynamic 
	{
		super.update();
		
		if ( !isMoving && checkIfCanFall() )
		{			
			Lib.trace(" i am falling");
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
	 * MOVEMENT / GRAVITY
	 * ******************************************************************************/
	function checkIfCanFall() : Bool
	{
		if ( yCoord >= Registry.game.playArea.arrayHeight - 1 )		// If we are on the bottom of the playArea
			return false;
		
		if ( parentTile.bottomNeighbor.residentJewel != null )		// If there is nothing below			
			return false;
			
		return true;
	}
	 
	function applyGravity()
	{
		isMoving = true;
		moveTo( new JKPoint(parentTile.bottomNeighbor.x, parentTile.bottomNeighbor.y));
	}
	
	function moveTo( coordinate : JKPoint )
	{
		Actuate.tween(this, movementSpeed, { x : coordinate.x, y : coordinate.y } );			// We tween to position		
		movementTimer.start();
		
		parentTile.residentJewel = null;							// We remove our reference from our old parent tile
		parentTile = parentTile.bottomNeighbor;						// We set our ne parentTile
		parentTile.residentJewel = this;							// We assign ourselves to the new parent tile
		xCoord = parentTile.xCoord;
		yCoord = parentTile.yCoord;
	}
	
	function onMovementFinish(e : TimerEvent)
	{
		isMoving = false;
	}
}