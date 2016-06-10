package;
import attacks.Plague;
import attacks.Spear;
import attacks.Whip;

class Enemy extends Character
{

	public var name:EnemyName;
	public var enemyId:Int;
	
	public function new(?X:Float=0, ?Y:Float=0, Name:EnemyName, EnemyId:Int) 
	{
		name = Name;
		enemyId = EnemyId;
		super(X, Y);
		initGraphics();
	}
	
	override public function initHealth():Void
	{
		switch (name)
		{
			case GUARD:
				health = 2;
			case PHAROH:
				health = 10;
		}
	}
	
	override public function initAttacks():Void
	{
		switch (name)
		{
			case GUARD:
				attacks.push(new Spear(this));
			case PHAROH:
				attacks.push(new Whip(this));
				attacks.push(new Plague(this));
		}
	}
	
	private function initGraphics():Void
	{
		switch(name)
		{
			case GUARD:
				loadGraphic(AssetPaths.guard__png);
			default:
				return;
			//Add pharoh once art done
		}
	}
}

enum EnemyName
{
	GUARD;
	PHAROH;
}