package 
{
	/**
	 * See Level1.as (very similar)
	 */
    import org.flixel.*;
	
	public class Level2 extends BaseLevel 
	{
		[Embed(source = "../map/mapCSV_Group2_Coins.csv", mimeType = "application/octet-stream")] protected var coinsCSV2:Class;
		[Embed(source = "../map/mapCSV_Group2_Map.csv", mimeType = "application/octet-stream")] protected var mapCSV2:Class;
		[Embed(source = "../map/mapCSV_Group2_Map2.csv", mimeType = "application/octet-stream")] protected var map2CSV2:Class;
		[Embed(source = "../map/mapCSV_Group2_Map4.csv", mimeType = "application/octet-stream")] protected var skyCSV2:Class;
		static public var map:FlxTilemap;
		static public var map2:FlxTilemap;
		private var shooter1:Shooter;
		private var chest:Chest;
		private var key1:Key;
		private var key2:Key;
		private var key3:Key;
		private var lock1:Lock;
		private var lock2:Lock;
		private var lock3:Lock;
		private var spring:Spring;
		private var star1:Star;
		private var cake1:Cake;
		private var candle2:Candle;
		private var candle3:Candle;
		private var bat1:Bat;
		private var bat2:Bat;
		public function Level2()
		{
			FlxG.bgColor = 0xff1679ff;
			super();
			map = new FlxTilemap;
			map.loadMap(new mapCSV2, mapTilesPNG, 21, 21, 0, 0, 1, 31);
			map2 = new FlxTilemap;
			map2.loadMap(new map2CSV2, mapTilesPNG, 21, 21, 0, 0, 1, 460);
			map.setTileProperties(355, FlxObject.UP,null,null,5);
			shooter1 = new Shooter(556, 226, 1000, 100, 800);
			add(shooter1);
			
			width = map.width;
			height = map.height;
			add(map);
			
			parseCoins();
			chest = new Chest(42, 526);
			add(chest);
			key1 = new Key(482, 389, "red");
			add(key1);
			key2 = new Key(106, 380, "yellow");
			add(key2);
			key3 = new Key(378, 231, "green");
			add(key3);
			lock1 = new Lock(105, 42, "green");
			add(lock1);
			lock2 = new Lock(273, 42, "yellow");
			add(lock2);
			lock3 = new Lock(441, 42, "red");
			add(lock3);
			add(map2);
			spring = new Spring(0, 630, 2400);
			add(spring);
			star = new Star(0, 63);
			add(star);
			cake = new Cake(196, 99);
			add(cake);
			candle3 = new Candle(147, 525, 84, 170);
			add(candle3);
			candle2 = new Candle(168, 630, 63, 336);
			add(candle2);
			bat1 = new Bat(610, 460, 610, 750, 3);
			add(bat1);
			bat2 = new Bat(42, 462, 42, 462, 3);
			add(bat2);
			add(PlayState.hud);
		}
		override protected function parseCoins():void
		{
			var coinMap:FlxTilemap = new FlxTilemap();
			
			coinMap.loadMap(new coinsCSV2, coinPNG, 21, 21);
			
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
		override public function update():void
		{
			super.update();
			if (FlxG.keys.R && PlayState.player.x >= -1 && PlayState.player.x <= 21 && PlayState.player.y == 231)
			{
				PlayState.sampleText2.text = "Hey! You read me! Just for that I'll block a pesky enemy for you!";
				Shooter.shots.setBulletLifeSpan(1);
			}
			
			(FlxG.collide(Shooter.shots.group, map))
			
		}
	}
	
}