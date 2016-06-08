package attacks;

class Whip extends Attack
{

	public function new(Parent:Character) 
	{
		super(Parent);
		name = "Whip";
	}
	
	override public function doAttack(tgt:Character):AttackValue 
	{
		tgt.removeHealth(2);
		return AttackValue.HIT;
	}
}