package ;
import jkEngine.JK2DArray;

/**
 * ...
 * @author Karlo
 */

class PlayArea extends JK2DArray
{
	public function new() 
	{	
		super(8, 8, null);
		
		x = 40;
		y = 40;
		
		populate();
		
	}	
	
	override public function populate(?toPopulateWith:Dynamic):Dynamic 
	{
		for ( i in 0...arrayWidth )
		{
			for ( j in 0...arrayHeight )
			{
				set(new Tile(i, j, this), i, j);
			}
		}
	}
}