package 
{
	/**
	 * An object class. An enemy that can be killed by the player that has bullet that can hurt the player as well. 
	 */
	//Imports
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Candle extends FlxExtendedSprite 
	{
		//Source Variables
		[Embed(source = "images/candle.png")] public var candlePNG:Class;
		[Embed(source = "images/fireBullet.png")] public var fireBulletPNG:Class;
		
		//Variables
		protected var fireBall:FlxWeapon;
		private var boundMin:int;
		private var boundMax:int;
		private var cHealth:int;
		protected var weaponName:String;
		public function Candle(X:int, Y:int, BoundMin:int, BoundMax:int, Health:int = 5)
		{
			super(X, Y, candlePNG);
			x = X;
			y = Y;
			//Health
			cHealth = Health;
			//Boundaries
			boundMax = BoundMax-10;
			boundMin = BoundMin;
			//Load image and different animations
			loadGraphic(candlePNG, true, true, 10, 21);
			addAnimation("movement", [0, 1], 3);
			addAnimation("stationary", [0, 2], 3);
			addWeapon();
			immovable = true;
			//Constantly moves 50px/s
			velocity.x -= 50;
			
			weaponName = "fireBall";
		}
		override public function update():void
		{
			super.update();
			//Turn candle around when it reaches its boundary
			if (this.x < boundMin || this.x > boundMax)
				velocity.x = -velocity.x;
			//Update animation and bullet directions
			if (velocity.x < 0)
			{
				facing = RIGHT;
				play("movement");
				fireBall.setBulletDirection(180,200);
			}
			else if (velocity.x > 0)
			{
				facing = LEFT;
				play("movement");
				fireBall.setBulletDirection(0,200);
			}
			else
			{
				play("stationary");
				fireBall.setBulletDirection(180,200);
			}
			shoot();
			//If candle runs out of health, kill it
			if (cHealth <= 0)
			{
				this.kill();
				Scores.enemyScore+=20;
			}
			//If collision between player bullets and candle
			if (FlxG.collide(PlayState.player.pistol.group, this))
			{
				//Remove 1 health
				cHealth--;
				//Flash the candle
				this.flicker(0.3);
			}
			//If collision between candle bullets and player
			if (FlxG.collide(fireBall.group, PlayState.player))
			{
				//Kill player (hurt)
				PlayState.player.kill();
				//Remove the bullet that came in contact with the player
				fireBall.currentBullet.kill();
			}
		}
		public function shoot():void
		{
			//If you can see the candle it will shoot, otherwise it will not
			if (onScreen())
			{
				fireBall.fire();
			}
		}
		public function addWeapon():void
		{
			//Create a fire type weapon
			fireBall = new FlxWeapon("fireBall", this, "x", "y");
			//Create the bullet's look
			fireBall.makeAnimatedBullet(1000, fireBulletPNG, 3, 3, [0, 1], 10, true, 5, 0);
			//Bullet gets killed after 1 second
			fireBall.setBulletLifeSpan(1000);
			//Bullet fires every 0.8 seconds
			fireBall.setFireRate(800);
			//Add bullets to the playstate
			FlxG.state.add(fireBall.group);
			//Make sure bullets don't dissappear
			fireBall.setBulletBounds(new FlxRect(x - 100, y - 100, 200, 200));
			
		}
	}
	
}