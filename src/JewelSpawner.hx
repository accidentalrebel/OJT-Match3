package;
import nme.display.DisplayObjectContainer;
import nme.utils.Timer;
import nme.events.TimerEvent;
/**
 * ...
 * @author Karlo
 */

class JewelSpawner extends Tile
{
	var spawnTimer : Timer;
	
	public function new(XCoord : Int, YCoord : Int, ?LayerForTile : DisplayObjectContainer, ?LayerForJewel : DisplayObjectContainer ) 
	{		
		super(XCoord, YCoord, LayerForTile, LayerForJewel);
		
		objectName = "Spwn(" + xCoord + "," + yCoord + ")";
	}
	
	public function spawnJewels( numToSpawn : Int )
	{
		if ( numToSpawn <= 0 )
			return;
		
		if ( numToSpawn > 8 )
			numToSpawn = 8;
				
		spawnTimer = new Timer(500, numToSpawn);
		spawnTimer.addEventListener(TimerEvent.TIMER, spawnAJewel);
		spawnTimer.start();
	}
	
	function spawnAJewel(e: TimerEvent)
	{
		spawnResident();
	}
}