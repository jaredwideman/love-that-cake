package
{
	/**
	 * An Object Class. Blocks player from moving to certain coordinates. Keys unlock it.
	 */
	
	//Imports
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;

	public class Player extends FlxSprite
	{
		//Source Variables
		[Embed(source="images/player.png")] private var ImgPlayer:Class;
		[Embed(source = "images/bullet.png")] private var ImgBullet:Class;
		[Embed(source = "sounds/shot.mp3")] private var SndShoot:Class;
		
		//Variables
		public var pistol:FlxWeapon;
		public var bulletTracker:Array = new Array;
		private var bullets:FlxGroup;
		private var aim:uint;
		public static var hasKey:int;
		private var gibs:FlxEmitter;
		private var bounds:FlxRect = new FlxRect(0, 0, 10000, 10000);
		public static var hearts:int;
		public static var doubleJump:Boolean = false;
		private var jumpCounter:int;
		private var jumpTimer:Number = 0;

		//Constructor
		public function Player(X:int,Y:int)
		{
			
			super(FlxG.width / 155 - 3, FlxG.height / 2 - 2, ImgPlayer);
			//Players velocity will not exceed these values
			maxVelocity.y = 200;
			maxVelocity.x = 100;
			//Create some friction
			drag.x = maxVelocity.x * 5;
			//Health
			hearts = 3;
			//Coordinates
			x = X;
			y = Y;
			//Add all the player's animations
			addAnimation("run", [1, 0, 1, 2], 15, false);
			addAnimation("idle", [1]);
			addAnimation("jump", [2]);
			
			addAnimation("runUp", [4, 3, 4, 5], 15, false);
			addAnimation("idleUp", [4]);
			addAnimation("jumpUp", [5]);
			
			addAnimation("runDown", [7, 6, 7, 8], 15, false);
			addAnimation("idleDown", [7]);
			addAnimation("jumpDown", [8]);
			//Load player's graphic
			loadGraphic(ImgPlayer, true, true, 20, 21);
			//Create pistol
			pistol = new FlxWeapon("pistol", this, "x", "y");
			//Bullet removes after 2.5 seconds
			pistol.bulletLifeSpan = 1000;
			//Make bullet sprite (1x1 white pixel)
			pistol.makePixelBullet(100, 1, 1, 0xffffffff);
			//Kill bullet if it leaves these boundaries
			pistol.setBulletBounds(bounds);
			//Add FlxControl
			if (FlxG.getPlugin(FlxControl) == null)
			{
				FlxG.addPlugin(new FlxControl);
			}
		}
		override public function kill():void
		{
			//If player hasn't just been hit
			if (!flickering)
			{
				flicker();
				//Shake and flash camera
				FlxG.camera.shake(0.005, 0.35);
				FlxG.camera.flash(0xffffffff, 0.35);
				//Remove 1 life
				hearts--;
				if (hearts == 2)
					PlayState.heartsPNG.play("two");
				else if (hearts == 1)
					PlayState.heartsPNG.play("one");
				else if (hearts <= 0)
				{
					doubleJump = false;
					hasKey = 0;
					//Remove level so player doesn't advance when PlayState is called again
					Scores.currentLevel--;
					//If player dies, switch to stat state
					FlxG.switchState(new StatState());
				}
			}
				
		}
		
		//Basic game loop function
		override public function update():void
		{
			//Don't let player leave the map
			if (x < 0)
			{
				x = 0;
				velocity.x = 0;
			}
			if (y < 0)
			{
				y = 0;
				velocity.y = 0;
			}
			if (x > 798)
			{
				x = 798;
				velocity.x = 0;
			}
			//Quick Drop
			if (FlxG.keys.P)
			velocity.y += 10;
			//Player gravity
			acceleration.y = 200;
			//Fire Gun
			if (FlxG.keys.justPressed("O"))
			{
				pistol.fire();
				FlxG.play(SndShoot);
			}
			if (FlxG.keys.K)
			{
				kill();
			}
			//Bullet Direction
			if (aim == UP)
			{
				pistol.setBulletDirection( -90, 200);
				if (facing == RIGHT)
					pistol.setBulletOffset(13, 11);
				else if (facing == LEFT)
					pistol.setBulletOffset(6, 11);
			}
			else if (aim == RIGHT)
			{
				pistol.setBulletDirection(0, 200);
				pistol.setBulletOffset(13,11);
			}
			else if (aim == DOWN)
			{
				pistol.setBulletDirection(90, 200);
				if (facing == RIGHT)
					pistol.setBulletOffset(16, 14);
				else if (facing == LEFT)
					pistol.setBulletOffset(3, 14);
			}
			else if (aim == LEFT)
			{
				pistol.setBulletDirection(180, 200);
				pistol.setBulletOffset(7, 11);
			}
			//Aiming
			if (FlxG.keys.W)
				aim = UP
			else if (FlxG.keys.S)
				aim = DOWN;
			else
				aim = facing;
			
			//Animations
			if (PlayState.player.touching!=FLOOR)
			{
				if (aim == UP)
					play("jumpUp");
				else if (aim == DOWN)
					play("jumpDown");
				else
					play("jump");
			}
			else if(velocity.x == 0)
			{
				if (aim == UP)
					play("idleUp");
				else if (aim == DOWN)
					play("idleDown");
				else
					play("idle");
			}
			else
			{
				if (aim == UP)
					play("runUp");
				else if (aim == DOWN)
					play("runDown");
				else
					play("run");
			}
			//Jumping
			if (!doubleJump){
				if (FlxG.keys.SPACE && this.isTouching(FLOOR))
				velocity.y = -maxVelocity.y / 1.5;
			}
			//Double Jump
			else if (doubleJump)
			{
				jumpTimer += FlxG.elapsed;
				if (FlxG.keys.justPressed("SPACE") && this.isTouching(FLOOR))
				{
					jumpCounter = 0;
					jumpTimer = 0;
					jumpCounter++;
					velocity.y = -maxVelocity.y / 1.5;
				}
				if (FlxG.keys.justPressed("SPACE") && jumpCounter == 1 && jumpTimer>0.01)
				{
					velocity.y = -maxVelocity.y/1.28;
					jumpCounter = 0;
					jumpTimer = 0;
				}
			}
			if (FlxG.keys.L)//REMOVE LATER
				velocity.y = -300;
			//Movement
			acceleration.x = 0;
			if (FlxG.keys.D)
			{
				facing = RIGHT;
				acceleration.x += 1;
				velocity.x += 10;
			}
			else if (FlxG.keys.A)
			{
				facing = LEFT;
				acceleration.x -= 1;
				velocity.x -= 10;
			}
			super.update();
		}
	}
}