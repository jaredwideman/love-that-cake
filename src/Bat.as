package 
{
	
	
	//Imports
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Bat extends Candle 
	{
		//Source Variables
		[Embed(source = "images/bat.png")] public var batPNG:Class;
		public function Bat(X:int, Y:int, BoundMin:int, BoundMax:int, Health:int = 5)
		{
			super(X, Y, BoundMin, BoundMax, Health);
			loadGraphic(batPNG, true, true, 24, 23);
			addAnimation("moving", [0, 1], 5);
			play("moving");
		}
		override public function addWeapon():void
		{
			//Create a fire type weapon
			fireBall = new FlxWeapon("fireBall", this, "x", "y");
			//Create the bullet's look
			fireBall.makeAnimatedBullet(1000, fireBulletPNG, 3, 3, [0, 1], 10, true, 5, 10);
			//Bullet gets killed after 1 second
			fireBall.setBulletLifeSpan(1500);
			//Bullet fires every 0.8 seconds
			fireBall.setFireRate(800);
			//Add bullets to the playstate
			FlxG.state.add(fireBall.group);
			//Make sure bullets don't dissappear
			fireBall.setBulletBounds(new FlxRect(x - 25000, y - 10000, 50000, 20000));
			fireBall.setBulletSpeed(100);
		}
		override public function shoot():void
		{
			//If you can see the candle it will shoot, otherwise it will not
			if (onScreen()&&(velocity.x<=0 && x>PlayState.player.x)||(velocity.x>=0 && x<PlayState.player.x))
			{
				fireBall.fireAtTarget(PlayState.player);
			}
		}
	}
	
}