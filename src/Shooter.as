package 
{
	/**
	 * An object class. This class is used to add a shooter to put behind any tile in a tilemap. By doing this, any stationary 
	 * enemy won't need their own weapon, they can just use this stationary shooter.
	 */
	
	//Imports
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Shooter extends FlxSprite
	{    
		//Source Variables
        [Embed(source = "images/bullet.png")] private var ImgNothing:Class; 
		
		//Variables
		private var sBounds:FlxRect;
		private var sB:Number;
		public static var shots:FlxWeapon;
		
		//Constructor
		public function Shooter(X:Number, Y:Number, SquareBounds:Number=1000, BulletSpeed:Number=400, FireRate:Number=1350)
		{
			super(X, Y, ImgNothing);
			//Give this sprite a weapon
			shots = new FlxWeapon("autoShooter", this, "x", "y");
			shots.makePixelBullet(1000, 3, 3,0xffffffff);
			shots.setFiringPosition(X, Y);
			shots.setFireRate(FireRate);
			shots.bulletLifeSpan = 1000;
			shots.setBulletSpeed(BulletSpeed);
			sB = SquareBounds;
			//Add shots to state
			FlxG.state.add(shots.group);
			//Collision is true and it cannot be moved
			solid = true;
			immovable = true;
			//Set its bullet bounds
			shots.setBulletBounds(new FlxRect(-5000, -5000, 10000, 10000));
		}
		
		override public function update():void
		{
			super.update();
			//If you can see the shooter
			if (onScreen())
				//Fire bullets where the player's x and y coordinates are that that moment in time	
				shots.fireAtTarget(PlayState.player);
			//If any of the bullets hit the player
			if (FlxG.collide(shots.group, PlayState.player))
			{
				//Hurt the player
				PlayState.player.kill();
				//Remove bullet
				shots.currentBullet.kill();
			}
		}
	}
	
}