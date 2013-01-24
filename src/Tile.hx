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
	
	public function new(XCoord : Int, YCoord : Int, ?layerForTile : DisplayObjectContainer, ?layerForJewel : DisplayObjectContainer ) 
	{
		xCoord = XCoord;
		yCoord = YCoord;		
		
		super(xCoord, yCoord, "img/tile.png", layerForTile);
		
		x = xCoord * width;
		y = yCoord * height;
		
		spawnResident(layerForJewel);
	}
	
	/********************************************************************************
	 * SPAWNING
	 * ******************************************************************************/
	function spawnResident(layerForJewel : DisplayObjectContainer)
	{
		residentJewel = new Jewel(xCoord, yCoord, layerForJewel);
	}
	
	
}