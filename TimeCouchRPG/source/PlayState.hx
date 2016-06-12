package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.addons.ui.FlxUIState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxVelocity;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends CombatState
{
	private var map:FlxOgmoLoader;
	private var walls:FlxTilemap;
	private var player:Player;
	private var baddies:FlxTypedGroup<Enemy>;
	private var ranges:FlxTypedGroup<Range>;
	
	private var sndAlert:FlxSound;
	private function loadAssets():Void
	{
		//load sounds
		sndAlert = FlxG.sound.load(AssetPaths.alert__wav);
	}
	
	override public function create():Void
	{	
		#if debug
		FlxG.log.redirectTraces = true;
		#end
		
		loadAssets();
		
		map = new FlxOgmoLoader(AssetPaths.egypt__oel);
		walls =  map.loadTilemap(AssetPaths.egypt__png, 32, 32, "walls");
		walls.follow();
		//sand
		walls.setTileProperties(2, FlxObject.NONE);
		//cactus
		walls.setTileProperties(1, FlxObject.ANY);
		//wall
		walls.setTileProperties(3, FlxObject.ANY);
		add(walls);
		
		ranges = new FlxTypedGroup<Range>();
		add(ranges);
		
		baddies = new FlxTypedGroup<Enemy>();
		add(baddies);
		
		player = new Player(0, 0, PlayerName.AUSTIN);
		map.loadEntities(placeEntities, "entities");
		add(player);
		
		FlxG.camera.follow(player);
		
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(player, walls);
		FlxG.overlap(player, ranges, onPlayerEnterRange);
		FlxG.overlap(player, baddies, onPlayerCollideEnemy);
		super.update(elapsed);
	}
	
	private function onPlayerEnterRange(player:Player, range:Range):Void
	{
		baddies.forEach(function(e:Enemy):Void
		{
			if (range.enemyId == e.enemyId)
			{
				onEnemyAlerted(e);
				//trigger served its purpose
				ranges.remove(range);
				return;
			}
		});
	}
	
	private function onPlayerCollideEnemy(player:Player, enemy:Enemy):Void
	{
		//stop running baddie
		enemy.velocity.set();
		//reactivate player
		player.active = true;
		//enter combat mode
		initCombat(player, enemy);
	}
	
	private function onEnemyAlerted(e:Enemy):Void
	{
		//freeze the player
		player.velocity.set();
		player.active = false;
		//run towards him
		FlxVelocity.moveTowardsObject(e, player, 140);
		//play the alert
		sndAlert.play();
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
		if (entityName == "enemy")
		{
			var e:Enemy = null;
			var name = entityData.get("name");
			var enemyId:Int = Std.parseInt(entityData.get("enemy_id"));
			switch (name)
			{
				case "PHAROH":
					e = new Enemy(x, y, PHAROH, enemyId);
				case "GUARD":
					e = new Enemy(x, y, GUARD, enemyId);
			}
			baddies.add(e);
		}
		if (entityName == "sight_range")
		{
			var width:Int = Std.parseInt(entityData.get("width"));
			var height:Int = Std.parseInt(entityData.get("height"));
			var enemyId = Std.parseInt(entityData.get("enemy_id"));
			ranges.add(new Range(x, y, width, height, enemyId));
		}
	}
}
