package 
{
	/**
	 * A general class that holds variables for its children classes so they are less bulky and redundant.
	 */
	
	//Imports
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*
	
	public class BaseLevel extends FlxGroup
	{
		//Source Variables
		[Embed(source = "images/coinS.png")] protected var coinPNG:Class;
		[Embed(source = "images/gems.png")] protected var gemPNG:Class;
		[Embed(source = "images/sprites.png")] protected var mapTilesPNG:Class;
		[Embed(source = "images/keys.png")] protected var keyPNG:Class;
		[Embed(source = "images/star.png")] protected var starPNG:Class;
		[Embed(source = "images/cake.png")] protected var cakePNG:Class;
		[Embed(source = "images/back.png")] protected var backTiles1PNG:Class;
		[Embed(source = "images/back2.png")] protected var backTiles2PNG:Class;
		
		//Variables
		public var width:int;//Level Width
		public var height:int;//Level Height
		public var totalCoins:int;//Coin counter
		public var lock:Lock;
		public var key:Key;
		protected var shooter:Shooter;
		protected var star:Star;
		protected var candle1:Candle;
		protected var cake:Cake;
		public var coins:FlxGroup;
		
		//Constructor
		public function BaseLevel()
		{
		}
		
		override public function update():void
		{
			super.update();
			//Collision: Player Bullets, This Level
			FlxG.collide(this, PlayState.player.pistol.group)
			//Collision: Player, This Level
			FlxG.collide(this, PlayState.player)
			//FlxG.collide(this, shooter);
		}
		
		protected function parseCoins():void
		{
		}
	}
	
}