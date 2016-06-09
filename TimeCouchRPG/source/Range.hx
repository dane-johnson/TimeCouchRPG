package;

import flixel.FlxObject;
import flixel.math.FlxRect;

class Range extends FlxObject
{

	public var enemyId:Int;
	
	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0, EnemyId) 
	{
		super(X, Y, Width, Height);
		enemyId = EnemyId;
	}
	
}