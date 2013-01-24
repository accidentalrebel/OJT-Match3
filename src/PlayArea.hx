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
	var tilesForClearing : Array<Tile>;
	public var isClearing : Bool = false;
	public var selectedTile : Tile;	
	var layerFG : JKSprite;
	var layerBG : JKSprite;	
	var marker : JKSprite;	
	
	public function new() 
	{			
		colSpawners = new Array<JewelSpawner>();		
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
				toDisplay += element.objectName + ", ";				// If element is not empty, "1" is displayed
			
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
		//var theTile : Tile = get(3, 3);
		//theTile.residentJewel.clear();
		//theTile = get(3, 4);
		//theTile.residentJewel.clear();
		//theTile = get(3, 5);
		//theTile.residentJewel.clear();
		//trace("left is " + get(3,4).residentJewel);
		//
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
	public function checkForMatches()
	{		
		for ( i in 0...arrayWidth )
		{
			for ( j in 0...arrayHeight )
			{
				Lib.trace("Checking for matches: " + i + ", " + (arrayHeight - 1- j));
				var theTile : Tile = get(i, arrayHeight - 1 - j);
				if ( theTile.residentJewel != null )
					theTile.checkForMatch();
				
				clearMarked();				
			}
		}
		
		//clearMarked();
	}
	
	public function clearMarked()
	{
		isClearing = true;
		tilesForClearing.reverse();
		for ( tile in tilesForClearing )
		{			
			if ( tile.residentJewel != null )
			{		
				Lib.trace("Clearing: " + tile.objectName);
				tile.residentJewel.clear();
			}
			//if ( jewel != null  && !jewel.isCleared )
			//{
				//var theParentTile = jewel.parentTile;			
				//Lib.trace(theParentTile.objectName + " is cleared");
				//jewel.clear();			
			//}
		}
		isClearing = false;
	}
	
	public function setForClearing( thisTile : Tile)
	{
		tilesForClearing.push(thisTile);
	}
}