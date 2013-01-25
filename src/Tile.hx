package ;
import jkEngine.JKButton;
import jkEngine.JKSprite;
import nme.display.DisplayObjectContainer;
/**
 * ...
 * @author Karlo
 */
 
class Tile extends JKSprite
{
	public var topNeighbor : Null<Tile>;
	public var rightNeighbor : Null<Tile>;
	public var bottomNeighbor : Null<Tile>;
	public var leftNeighbor : Null<Tile>;
	
	public var residentJewel : Jewel;
	
	public var xCoord : Int;
	public var yCoord : Int;
		
	var layerForJewel : DisplayObjectContainer;
	
	/********************************************************************************
	 * MAIN
	 * ******************************************************************************/
	public function new(XCoord : Int, YCoord : Int, ?layerForTile : DisplayObjectContainer, ?LayerForJewel : DisplayObjectContainer ) 
	{
		xCoord = XCoord;
		yCoord = YCoord;		
		layerForJewel = LayerForJewel;
		
		objectName = "Tile(" + xCoord + "," + yCoord + ")";
		
		super(xCoord, yCoord, "img/tile.png", layerForTile);
		
		x = xCoord * width;
		y = yCoord * height;
		
		spawnResident();
		getNeighbors();
	}
	
	/********************************************************************************
	 * SPAWNING
	 * ******************************************************************************/
	function spawnResident()
	{
		residentJewel = new Jewel(xCoord, yCoord, this, layerForJewel);
	}	
	
	/********************************************************************************
	 * NEIGHBORS
	 * ******************************************************************************/
	public function getNeighbors()
	{
		var playArea : PlayArea = Registry.game.playArea;
		
		// We get the topNeighbor
		if ( yCoord > 0 )
			topNeighbor = playArea.get(xCoord, yCoord - 1 );
			
		// We get the rightNeighbor
		if ( xCoord < playArea.arrayWidth - 1)
			rightNeighbor = playArea.get(xCoord + 1 , yCoord);
			
		// We get the bottomNeighbor
		if ( yCoord < playArea.arrayHeight - 1 )
			bottomNeighbor = playArea.get(xCoord, yCoord +1 );
			
		// We get the leftNeighbor
		if ( xCoord > 0 )
			leftNeighbor = playArea.get(xCoord - 1, yCoord);
	}
	
	/********************************************************************************
	 * MATCH CHECKING
	 * ******************************************************************************/	
	/**
	 * Checks for a match
	 * @param	canClear	If set to true, it sets the tiles for clearing
	 * @return	true if there is a match, false if there is none
	 */
	 public function checkForMatch(canClear : Bool = true) : Bool
	{
		var isThereAMatch : Bool = false;
		
		// We check vertically ( going to the top )
		if ( topNeighbor != null && topNeighbor.residentJewel != null )
		{
			if ( topNeighbor.residentJewel.currentColor == residentJewel.currentColor )
			{
				if ( topNeighbor.topNeighbor != null && topNeighbor.topNeighbor.residentJewel != null )
				{
					if ( topNeighbor.topNeighbor.residentJewel.currentColor == residentJewel.currentColor )
					{
						if ( canClear )
						{
							Registry.game.playArea.setForClearing(topNeighbor.topNeighbor);
							Registry.game.playArea.setForClearing(topNeighbor);
							Registry.game.playArea.setForClearing(this);
						}
						isThereAMatch = true;
					}
				}
			}
		}
		
		// We check horizontally ( going to the right )
		if ( rightNeighbor != null && rightNeighbor.residentJewel != null )
		{
			if ( rightNeighbor.residentJewel.currentColor == residentJewel.currentColor )
			{
				if ( rightNeighbor.rightNeighbor != null && rightNeighbor.rightNeighbor.residentJewel != null )
				{
					if ( rightNeighbor.rightNeighbor.residentJewel.currentColor == residentJewel.currentColor )
					{
						if ( canClear )
						{
							Registry.game.playArea.setForClearing(rightNeighbor.rightNeighbor);
							Registry.game.playArea.setForClearing(rightNeighbor);
							Registry.game.playArea.setForClearing(this);
						}
						isThereAMatch = true;
					}
				}
			}
		}
		
		return isThereAMatch;
	}
}