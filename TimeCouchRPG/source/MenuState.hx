package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class MenuState extends FlxState
{
	private var titleTxt: FlxText;
	private var descTxt: FlxText;
	private var goBtn: FlxButton;
	override public function create():Void
	{
		titleTxt = new FlxText(0, 0, 0, "Time Couch RPG", 12);
		add(titleTxt);
		
		descTxt = new FlxText(0, 20, 0, "Prototype version 1.0 by Dane Johnson", 8);
		add(descTxt);
		
		goBtn = new FlxButton(0, 40, "Go!", clickGo);
		add(goBtn);
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	private function clickGo()
	{
		FlxG.switchState(new PlayState());
	}
}
