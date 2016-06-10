package;

import flixel.FlxG;
import flixel.FlxState;

class TestState extends FlxState
{

	private var player:Player;
	private var enemy:Enemy;
	private var combatHUD:CombatHUD;
	override public function create() 
	{
		player = new Player(0, 0, JOE);
		add(player);
		
		enemy = new Enemy(1, 0, GUARD, 0);
		add(enemy);
		
		combatHUD = new CombatHUD();
		add(combatHUD);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void
	{
		FlxG.overlap(player, enemy, initCombat);
	}
	
	private function initCombat(P:Player, E:Enemy)
	{
		combatHUD.initCombat(P, E);
	}
	
}