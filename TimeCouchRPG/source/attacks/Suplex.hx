package attacks;

import flixel.FlxSprite;

class Suplex extends Attack
{

	public function new(Parent:Character) 
	{
		super(Parent);
		name = "Suplex";
	}
	
	override public function doAttack(tgt:Character):AttackValue
	{
		tgt.health -= 1;
		return AttackValue.HIT;
	}
	
}