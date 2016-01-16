package 
{
	/**
	 * An object class. A sprite that can be shot to be opened. When this happens an upgrade gem will fly out. 
	 */
	
	 //Imports
	import org.flixel.*;
	
	public class Chest extends FlxSprite
	{
		//Source Variables
		[Embed(source = "images/chest.png")] public var chestPNG:Class;
		//Variables
		private var open:Boolean = false;
		private var gem:Gem;
		
		//Constructor
		public function Chest(X:int, Y:int)
		{
			super(X, Y, chestPNG);
			x = X;
			y = Y;
			//Load graphics and open/closed animations
			loadGraphic(chestPNG, false, false, 21, 21);
			addAnimation("closed", [0]);
			addAnimation("open", [1]);
			//Start it closed
			play("closed");
			immovable = true;
			
		}
		override public function update():void
		{
			super.update();
			//If player shoots the chest and hasn't already been opened
			if (FlxG.collide(PlayState.player.pistol.group, this)&&!open)
			{
				//Open it
				open = true;
				//Show it opened
				play("open");
				//Create a new upgrade gem and have it fly out
				gem = new Gem(x, y);
				gem.velocity.x += 30;
				gem.velocity.y -= 60;
				//Add it to the state
				FlxG.state.add(gem);
				
			}
			
			//Collide te gem with the map, the player and the chest
			FlxG.collide(PlayState.player, gem);
			FlxG.collide(gem, Level2.map);
			if(FlxG.collide(this, gem))
				gem.velocity.y += 1;
		}
	}
	
}