package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.ui.FlxUIState;

class TestState extends FlxUIState
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
		
		_xml_id = "combat_state";
		super.create();
		
		combatHUD = new CombatHUD(_ui);
		add(combatHUD);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.overlap(player, enemy, initCombat);
	}
	
	private function initCombat(P:Player, E:Enemy)
	{
		combatHUD.initCombat(P, E);
	}
	
}