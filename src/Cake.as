package 
{
	/**
	 * An object class. Meant to end the evel and the main premise for the game. Collision will affect the Playstate's current level
	 * and call the StatState.
	 */
	
	//Imports
	import org.flixel.*;
	
	public class Cake extends FlxSprite 
	{
		//Source Variables
        [Embed(source = "images/cake.png")] private var cakePNG:Class; 
		
		//Constructor
		public function Cake(X:int,Y:int)
		{
			super(X, Y, cakePNG);
			//Don't move
			immovable = true;
		}
		
		override public function update():void
		{
			super.update();
			//Collision between cake and player
			if (FlxG.collide(this, PlayState.player))
			 touched();
		}
		
		public function touched():void
		{
			//Show player's current stats
			FlxG.switchState(new StatState());
		}
		
		
	}
	
}