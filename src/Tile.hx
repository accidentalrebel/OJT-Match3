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
	
	var layerForJewel : DisplayObjectContainer;
	
	public function new(XCoord : Int, YCoord : Int, ?layerForTile : DisplayObjectContainer, ?LayerForJewel : DisplayObjectContainer ) 
	{
		xCoord = XCoord;
		yCoord = YCoord;		
		layerForJewel = LayerForJewel;
		
		super(xCoord, yCoord, "img/tile.png", layerForTile);
		
		x = xCoord * width;
		y = yCoord * height;
		
		//spawnResident(layerForJewel);
	}
	
	/********************************************************************************
	 * SPAWNING
	 * ******************************************************************************/
	public function spawnResident()
	{
		residentJewel = new Jewel(xCoord, yCoord, this, layerForJewel);
	}
	
	
}