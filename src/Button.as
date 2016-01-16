package 
{
	/**
	 * An object class. Collision with the button will 'trigger' something.
	 */
	
	//Imports
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;

	public class Button extends FlxExtendedSprite 
	{
		//Source Variables
		[Embed(source = "images/sprites.png")] public var button:Class;
		
		//Variables
		private var cD:String;//Color, Direction
		public static var hit:Boolean = false;
		
		//Constructor
		public function Button(X:int, Y:int, color_direction:String="blue_up")
		{
			super(X, Y, button);
			cD = color_direction;
			//Load button visual
			loadGraphic(button, false, false, 21, 21);
			//Create various animations for different button colors and directions
			addAnimation("yellow_up", [71]);
			addAnimation("green_up", [72]);
			addAnimation("red_up", [100]);
			addAnimation("blue_up", [101]);
			addAnimation("yellow_down", [141]);
			addAnimation("green_down", [142]);
			addAnimation("red_down", [112]);
			addAnimation("blue_down", [113]);
			//More animations for after they've been hit
			addAnimation("yellow_up_hit", [129]);
			addAnimation("green_up_hit", [130]);
			addAnimation("red_up_hit", [158]);
			addAnimation("blue_up_hit", [159]);
			addAnimation("yellow_down_hit", [143]);
			addAnimation("green_down_hit", [144]);
			addAnimation("red_down_hit", [114]);
			addAnimation("blue_down_hit", [115]);
			//Play whatever is called
			play(color_direction);
			//This button isn't moving!
			immovable = true;
		}
		
		override public function update():void
		{
			super.update();
			//If our player or his bullets collide with the button
			if (FlxG.collide(this,PlayState.player) || FlxG.collide(this,PlayState.player.pistol.group))
			{
				//Use the _hit animation
				play(cD + "_hit");
				hit = true;
			}
		}
	}
}