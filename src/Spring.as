package 
{
	/**
	 * An object class. This is a class to launch the player at a certain speed in the y value direction.
	 */
	
	 //Imports
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Spring extends FlxExtendedSprite 
	{
		//Source Variables
		[Embed(source = "images/spring.png")] public var springy:Class;
		
		//Variables
		private var counter:Number = 0;
		private var counter2:Number = 0;
		private var hasTouched:Boolean = false;
		private var elastic:Number;
		private var yV:int;
		
		//Constructor
		public function Spring(X:int, Y:int, E:Number=1300)
		{
			super(X, Y, springy);
			yV = Y;
			elastic = E;
			//Load the springs graphic and animations based on if its used or not
			loadGraphic(springy, false, false, 21, 15);
			addAnimation("spring_unused", [0]);
			addAnimation("spring_used", [1]);
			//Default to unused
			play("spring_unused");
			//Don't let the player push the object
			immovable = true;
		}
		override public function update():void
		{
			super.update();
			//If the player is on the spring
			if (FlxG.collide(this, PlayState.player))
				//Throw the player in the air
				bounce();
				counter2 += FlxG.elapsed;
			//After player's max velocity has been altered, put it back to normal after 50 ms
			if (hasTouched == true && counter2 >=(0.05))
				PlayState.player.maxVelocity.y = 200;
		}
		public function bounce():void
		{
			counter += FlxG.elapsed;
			//Cock the spring
			play("spring_used");
			//After the player has bee standing on the spring for 200ms
			if (counter >= 0.2)
			{
				counter2 = 0;
				//Let the player's max velocity be greater than normal just after the launch
				PlayState.player.maxVelocity.y = elastic;
				//Velocity is sped up in the up direction
				PlayState.player.velocity.y -= elastic;
				//Revert spring to original state
				play("spring_unused");
				hasTouched = true;
				counter = 0;
			}
		}
	}
	
}