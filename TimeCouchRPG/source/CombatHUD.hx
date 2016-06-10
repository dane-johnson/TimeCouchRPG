package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUIButton;
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
	
	public function new(UI:FlxUI) 
	{
		super();
		
		ui = UI;
		ui.visible = false;
		
		menuAttacks = cast ui.getAsset("attack_list");
		
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
		//TODO
		super.update(elapsed);
	}
	
	public function updateSelectedAttack(name:String):Void
	{
		menuAttacks.selectedId = name;
	}
	
	public function doSelectedAttack():Void
	{
		trace("attacking!");
		var strAttack:String = menuAttacks.selectedId;
		
		var attack:Attack = player.attacks.filter(function(a){return a.name == strAttack; })[0];
		var attackVal:AttackValue = attack.doAttack(enemy);
		
		//check if enemy dead
			//end combat
			
			//switch turns
	}
}

enum Outcome
{
	WIN;
	LOSE;
	ESCAPE;
	NONE;
}