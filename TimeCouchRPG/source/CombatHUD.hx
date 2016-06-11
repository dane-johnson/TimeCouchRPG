package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUIRegion;
import flixel.addons.ui.FlxUIText;
import flixel.addons.ui.FlxUITypedButton;
import flixel.addons.ui.StrNameLabel;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxUIDropDownMenu;
using flixel.util.FlxSpriteUtil;
using Lambda;


class CombatHUD extends FlxTypedGroup<FlxSprite>
{

	private var ui:FlxUI;
	
	private var player:Player;
	private var enemy:Enemy;
	private var playerTurn:Bool;
	
	private var menuAttacks:FlxUIDropDownMenu;
	private var attackLabels:Array<StrNameLabel>;
	private var playerPos:FlxUIRegion;
	private var enemyPos:FlxUIRegion;
	private var playerHealthBar:FlxUIText;
	private var enemyHealthBar:FlxUIText;
	
	public function new(UI:FlxUI) 
	{
		super();
		
		ui = UI;
		ui.visible = false;
		
		menuAttacks = cast ui.getAsset("attack_list");
		
		playerPos = cast ui.getAsset("player_position");
		enemyPos = cast ui.getAsset("enemy_position");
		playerHealthBar = cast ui.getAsset("player_health");
		enemyHealthBar = cast ui.getAsset("enemy_health");
		
		//dont move with camera
		forEach( function(sprite:FlxSprite)
		{
			sprite.scrollFactor.set();
		});
		
		active = false;
		visible = false;
	}
	
	public function initCombat(P:Player, E:Enemy):Void
	{
		ui.visible = true;
		
		player = P;
		add(player);
		enemy = E;
		add(enemy);
		
		player.inCombat = true;
		enemy.inCombat = true;
	
		player.setPos(playerPos.getPosition());
		enemy.setPos(enemyPos.getPosition());
	
		updateHealth();
		
		attackLabels = new Array<StrNameLabel>();
		for (attack in player.attacks)
		{
			attackLabels.push(new StrNameLabel(attack.name, attack.name));
		}
		menuAttacks.setData(attackLabels);
		
		playerTurn = true;
		active = true;
		visible = true;
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (active && !playerTurn)
		{
			//ai takes turn
		}
	}
	
	public function updateSelectedAttack(name:String):Void
	{
		menuAttacks.selectedId = name;
	}
	
	public function doSelectedAttack():Void
	{
		var strAttack:String = menuAttacks.selectedId;
		
		var attack:Attack = player.attacks.filter(function(a){return a.name == strAttack; })[0];
		var attackVal:AttackValue = attack.doAttack(enemy);
		
		//have to reference returned value for function to fire
		if (attackVal == AttackValue.HIT){}
		
		updateHealth();
		
		//check if enemy dead
		if (enemy.health == 0)
		{
			//end combat
			resolve(WIN);
		}
		else
		{
			//switch turns
			playerTurn = false;
		}
	}
	
	function resolve(outcome:Outcome):Void
	{
		
	}
	
	function updateHealth()
	{
		if (playerHealthBar.active && enemyHealthBar.active)
		{
			playerHealthBar.text =  "" + player.health + " / " + player.maxHealth;
			enemyHealthBar.text =  "" + enemy.health + " / " + enemy.maxHealth;
		}
	}
}

enum Outcome
{
	WIN;
	LOSE;
	ESCAPE;
	NONE;
}