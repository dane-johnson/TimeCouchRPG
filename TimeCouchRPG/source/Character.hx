package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Character extends FlxSprite
{	
	public var attacks:List<Attack>;

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		attacks = new List<Attack>();
		
		initHealth();
		initAttacks();
	}
	
	public function initHealth():Void{}
	public function initAttacks():Void{}
}