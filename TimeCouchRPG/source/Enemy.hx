package;
import attacks.Plague;
import attacks.Spear;
import attacks.Whip;

class Enemy extends Character
{

	public var name:EnemyName;
	
	public function new(?X:Float=0, ?Y:Float=0, Name:EnemyName) 
	{
		name = Name;
		super(X, Y);
		initGraphics();
	}
	
	override public function initHealth():Void
	{
		switch (name)
		{
			case EnemyName.GUARD:
				health = 2;
			case EnemyName.PHAROH:
				health = 10;
		}
	}
	
	override public function initAttacks():Void
	{
		switch (name)
		{
			case EnemyName.GUARD:
				attacks.add(new Spear(this));
			case EnemyName.PHAROH:
				attacks.add(new Whip(this));
				attacks.add(new Plague(this));
		}
	}
	
	private function initGraphics():Void
	{
		switch(name)
		{
			case EnemyName.GUARD:
				loadGraphic(AssetPaths.guard__png);
			default:
				return;
			//Add pharoh once art done
		}
	}
}