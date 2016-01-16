package {
        import org.flixel.*; //Allows you to refer to flixel objects in your code
        [SWF(width="640", height="480", backgroundColor="#000000")] //Set the size and color of the Flash file
        [Frame(factoryClass="Preloader")]  //Tells flixel to use the default preloader

        public class loveThatCake extends FlxGame
        {
			//Constructor
			public function loveThatCake()
			{
				//Create a new FlxGame object at 480x300 with 2x pixels, then load PlayState
				super(480,300,MenuState,2);
				forceDebugger = true;
				FlxG.mouse.show();
			}
        }
}
