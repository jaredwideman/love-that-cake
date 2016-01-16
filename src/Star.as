package 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Star extends FlxSprite 
	{
		[Embed(source = "images/star.png")] public var star:Class;
		public function Star(X:int, Y:int)
		{
			super(X+6, Y+6, star);
			loadGraphic(star, false, false, 9, 9);
		}
		override public function update():void
		{
			super.update();
			if (FlxG.collide(this, PlayState.player))
			{
				this.kill();
				PlayState.hasStar = true;
				FlxG.camera.flash(0xffffff00, 0.35);
				
			}
		}
	}
	
}