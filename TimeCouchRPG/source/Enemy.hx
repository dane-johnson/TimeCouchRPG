package;
import attacks.Plague;
import attacks.Spear;
import attacks.Whip;

class Enemy extends Character
{

	public var name:EnemyName;
	public var enemyId:Int;
	public var attackPercentages: Array<Float>;
	
	public function new(?X:Float=0, ?Y:Float=0, Name:EnemyName, EnemyId:Int) 
	{
		name = Name;
		enemyId = EnemyId;
		attackPercentages = new Array<Float>();
		super(X, Y);
		initGraphics();
	}
	
	override public function initHealth():Void
	{
		switch (name)
		{
			case GUARD:
				maxHealth = 2;
			case PHAROH:
				maxHealth = 10;
		}
		
		health = maxHealth;
	}
	
	override public function initAttacks():Void
	{
		switch (name)
		{
			case GUARD:
				attacks.push(new Spear(this));
				attackPercentages.push(0);
			case PHAROH:
				attacks.push(new Whip(this));
				attackPercentages.push(0);
				attacks.push(new Plague(this));
				attackPercentages.push(0.8);
		}
	}
	
	private function initGraphics():Void
	{
		switch(name)
		{
			case GUARD:
				loadGraphic(AssetPaths.guard__png);
			case PHAROH:
				loadGraphic(AssetPaths.pharoh__png);
			default:
				return;
		}
	}
}

enum EnemyName
{
	GUARD;
	PHAROH;
}