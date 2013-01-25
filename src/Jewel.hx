package ;
import jkEngine.JKButton;
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
 
class Jewel extends JKButton
{
	var xCoord : Int;
	var yCoord : Int;
	public var isCleared : Bool = false;
	
	public var parentTile : Tile;
	public var isMoving = false;	
	var movementSpeed : Float = 0.5;
	var movementTimer : Timer;
	
	public var currentColor : JewelColor;
	
	/********************************************************************************
	 * MAIN
	 * ******************************************************************************/
	public function new(XCoord : Int, YCoord : Int, theParent : Tile, ?theLayer : DisplayObjectContainer) 
	{		
		xCoord = XCoord;
		yCoord = YCoord;
		parentTile = theParent;
		
		objectName = "Jewl(" + xCoord + "," + yCoord + ")";
		
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
		
		if ( Registry.game.playArea.isClearing || isCleared)
			return;
		
		// Checking if can fall
		if ( !isMoving && checkIfCanFall() )
		{	
			applyGravity();
			
			// If after moving we cannot fall anymore
			//if ( !checkIfCanFall() )
			//{
				//Lib.trace("I cannot fall anymore");
				//Registry.game.playArea.checkForMatches();
			//}
		}
		
		// Checking for click
		if ( !isMoving && isClicked )
		{
			Registry.game.playArea.selectTile(parentTile);
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
	
	function onMovementFinish(e : TimerEvent)
	{
		isMoving = false;
		Registry.game.playArea.jewelsSimulating.remove(this);
	}
	
	function moveTo( coordinate : JKPoint )
	{
		Registry.game.playArea.jewelsSimulating.push(this);
		Registry.game.playArea.isSimulating = true;
		
		Actuate.tween(this, movementSpeed, { x : coordinate.x, y : coordinate.y } );					// We tween to position		
		movementTimer.start();
		
		parentTile.residentJewel = null;							// We remove our reference from our old parent tile
		parentTile = parentTile.bottomNeighbor;						// We set our ne parentTile
		parentTile.residentJewel = this;							// We assign ourselves to the new parent tile
		
		updateMapPosition();
		Lib.trace(objectName + "moved down to " + xCoord + "," + yCoord );
	}
	
	public function switchWith( jewelToSwitchWith : Jewel )
	{	
		var tempX = x;
		var tempY = y;		
		
		var tempTile : Dynamic = jewelToSwitchWith.parentTile;
		jewelToSwitchWith.parentTile = parentTile;
		parentTile.residentJewel = jewelToSwitchWith;		
		parentTile = tempTile;
		parentTile.residentJewel = this;
		
		this.updateMapPosition();
		jewelToSwitchWith.updateMapPosition();
		
		// We then check if there is a match after the move
		if ( Registry.game.playArea.checkForMatches(false) )							
		{	
			// We finalize the change in position
			movementTimer.start();
			Actuate.tween(this, movementSpeed, { x : jewelToSwitchWith.x, y : jewelToSwitchWith.y }, true);		// We tween to position		
			Actuate.tween(jewelToSwitchWith, movementSpeed, { x : tempX, y : tempY }, true );						// We tween to position		
		}
		else // If not a valid move
		{
			// We revert back to its original position
			tempTile = jewelToSwitchWith.parentTile;
			jewelToSwitchWith.parentTile = parentTile;
			parentTile.residentJewel = jewelToSwitchWith;		
			parentTile = tempTile;
			parentTile.residentJewel = this;
		}
	}
	
	function updateMapPosition()
	{
		xCoord = parentTile.xCoord;
		yCoord = parentTile.yCoord;
	}
	
	/********************************************************************************
	 * DESTROY / CLEAR
	 * ******************************************************************************/
	public function clear()
	{		
		Lib.trace(objectName + " i am being cleared!");
		isCleared = true;
		parentTile.residentJewel = null;
		destroy();
	}
}