package;

#if (desktop && debug)
import crashdumper.CrashDumper;
import crashdumper.SessionData;
#end
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		#if (desktop && debug)
		var unique_id:String = SessionData.generateID("TimeCouchRPG"); 
		//generates unique id: "TimeCouchRPG_YYYY-MM-DD_HH'MM'SS_CRASH"

		var crashDumper = new CrashDumper(unique_id); 
		//starts the crashDumper
		#end
		addChild(new FlxGame(320, 240, MenuState));
	}
}