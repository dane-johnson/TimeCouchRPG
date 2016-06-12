package items;

class HealthPotion extends Item
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		name = "Health Potion";
		flavor = DEFENSIVE;
		loadGraphic(AssetPaths.health_potion__png);
	}
	
	override public function doEffect(?tgt:Character):Void
	{
		parent.addHealth(3);
	}
}