package;
import flixel.FlxSprite;

class Item extends FlxSprite
{
	public var name:String;
	public var parent:Character;
	public var flavor:ItemFlavor;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
	}
	
	public function get_parent():Character
	{
		return parent;
	}
	
	public function set_parent(Parent:Character):Void
	{
		parent = Parent;
	}
	
	public function doEffect(?tgt:Character):Void{}
}

enum ItemFlavor
{
	DEFENSIVE;
	OFFENSIVE;
}