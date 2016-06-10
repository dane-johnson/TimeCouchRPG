package;

import attacks.DirectorsCut;
import attacks.HolyBible;
import attacks.Suplex;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Player extends Character
{
	
	public var name:PlayerName;
	public var speed:Float = 40;
	
	private var lastName:PlayerName;
	
	public function new(?X:Float=0, ?Y:Float=0, Name:PlayerName) 
	{
		name = Name;
		lastName = name;
		
		super(X, Y);
		assignImage();
	}
	
	private function assignImage():Void
	{
		var graphic: FlxGraphicAsset;
		
		switch (name)
		{
			case PlayerName.AUSTIN:
				graphic = AssetPaths.austin__png;
			case PlayerName.JOE:
				graphic = AssetPaths.joe__png;
		}
		
		loadGraphic(graphic, true, 16, 16);
	}
	
	override public function initHealth():Void
	{
		switch (name)
		{
			case PlayerName.JOE:
				health = 8;
			case PlayerName.AUSTIN:
				health = 5;
		}
	}
	
	override public function initAttacks():Void
	{
		switch (name)
		{
			case PlayerName.JOE:
				attacks.add(new HolyBible(this));
				attacks.add(new Suplex(this));
			case PlayerName.AUSTIN:
				attacks.add(new DirectorsCut(this));
		}
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
		if (!inCombat)
		{
			move();
		}
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