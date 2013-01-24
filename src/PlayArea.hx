package ;
import jkEngine.JK2DArray;
import jkEngine.JKSprite;

/**
 * ...
 * @author Karlo
 */

class PlayArea extends JK2DArray
{
	var layerFG : JKSprite;
	var layerBG : JKSprite;
	
	public function new() 
	{			
		Registry.game.playArea = this;
		
		layerBG = new JKSprite(this);
		layerFG = new JKSprite(this);
		
		super(8, 8, null);
		
		x = 40;
		y = 40;
		
		populate();
		getNeighbors();
		
		var colSpawner0 : Dynamic = get(0, 0);
		trace(colSpawner0.objectName);
		colSpawner0.spawnJewels(5);
		
		var theTile : Tile = get(3, 4);
		theTile.spawnResident();
		theTile = get(3, 3);
		theTile.spawnResident();
	}	
	
	/********************************************************************************
	 * POPULATING
	 * ******************************************************************************/
	override public function populate(?toPopulateWith:Dynamic):Dynamic 
	{
		for ( i in 0...arrayWidth )
		{
			for ( j in 0...arrayHeight )
			{				
				if ( j == 0 )			// We set up the jewel spawners
				{
					set(new JewelSpawner(i, j, layerBG, layerFG), i, j);
				}
				else					// We set up the normal tiles
				{
					set(new Tile(i, j, layerBG, layerFG), i, j);
				}
			}
		}
	}
	
	/********************************************************************************
	 * NEIGHBORS
	 * ******************************************************************************/
	function getNeighbors()
	{
		for ( i in 0...arrayWidth )
		{
			for ( j in 0...arrayHeight )
			{
				var theTile : Tile = get(i, j);
				theTile.getNeighbors();
			}
		}
	}
}