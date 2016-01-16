package 
{
	import org.flixel.*;
	public class StatState extends FlxState 
	{
		
		private var complete:Boolean;
		public static var text:FlxText;
		public function StatState():void
		{
			FlxG.bgColor = 0xffff3e3e;
			text = new FlxText(0, 0, 140);
			complete = false;
			
			
		}
		override public function update():void
		{
			if (complete == false)
			{
				if (PlayState.hasStar == true)
					Scores.starScore += 150;
				else if(PlayState.hasStar==false)
					Scores.starScore += 0;
				Scores.livesScore += (Player.hearts * 100);
				Scores.coinScore = PlayState.coinCounter * 10;
				Scores.totalScore = (Scores.livesScore + Scores.coinScore + Scores.starScore + Scores.enemyScore) ;
				text.text = "Lives(x100): " +Scores.livesScore + "                          Coins(x10): " + Scores.coinScore+"                           Star Bonus: "+ Scores.starScore+"                               Enemy Kills(x20): "+ Scores.enemyScore+"                           Total: "+Scores.totalScore+"                                  X to continue!";
				add(text);
				complete = true;
			}
			if (FlxG.keys.justPressed("X"))
			{
				if (Player.hearts <= 0)
				{
					PlayState.coinCounter = 0;
					if (PlayState.hasStar)
						Scores.starScore-= 150;
				}
				Scores.updated = 0;
				FlxG.switchState(new PlayState());
			}
		}
	}
	
}