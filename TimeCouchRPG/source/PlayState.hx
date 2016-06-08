package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends FlxState
{
	private var map:FlxOgmoLoader;
	private var walls:FlxTilemap;
	private var player:Player;
	
	override public function create():Void
	{		
		map = new FlxOgmoLoader(AssetPaths.egypt__oel);
		walls =  map.loadTilemap(AssetPaths.egypt__png, 16, 16, "walls");
		walls.follow();
		//sand
		walls.setTileProperties(2, FlxObject.NONE);
		//cactus
		walls.setTileProperties(1, FlxObject.ANY);
		//wall
		walls.setTileProperties(3, FlxObject.ANY);
		add(walls);
		
		player = new Player(0, 0, PlayerName.AUSTIN);
		map.loadEntities(placeEntities, "entities");
		add(player);
		
		FlxG.camera.follow(player);
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(player, walls);
		super.update(elapsed);
	}
	
	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player")
		{
			player.x = x;
			player.y = y;
		}
	}
}
