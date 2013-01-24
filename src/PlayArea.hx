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
		new Tile(0, 0, this);
	}
	
}