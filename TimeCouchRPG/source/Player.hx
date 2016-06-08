package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Player extends FlxSprite
{
	
	public var name:PlayerName;
	public var speed:Float = 40;
	private var lastName:PlayerName;
	public function new(?X:Float=0, ?Y:Float=0, Name:PlayerName) 
	{
		super(X, Y);
		name = Name;
		lastName = name;
		
		assignImage();
		//Flip image when walking right or left
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		FlxG.watch.add(this, "speed");
	}
	
	private function assignImage():Void
	{
		var graphic: FlxGraphicAsset;
		
		switch (name)
		{
			case AUSTIN:
				graphic = AssetPaths.austin__png;
			case JOE:
				graphic = AssetPaths.joe__png;
		}
		
		loadGraphic(graphic, true, 16, 16);
	}
	
	override public function draw():Void
	{
		if (lastName != name)
		{
			assignImage();
			lastName = name;
		}
		
		super.draw();
	}
	
	override public function update(elapsed:Float):Void
	{
		move();
		super.update(elapsed);
	}
	
	public function move():Void
	{
		switch (getInput())
		{
			case FlxObject.UP:
				velocity.x = 0;
				velocity.y = -speed;
				facing = FlxObject.UP;
			case FlxObject.DOWN:
				velocity.x = 0;
				velocity.y = speed;
				facing = FlxObject.DOWN;
			case FlxObject.LEFT:
				velocity.x = -speed;
				velocity.y = 0;
				facing = FlxObject.LEFT;
			case FlxObject.RIGHT:
				velocity.x = speed;
				velocity.y = 0;
				facing = FlxObject.RIGHT;
			case FlxObject.NONE:
				velocity.x = 0;
				velocity.y = 0;
		}
	}
	
	private function getInput():Int
	{
		if (FlxG.keys.anyPressed([UP, W]))
		{
			return FlxObject.UP;
		}
		else if (FlxG.keys.anyPressed([DOWN, S]))
		{
			return FlxObject.DOWN;
		}
		else if (FlxG.keys.anyPressed([LEFT, A]))
		{
			return FlxObject.LEFT;
		}
		else if (FlxG.keys.anyPressed([RIGHT, D]))
		{
			return FlxObject.RIGHT;
		}
		else
		{
			return FlxObject.NONE;
		}
	}
}