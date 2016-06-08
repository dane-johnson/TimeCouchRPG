package;
import flixel.FlxSprite;

class Attack
{
	public var name:String;
	public var parent:Character;
	public function doAttack(tgt:Character):AttackValue {return AttackValue.MISS;}
	
	public function new(Parent: Character)
	{
		parent = Parent;
	}
}