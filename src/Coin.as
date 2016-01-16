package  
{
	/**
	 * An object class. Form of currency (or score at this point). 
	 */
	
	 //Imports
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Coin extends FlxSprite
	{
		//Source Variables
		[Embed(source = 'images/coinS.png')] private var coinPNG:Class;
		
		//Constructor
		public function Coin(X:int, Y:int)
		{
			super(X*21, Y*21, coinPNG);
			solid = false;
		}
		override public function update():void
		{
			super.update()
			//If player touches a non-transparent part of the coin
			if (FlxCollision.pixelPerfectCheck(this,PlayState.player))
			{
				//Add coin to counter and remove coin from state
				PlayState.coinCounter++;
				this.kill();
			}
		}
		
	}

}