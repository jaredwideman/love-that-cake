package
{
	/**
	 * A state class. The main state where things occur. Acts as a registry as well.
	 */
	
	//Imports
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*
	
	public class PlayState extends FlxState
	{
		//Source Variables
		[Embed(source = "images/deadPlayer.png")] private var ImgPlayerBlow:Class;
		[Embed(source = "sounds/bitMusic.mp3")] protected var SndLTC:Class;
		[Embed(source = "images/heart.png")] protected var heartPNG:Class;
		[Embed(source = "images/starHUD.png")] protected var starEmptyPNG:Class;
		[Embed(source = "images/star.png")] protected var starPNG:Class;
		
		//Variables
		public static var hasStar:Boolean = false;
		public static var coinCounter:int=0;
		public static var level:Level1;
		public static var level2:Level2;
		public static var player:Player;
		public var playerBullets:FlxGroup;
		public var metagroup:FlxGroup;
		protected var playerBlow:FlxEmitter;
		public var location:FlxText;
		public var XCoord:int = FlxG.mouse.x;
		public var YCoord:int = FlxG.mouse.y;
		public static var sampleText:FlxText;
		public static var sampleText2:FlxText;
		public var point:FlxPoint = new FlxPoint(0, 0);
		public static var counter:Number = 0;
		public static var heartsPNG:FlxSprite;
		private var yStar:FlxSprite;
		private var nStar:FlxSprite;
		private var updated:int=0;
		private var updated1:int=0;
		private var added:Boolean = false;
		public static var hud:FlxGroup;
		
		//Constructor
		public function PlayState() 
		{
			
		}
		
		override public function create():void
		{
			Scores.currentLevel++;
			//Add a non-moving heads up display
			hud = new FlxGroup();
			//Create a new player and add it to the state
			player = new Player(42,525);
			add(player);
			
			//Play level 1
			if (Scores.currentLevel == 1)
			{
				level = new Level1();
				add(level);
				FlxG.collide(level, player);//collision
			}
			
			//Create level bounds and have the camera follow the player
			FlxG.worldBounds = new FlxRect(0, 0, level.width, level.height);
			FlxG.camera.setBounds(0, 0, level.width, level.height);
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			
			//Add player's bullets
			add(player.pistol.group);
			//Start playing the game music
			FlxG.playMusic(SndLTC);
			//Create and animate health bars based on Player's health
			heartsPNG = new FlxSprite(45, 0, heartPNG);
			heartsPNG.loadGraphic(heartPNG, false, false, 61, 16);
			heartsPNG.addAnimation("full", [0]);
			heartsPNG.addAnimation("two", [1]);
			heartsPNG.addAnimation("one", [2]);
			heartsPNG.play("full");
			//Add it to the state
			hud.add(heartsPNG);
			//No collision with hearts
			heartsPNG.solid = false;
			//Indicator is star has been gotten
			nStar = new FlxSprite(465, 3, starEmptyPNG);
			yStar = new FlxSprite(465, 3, starPNG);
			hud.add(nStar);
			//Update text for the player to see whilst playing the game
			sampleText = new FlxText(0, 0, 300);
			sampleText2 = new FlxText(120, 0, 350);
			//Add all these things
			hud.add(sampleText);
			hud.add(sampleText2);
			hud.add(nStar);
			hud.add(yStar);
			//Hide the fact that having the star was added
			yStar.visible = false;
			//Make sure the HUD doesn't move
			hud.setAll("scrollFactor", point);
			//Add it do the state
			add(hud);
		}
		
		//This is the main game loop function, where all the logic is done.
		override public function update():void
		{
			
			super.update();
			//Add a counter
			counter += FlxG.elapsed;
			//Alter text
			sampleText.text = "Coins: "+coinCounter;
			//Hide mouse if player presses screen
			if(FlxG.mouse.justPressed())
					FlxG.mouse.hide();
			//If player gets the star
			if (hasStar == true && yStar.visible == false)
			{
				//Display that the player has the star
				yStar.visible = true;
				nStar.visible = false;
			}
			
			//If the player reaches level 2
			if (Scores.currentLevel == 2 && updated==0)
			{
				//Get rid of their star
				hasStar = false;
				//Get rid of level 1
				remove(level);
				//Add level 2
				level2 = new Level2();
				add(level2);
				updated = 1;
				//change player's coordinates to match the level
				player.x = 42;
				player.y = 231;
				//get rid of the HUD (to be added later so its z-value will be on top)
				remove(hud);
				
			}
		}
	}
}