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
import flixel.addons.ui.interfaces.IFlxUIWidget;
import flixel.addons.util.FlxFSM.StatePool;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxUIDropDownMenu;
using flixel.util.FlxSpriteUtil;
using Lambda;


class CombatHUD extends FlxTypedGroup<FlxSprite>
{

	private var playerInitPosition:FlxPoint;
	private var enemyInitPosition:FlxPoint;
	
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
	private var userInterface:FlxUIGroup;
	
	public var state:State;
	
	public function new(UI:FlxUI) 
	{
		super();
		
		ui = UI;
		
		userInterface = new FlxUIGroup();
		menuAttacks = cast ui.getAsset("attack_list");
		userInterface.add(cast menuAttacks);
		userInterface.add(cast ui.getAsset("attack_button"));
		
		playerPos = cast ui.getAsset("player_position");
		enemyPos = cast ui.getAsset("enemy_position");
		playerHealthBar = cast ui.getAsset("player_health");
		enemyHealthBar = cast ui.getAsset("enemy_health");
		
		//dont move with camera
		forEach( function(sprite:FlxSprite)
		{
			sprite.scrollFactor.set();
		});
		
		switchState(DEACTIVATED);
	}
	
	public function initCombat(P:Player, E:Enemy):Void
	{		
		player = P;
		add(player);
		enemy = E;
		add(enemy);
		
		player.inCombat = true;
		enemy.inCombat = true;
		
		playerInitPosition = player.getPosition();
		enemyInitPosition = enemy.getPosition();
		player.setPos(playerPos.getPosition());
		enemy.setPos(enemyPos.getPosition());
	
		updateHealth();
		
		attackLabels = new Array<StrNameLabel>();
		for (attack in player.attacks)
		{
			attackLabels.push(new StrNameLabel(attack.name, attack.name));
		}
		menuAttacks.setData(attackLabels);
		
		switchState(ACTIVATING);
		switchState(WAITING);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (state == SWITCHING && !playerTurn)
		{
			userInterface.active = false;
			enemyDoAttackTurn();
			switchState(SWITCHING);
			playerTurn = true;
		}
		else if (state == SWITCHING && playerTurn)
		{
			userInterface.active = true;
			switchState(WAITING);
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
			switchState(DEACTIVATED);
			resolve(WIN);
		}
		else
		{
			//switch turns
			playerTurn = false;
			userInterface.active = false;
			switchState(SWITCHING);
		}
	}
	
	function resolve(outcome:Outcome):Void
	{
		switch (outcome)
		{
			case WIN:
				enemy.kill();
				player.setPos(playerInitPosition);
			default:
				
		}
	}
	
	function updateHealth()
	{
		if (playerHealthBar.active && enemyHealthBar.active)
		{
			playerHealthBar.text =  "" + player.health + " / " + player.maxHealth;
			enemyHealthBar.text =  "" + enemy.health + " / " + enemy.maxHealth;
		}
	}
	
	private function enemyDoAttackTurn()
	{
		//ai takes turn
		var selection:Float = new FlxRandom().float();
		var attack = enemy.attacks[enemy.attackPercentages
			.indexOf(enemy.attackPercentages
			.filter(function (f:Float){return f <= selection; }).pop())];
		var attackVal = attack.doAttack(player);
		//must reference value
		if (attackVal == AttackValue.HIT){}
		updateHealth();
	}
	
	private function switchState(S:State):Void
	{
		state = S;
		
		switch(state)
		{
			case DEACTIVATED:
				active = false;
				visible = false;
				ui.visible = false;
			case ACTIVATING:
				playerTurn = true;
				active = true;
				visible = true;
				ui.visible = true;
			default:
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

enum State
{
	WAITING;
	ANIMATING;
	UPDATING;
	SWITCHING;
	DEACTIVATED;
	ACTIVATING;
}