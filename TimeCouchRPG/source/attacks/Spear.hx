package attacks;
import flixel.math.FlxRandom;

class Spear extends Attack
{

	public function new(Parent:Character) 
	{
		super(Parent);
		name = "Spear";
	}
	
	override public function doAttack(tgt:Character):AttackValue
	{
		var hit:Bool = new FlxRandom().bool(80);
		if (hit)
		{
			tgt.removeHealth(1);
			return AttackValue.HIT;
		}
		else
		{
			return AttackValue.MISS;
		}
	}
	
}