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
	
	public var colSpawners : Array<JewelSpawner>;
	
	public function new() 
	{			
		colSpawners = new Array<JewelSpawner>();
		
		Registry.game.playArea = this;
		
		layerBG = new JKSprite(this);
		layerFG = new JKSprite(this);
		
		super(8, 8, null);
		
		x = 40;
		y = 40;
		
		populateWithTiles();
		getNeighbors();
		populateWithJewels();		
	}	
	
	/********************************************************************************
	 * POPULATING
	 * ******************************************************************************/
	function populateWithJewels()
	{
		for ( i in 0...arrayWidth )
		{
			colSpawners[i].spawnJewels(8);
		}
	}
	 
	function populateWithTiles()
	{
		for ( i in 0...arrayWidth )
		{
			for ( j in 0...arrayHeight )
			{				
				if ( j == 0 )			// We set up the jewel spawners
				{
					var theJewelSpawner : JewelSpawner = new JewelSpawner(i, j, layerBG, layerFG);
					set(theJewelSpawner, i, j);
					colSpawners.insert(i, theJewelSpawner); 
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