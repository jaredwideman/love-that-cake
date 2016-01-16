package 
{
	/**
	 * An Object Class. Blocks player from moving to certain coordinates. Keys unlock it.
	 */
	
	//Imports
	import org.flixel.*;
	
	public class Lock extends FlxSprite 
	{
		//Source Variables
		[Embed(source="sounds/lock.mp3")] public var unlock:Class;
		[Embed(source = "images/locks.png")] public var lock:Class;
		
		//Constructor
		public function Lock(X:int, Y:int, color:String="blue")
		{
			//Add graphics and animations of different colors
			super(X, Y, lock);
			loadGraphic(lock, false, false, 42, 42);
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
			//If player touches lock and has a key
			if (FlxG.collide(this, PlayState.player) && Player.hasKey > 0)
			{
				//Get rid of the key, play unlock sound, remove lock
				this.kill();
				FlxG.play(unlock);
				Player.hasKey--;
			}
			
		}
	}
	
}