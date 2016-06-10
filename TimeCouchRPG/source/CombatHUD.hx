package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.ui.StrNameLabel;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxUIDropDownMenu;
using flixel.util.FlxSpriteUtil;


class CombatHUD extends FlxTypedGroup<FlxSprite>
{

	private var sprBack:FlxSprite;
	private var player:Player;
	private var enemy:Enemy;
	private var playerTurn:Bool;
	private var posPlayer:FlxPoint;
	private var posEnemy:FlxPoint;
	
	private var menuAttacks:FlxUIDropDownMenu;
	private var attackLabels:Array<StrNameLabel>;
	
	public function new() 
	{
		super();
		
		sprBack = new FlxSprite().makeGraphic(120, 120, FlxColor.BLUE);
		sprBack.drawRect(1, 1, 118, 44, FlxColor.WHITE);
		sprBack.drawRect(1, 46, 118, 73, FlxColor.WHITE);
		sprBack.screenCenter();
		add(sprBack);
		
		var x, y:Float;
		
		x = FlxMath.lerp(0, 120, .2) - 8;
		y = 22;
		posPlayer = new FlxPoint(x, y);
		posPlayer.addPoint(sprBack.getPosition());
		
		x = FlxMath.lerp(0, 120, .8) - 8;
		posEnemy = new FlxPoint(x, y);
		posEnemy.addPoint(sprBack.getPosition());
		
		attackLabels = new Array<StrNameLabel>();
		//should never see this
		attackLabels.push(new StrNameLabel("error", "error"));
		menuAttacks = new FlxUIDropDownMenu(0, 0, attackLabels);
		//menuAttacks.getPosition().addPoint(sprBack.getPosition());
		menuAttacks.visible = true;
		
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
		player = P;
		add(player);
		enemy = E;
		add(enemy);
		
		player.inCombat = true;
		enemy.inCombat = true;
		
		player.setPos(posPlayer);
		enemy.setPos(posEnemy);
		
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
}

enum Outcome
{
	WIN;
	LOSE;
	ESCAPE;
	NONE;
}