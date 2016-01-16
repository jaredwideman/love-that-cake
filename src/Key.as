package 
{
	/**
	 * An Object Class. Used for opening locks.
	 */
	
	//Imports
	import org.flixel.*;
	
	public class Key extends FlxSprite 
	{
		//Source Variables
		[Embed(source = "images/keys.png")] public var key:Class;
		public function Key(X:int, Y:int, color:String="blue")
		{
			//Load graphics and animations for different colored keys
			super(X, Y, key);
			loadGraphic(key, false, false, 21, 21);
			addAnimation("yellow", [0]);
			addAnimation("green", [1]);
			addAnimation("red", [2]);
			addAnimation("blue", [3]);
			play(color);
			immovable = true;
		}
		override public function update():void
		{
			super.update();
			//Collision between key and player
			if (FlxG.collide(this, PlayState.player))
			{
				//Add key and remove it from state
				Player.hasKey++;
				this.kill();
			}
			
		}
	}
	
}