package 
{
	/**
	 * A state class. Animation and backup story.
	 */
	
	 //Imports
	import org.flixel.*;
	
	public class IntroState extends FlxState 
	{
		//Source Variables
		[Embed(source = "images/cakemanSmall.png")] protected var ImgCakeman:Class;
		[Embed(source = "images/cakeLarge.png")] protected var ImgCakeGraphic:Class;
		
		//Variables
		private var cakeman:FlxSprite;
		private var cake:FlxSprite;
		private var text:FlxText;
		private var text2:FlxText;
		
		/*
		 * Alter background; Make the graphics fly in and such; Add text; X to start
		 */
		override public function create():void
		{
			FlxG.bgColor = 0xff000000;
			cakeman = new FlxSprite(1950, 15, ImgCakeman);
			add(cakeman);
			cake = new FlxSprite(-1500, 170, ImgCakeGraphic);
			add(cake);
			text = new FlxText(20, 20, 300, "One Man. One Dream. To possess all of the world's finest cakes. Which wouldn't pose as big of a problem had they not been hidden in so many dungeons! The need is critical, get the cakes. Get them as fast as you can and you will be rewarded... With uh, cakes. Oh and MONEY! Money that you can spend on getting cakes faster and easier. What could be better?");
			text.setFormat(null, 8, 0xffffff);
			add(text);
			text.visible = false;
			text2 = new FlxText(300, 225, 300, "Press X to Start");
			add(text2)
			text2.visible = false;
		}
		override public function update():void
		{
			super.update();
			if (cakeman.x > 350)
				cakeman.velocity.x = -1000;
			else if (cakeman.x < 320)
			{
				cakeman.x = 320;
				text.visible = true;
				text2.visible = true;
				if (FlxG.keys.X)
					onStart();
			}
			else
				cakeman.velocity.x = -10;
			
			if (cake.x < 100)
				cake.velocity.x = 1000;
			else if (cake.x > 130)
			{
				cake.x = 130;
			}
			else
				cake.velocity.x = 10;
		}
		public function onStart():void
		{
			FlxG.switchState(new PlayState());
		}
	}
	
}