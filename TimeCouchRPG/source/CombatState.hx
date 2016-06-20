package;

import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxUITypedButton;

class CombatState extends FlxUIState
{
	
	public var combatHUD:CombatHUD;

	override public function create() 
	{
		_xml_id = "combat_state";
		super.create();
		combatHUD = new CombatHUD(_ui, this);
		
		add(combatHUD);
	}
	
	public function initCombat(P:Player, E:Enemy):Void
	{
		combatHUD.initCombat(P, E);
	}
	
	override public function getEvent(id:String, sender:Dynamic, data:Dynamic, ?params:Array<Dynamic>):Void
	{
		super.getEvent(id, sender, data, params);
		if (params != null)
		{
			switch(cast(params[0], String))
			{
				case 'attack_button':
					if (id == FlxUITypedButton.CLICK_EVENT)
					{
						combatHUD.doSelectedAttack();
					}
				case 'item_button':
					if (id == FlxUITypedButton.CLICK_EVENT)
					{
						combatHUD.useSelectedItem();
					}
			}
		}
	}
	
	public function postCombat(outcome:CombatHUD.Outcome):Void
	{
		switch(outcome)
		{
			case WIN:
			case LOSE:
				FlxG.switchState(new MenuState());
			default:
		}
	}
	
}