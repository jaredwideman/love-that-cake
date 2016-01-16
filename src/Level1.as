package 
{
	/**
	 * An Object Class. Used to add and display Tilemaps to the playstate.
	 */
	
	//Imports
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	
	public class Level1 extends BaseLevel
	{
		[Embed(source = "../map/mapCSV_Group1_Coins.csv", mimeType = "application/octet-stream")] protected var coinsCSV:Class;
		[Embed(source = "../map/mapCSV_Group1_Map.csv", mimeType = "application/octet-stream")] protected var mapCSV:Class;
		[Embed(source = "../map/mapCSV_Group1_Map2.csv", mimeType = "application/octet-stream")] protected var map2CSV:Class;
		//Variables
		public static var map:FlxTilemap;
		public static var map2:FlxTilemap;
		private var elevator1:Elevator;
		public static var button:Button;
		public static var spring:Spring;
		protected var shooter2:Shooter;
		//Constructor
		public function Level1()
		{
			
			FlxG.bgColor = 0xffff9c00;
			//Add all tilemaps to state (background and foreground)
			super();
			
			
			map = new FlxTilemap();
			map.loadMap(new mapCSV, mapTilesPNG, 21, 21, 0, 0, 1, 31);
			map2 = new FlxTilemap();
			map2.loadMap(new map2CSV, mapTilesPNG, 21, 21, 0, 0, 1, 460);
			//Fire hurts
			map.setTileProperties(40, FlxObject.ANY, hitFire, Player);
			//Cactus is solid
			map2.setTileProperties(218, FlxObject.ANY, null, Player);
			//Signs are not solid
			map.setTileProperties(246, FlxObject.NONE);
		
			//Add lock, button, key, spring, shooter, elevator, star, candle, cake, and coins to level
			shooter2 = new Shooter(430, 76);
			add(shooter2);
			add(map);
			lock = new Lock(430, 462);
			add(lock);
			button = new Button(378, 252, "red_down");
			add(button);
			key = new Key(399, 189);
			spring = new Spring(21, 531);
			
			add(key);
			elevator1 = new Elevator(150, 230, 0, 150);
			add(elevator1);
			star = new Star(0, 336);
			add(star);
			width = map.width;
			height = map.height;
			candle1 = new Candle(315, 441, 294,336);
			add(candle1);
			
			add(map2);
			cake = new Cake(635, 607);
			add(cake);
			parseCoins();
		
		}
		
		
		public function hitFire(Tile:FlxTile, Object:FlxObject):void
		{
			//Fire kills and shoots player upward
			PlayState.player.kill();
			PlayState.player.velocity.y -= 5000;
		}
		override public function update():void
		{
			super.update();
			//Button triggers spring
			if (Button.hit == true)
			{
				add(spring);
				Button.hit = false;
			}
			
			if (FlxG.collide(Shooter.shots.group, map))
			{
				Shooter.shots.currentBullet.kill();
			}
		}
		
		//Add coins where specified to level
		override protected function parseCoins():void
		{
			var coinMap:FlxTilemap = new FlxTilemap();
			
			coinMap.loadMap(new coinsCSV, coinPNG, 21, 21);
			
			coins = new FlxGroup();
			for (var ty:int = 0; ty < coinMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < coinMap.widthInTiles; tx++)
				{
					if (coinMap.getTile(tx, ty) == 1)
					{
						coins.add(new Coin(tx, ty));
						totalCoins++;
					}
				}
			}
			add(coins);
		}
	}
	
}