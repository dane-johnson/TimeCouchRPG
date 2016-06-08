package attacks;
import flixel.FlxSprite;
import flixel.math.FlxRandom;

class HolyBible extends Attack
{
	public function new(Parent:Character)
	{
		super(Parent);
		name = "Holy Bible";
	}
	
	override public function doAttack(tgt:Character):AttackValue
	{
		var hit:Bool;
		hit = new FlxRandom().bool(30);
		
		if (hit)
		{
			tgt.health -= 4;
			return AttackValue.HIT;
		}
		else
		{
			return AttackValue.MISS;
		}
	}
}