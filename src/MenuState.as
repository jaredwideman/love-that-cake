package 
{
	/**
	 * A state class. A quick animation for the title screen.
	 */
	
	//Imports
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class MenuState extends FlxState
	{
		//Source Variables
		[Embed(source = "images/title/bars.png")] protected var ImgBars:Class;
		[Embed(source = "images/title/cake.png")] protected var ImgCake:Class;		
		[Embed(source = "images/title/cakeman.png")] protected var ImgCakeman:Class;		
		[Embed(source = "images/title/cakePNG.png")] protected var ImgCakeGraphic:Class;		
		[Embed(source = "images/title/love.png")] protected var ImgLove:Class;		
		[Embed(source = "images/title/that.png")] protected var ImgThat:Class;
		[Embed(source = "sounds/landing.mp3")] private var SndMenu:Class;
		
		//Variables
		private var cakeman:FlxSprite;
		private var bars:FlxSprite;
		private var textLove:FlxSprite;
		private var textThat:FlxSprite;
		private var textCake:FlxSprite;
		private var cake:FlxExtendedSprite;
		private var clickMe:FlxText;
		
		public function MenuState()
		{	
			//Add mouse control
			if (FlxG.getPlugin(FlxMouseControl) == null)
			{
				FlxG.addPlugin(new FlxMouseControl);
			}
		}
		
		override public function create():void
		{
			//Add all the graphics
			FlxG.bgColor = 0xffffffff;
			cakeman = new FlxSprite(0, 0, ImgCakeman);
			add(cakeman);
			bars = new FlxSprite( -2000, 0, ImgBars);
			add(bars);
			textLove = new FlxSprite(0, -1500, ImgLove);
			add(textLove);
			textThat = new FlxSprite(0, -3000, ImgThat);
			add(textThat);
			textCake = new FlxSprite(-4500, 0, ImgCake);
			add(textCake);
			clickMe = new FlxText(2, 150, 200, "(Click Me)");
			clickMe.setFormat(null, 8, 0xff9000);
			clickMe.visible = false;
			add(clickMe);
			cake = new FlxExtendedSprite(40, 1000, ImgCakeGraphic);
			add(cake);
		}
		
		override public function update():void
		{
			//A lot of animations. Cake clicked changes state
			super.update();
			if (FlxG.keys.SPACE)//REMOVE LATER
				FlxG.switchState(new PlayState());
			if(cake.isPressed)
				FlxG.switchState(new HelpState());
			if (bars.x < 0)
				bars.velocity.x = 2000;
			else
			{
				bars.x = 0;
				if (textLove.y < 0)
					textLove.velocity.y = 2000;
				else if (textLove.y >0 && textLove.y < 10)
					FlxG.play(SndMenu);
				else
					textLove.y = 0;
				if (textThat.y < 0)
					textThat.velocity.y = 2000;
				else if (textThat.y >0 && textThat.y < 10)
					FlxG.play(SndMenu);
				else
					textThat.y = 0;
				if (textCake.x < 0)
					textCake.velocity.x = 2000;
				else if (textCake.x >0 && textCake.x < 15)
					FlxG.play(SndMenu);
				else
				{
					textCake.x = 0;
					if (cake.y > 150)
					cake.velocity.y = -2000;
					else
					{
						cake.velocity.y = 0;
						clickMe.visible = true;
					}
				}
			}
		}
	}
}
	
