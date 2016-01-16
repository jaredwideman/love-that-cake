package 
{
	/**
	 * An Object Class. Used to allocate more player functionality (just double jump thus far).
	 */
	
	//Imports
	import org.flixel.*;
	
	public class Gem extends FlxSprite 
	{
		//Source Variables
		[Embed(source = 'images/gems.png')] private var gemPNG:Class;
		
		//Constructor
		public function Gem(X:int, Y:int)
		{
			super(X, Y, gemPNG);
			//Load gem graphic and great the different colored animation and play it
			loadGraphic(gemPNG, false, false, 11, 9);
			addAnimation("colorful", [0, 1, 2, 3], 20);
			play("colorful");
			//Make it bounce with collision.
			elasticity = 0.7;
			//Don't slide away
			drag.x = 10;
		}
		override public function update():void
		{
			super.update();
			//If player touches gem
			if (FlxG.collide(PlayState.player, this))
			{
				//Update some text, give player doublejump and remove gem
				Player.doubleJump = true;
				this.kill();
				PlayState.sampleText2.text = "DOUBLE JUMP GOT!";
			}
			//Collide gem with map
			if(FlxG.collide(this, Level2.map))
				velocity.y += 1;
			//Give gem gravity
			acceleration.y = 200;
		}
		
	}
	
}