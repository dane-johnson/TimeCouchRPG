package attacks;

class Plague extends Attack
{

	public function new(Parent:Character) 
	{
		super(Parent);
		name = "Plague Wave";
	}
	
	override public function doAttack(tgt:Character):AttackValue 
	{
		tgt.removeHealth(4);
		return AttackValue.CRITICAL;
	}
	
}