package 
{
	/**
	 * A state class. Gives the player some direction and shows some credits.
	 */
	
	 //Imports
	import org.flixel.*;
	
	public class HelpState extends FlxState 
	{
		//Source Variables
		[Embed(source = "images/title/cakeman.png")] protected var ImgCakeman:Class;
		
		//Variables
		private var howTitle:FlxText;
		private var howBody:FlxText;
		private var cakeman:FlxSprite;
		private var musicTitle:FlxText;
		private var flixelTitle:FlxText;
		private var start:FlxText;
		
		/*
		 * Add a picture; Show the directions using FlxText of how to play the game; Add buttons that link to music source and
		 * flixel.
		 */
		override public function create():void
		{
			
			cakeman = new FlxSprite(0, 0, ImgCakeman);
			add(cakeman);
			
			howTitle= new FlxText(10, 10, 300, "HOW TO PLAY");
			howTitle.setFormat(null, 8, 0xff9000);
			add(howTitle);
			
			howBody = new FlxText(10, 20, 300, "Aiming: W for Up, S for Down.                                      Movement: A for left, D for right.                                         Shooting: O to shoot.                                                                                 Jumping: SPACEBAR to jump.                                                                 Quick Drop: P.                                                                                    Read Signs: R (Useful).");
			howBody.setFormat(null, 8, 0x000000);
			add(howBody);
			
			musicTitle = new FlxText(10, 90, 300, "MUSIC");
			musicTitle.setFormat(null, 8, 0xff9000);
			add(musicTitle);
			var musicButton:FlxButton = new FlxButton(10,103,"Mawnz",onMusic);
			musicButton.label.color = 0xff9000;
			musicButton.color = 0x000000;
			add(musicButton);
			
			flixelTitle = new FlxText(10, 143, 300, "GAME ENGINE");
			flixelTitle.setFormat(null, 8, 0xff9000);
			add(flixelTitle);
			var flixelButton:FlxButton = new FlxButton(10,156,"Flixel",onFlixel);
			flixelButton.label.color = 0xff9000;
			flixelButton.color = 0x000000;
			add(flixelButton);
			
			start = new FlxText(10, 200, 300, "Press X to begin");
			start.setFormat(null, 16, 0xff9000);
			start.shadow=0xFF000000;
			add(start)
			
		}
		override public function update():void
		{
			super.update();
			if (FlxG.keys.X)
				onStart();
		}
		protected function onMusic():void
		{
			FlxU.openURL("http://mawnz.newgrounds.com/");
		}
		protected function onFlixel():void
		{
			FlxU.openURL("http://flixel.org/");
		}
		protected function onStart():void
		{
			FlxG.switchState(new IntroState());
		}
	}
	
}