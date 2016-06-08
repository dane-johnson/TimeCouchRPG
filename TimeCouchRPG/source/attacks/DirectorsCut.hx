package attacks;

import flixel.FlxSprite;

class DirectorsCut extends Attack
{

	public function new(Parent:Character) 
	{
		super(Parent);
		name = "Director's Cut";
	}
	
	override public function doAttack(tgt:Character):AttackValue
	{
		tgt.removeHealth(2);
		return AttackValue.HIT;
	}
	
}