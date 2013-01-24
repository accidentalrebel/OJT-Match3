package ;
import jkEngine.JK2DArray;
import jkEngine.JKSprite;

/**
 * ...
 * @author Karlo
 */

class PlayArea extends JK2DArray
{
	public var colSpawners : Array<JewelSpawner>;	
	public var selectedTile : Tile;	
	var layerFG : JKSprite;
	var layerBG : JKSprite;	
	var marker : JKSprite;	
	
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
		
		marker = new JKSprite("img/marker.png", layerBG);
		marker.hide();
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
	
	/********************************************************************************
	 * MARKER
	 * ******************************************************************************/
	function moveMarkerTo(thisTile : Tile)
	{
		marker.x = thisTile.x;
		marker.y = thisTile.y;
	}
	
	/********************************************************************************
	 * TILE SELECTION
	 * ******************************************************************************/
	public function selectTile( clickedTile : Tile )
	{		
		if ( selectedTile == null )					// If there are no tiles that are currently selected
		{			
			moveMarkerTo(clickedTile);				// We move the marker to positoin
			marker.show();
			selectedTile = clickedTile;
		}
		else										// If there is a selected Tile
		{
			if ( selectedTile == clickedTile )		// If the clickedTIle is already selected
			{
				selectedTile = null;				// We deselect the tile
				marker.hide();
			}
			else									// If this is a different tile
			{
				// We check if the selected tile is a neighbor
				if ( clickedTile == selectedTile.topNeighbor
					|| clickedTile == selectedTile.rightNeighbor 
					|| clickedTile == selectedTile.bottomNeighbor 
					|| clickedTile == selectedTile.leftNeighbor )	// If this tile is left neighbor
					{						
						clickedTile.residentJewel.switchWith(selectedTile.residentJewel);						
						marker.hide();
						selectedTile = null;
					}			
			}
		}
	}
}