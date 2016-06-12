package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxUITypedButton;

class TestState extends CombatState
{

	private var player:Player;
	private var enemy:Enemy;
	
	override public function create() 
	{
		#if debug
		FlxG.log.redirectTraces = true;
		#end
		
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
	
}