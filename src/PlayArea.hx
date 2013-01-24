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
		layerBG = new JKSprite(this);
		layerFG = new JKSprite(this);
		
		super(8, 8, null);
		
		x = 40;
		y = 40;
		
		populate();
		
		var theTile : Tile = get(3, 3);
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
				set(new Tile(i, j, layerBG, layerFG), i, j);
			}
		}
	}
}