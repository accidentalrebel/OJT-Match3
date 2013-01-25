package ;
import jkEngine.JK2DArray;
import jkEngine.JKSprite;
import nme.Lib;

/**
 * ...
 * @author Karlo
 */

class PlayArea extends JK2DArray
{
	public var colSpawners : Array<JewelSpawner>;
	var colClearingCount : Array<Int>;
	var tilesForClearing : Array<Tile>;
	public var isClearing : Bool = false;
	public var selectedTile : Tile;	
	var layerFG : JKSprite;
	var layerBG : JKSprite;	
	var marker : JKSprite;	
	
	public function new() 
	{			
		colSpawners = new Array<JewelSpawner>();
		colClearingCount = [0,0,0,0,0,0,0,0];
		tilesForClearing = new Array<Tile>();
		
		Registry.game.playArea = this;
		
		layerBG = new JKSprite(this);
		layerFG = new JKSprite(this);		
		
		super(8, 8, null);
		
		x = 40;
		y = 40;
		
		populateWithTiles();
		getNeighbors();
		populateWithJewels();		
		displayAllContent();
		
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
			//colSpawners[i].spawnJewels(8);
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
	 * CONTENT DISPLAY
	 * ******************************************************************************/
	override public function displayAllContent():Dynamic 
	{
		var xElementCount : Int = 1;
		var i : Int = 0;
		var toDisplay : String = "\n";			// We set up the toDisplay string
		for ( element in array )				// We loop through each element
		{
			if ( element.residentJewel == null )				// If the element is empty, "N" is displayed
				toDisplay += "[  Null ], " ;
			else
				toDisplay += element.residentJewel.objectName + ", ";				// If element is not empty, "1" is displayed
			
			if ( xElementCount >= pitch )		// This checks whether we should go to the next line
			{
				xElementCount = 0;				// We reset the xElement count
				toDisplay += "\n";				// We then add a new line
			}
			
			xElementCount ++;
			i++;
		}
		
		Lib.trace(toDisplay);						// We display the generated string
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
						checkForMatches();						
					}			
			}
		}
	}
	
	/********************************************************************************
	 * MATCH CHECKING
	 * ******************************************************************************/
	
	 /**
	  * Loops through the playArea array and checks for matches
	  */
	 public function checkForMatches()
	{		
		for ( i in 0...arrayWidth )
		{
			for ( j in 0...arrayHeight )
			{												
				var theTile : Tile = get(i, arrayHeight - 1 - j);
				if ( theTile.residentJewel != null && !theTile.residentJewel.isCleared)
					theTile.checkForMatch();
			}
		}
		
		clearMarked();
		displayAllContent();
	}
	
	/**
	 * Clears all the tiles with jewels that were marked for clearing
	 */
	public function clearMarked()
	{
		isClearing = true;										// We have started clearing
		colClearingCount = [0,0,0,0,0,0,0,0];					// We clear the col count just in case
		tilesForClearing.reverse();								// We revese the tiles to be cleared, so that the bottom tiles are processed first		
		
		// We loop through all the tiles marked for clearing
		for ( tile in tilesForClearing )
		{			
			if ( tile.residentJewel != null )
			{	
				tile.residentJewel.clear();						// We clear each tile
				colClearingCount[tile.xCoord] += 1;				// We then take into account the number of cleared tiles per column
			}
		}
		
		// We then loop through each columns to spawn jewels according to the number of clearedTiles
		for ( i in 0...arrayWidth )
		{			
			colSpawners[i].spawnJewels(colClearingCount[i]);
		}
		
		colClearingCount = [0,0,0,0,0,0,0,0];					// We clear the col count for next time	
		isClearing = false;										// We have finished clearing
		tilesForClearing = [];									// We clear the tiles
	}
	
	/**
	 * Sets the tile for clearing by adding it to the tilesForClearing array
	 * @param	thisTile
	 */
	public function setForClearing( thisTile : Tile)
	{
		tilesForClearing.push(thisTile);
	}
}