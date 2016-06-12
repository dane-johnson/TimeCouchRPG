package;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Character extends FlxSprite
{	
	public var attacks:Array<Attack>;
	public var inCombat:Bool = false;
	public var maxHealth:Float;

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		attacks = new Array<Attack>();
		
		initHealth();
		initAttacks();
	}
	
	public function removeHealth(amt:Int):Void
	{
		if (health - amt < 0)
		{
			health = 0;
		}
		else
		{
			health = health - amt;
		}
	}
	
	public function addHealth(amt:Int):Void
	{
		if (health + amt > maxHealth)
		{
			health = maxHealth;
		}
		else
		{
			health = health + amt;
		}
	}
	
	public function setPos(pos:FlxPoint)
	{
		x = pos.x;
		y = pos.y;
	}
	
	public function initHealth():Void{}
	public function initAttacks():Void{}
}