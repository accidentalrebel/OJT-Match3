package ;
import jkEngine.JKSprite;
import nme.display.DisplayObjectContainer;
/**
 * ...
 * @author Karlo
 */
 
class Tile extends JKSprite
{
	var residentJewel : Jewel;
	var xCoord : Int;
	var yCoord : Int;
	
	public var topNeighbor : Null<Tile>;
	public var rightNeighbor : Null<Tile>;
	public var bottomNeighbor : Null<Tile>;
	public var leftNeighbor : Null<Tile>;
	
	var layerForJewel : DisplayObjectContainer;
	
	public function new(XCoord : Int, YCoord : Int, ?layerForTile : DisplayObjectContainer, ?LayerForJewel : DisplayObjectContainer ) 
	{
		xCoord = XCoord;
		yCoord = YCoord;		
		layerForJewel = LayerForJewel;
		
		objectName = "Tile(" + xCoord + "," + yCoord + ")";
		
		super(xCoord, yCoord, "img/tile.png", layerForTile);
		
		x = xCoord * width;
		y = yCoord * height;
		
		//spawnResident(layerForJewel);
		getNeighbors();
	}
	
	/********************************************************************************
	 * SPAWNING
	 * ******************************************************************************/
	public function spawnResident()
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
}