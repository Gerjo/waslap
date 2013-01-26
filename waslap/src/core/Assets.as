package core {
	import flash.display.Bitmap;

	public class Assets {
	
		public function Assets() {
			
		}
				
		[Embed(source = "..\\..\\src\\assets\\images\\menu\\playbutton.png")]
		private static const PLAYBUTTON:Class;
		
		[Embed(source = "..\\..\\src\\assets\\images\\menu\\playbuttonpressed.png")]
		private static const PLAYBUTTONPRESSED:Class;
		
		[Embed(source = "..\\..\\src\\assets\\images\\menu\\controlsbutton.png")]
		private static const CONTROLSBUTTON:Class;
		
		[Embed(source = "..\\..\\src\\assets\\images\\menu\\controlbuttonpressed.png")]
		private static const CONTROLSBUTTONPRESSED:Class;

		[Embed(source = "..\\..\\src\\assets\\images\\menu\\creditsbutton.png")]
		private static const CREDITSBUTTON:Class;
		
		[Embed(source = "..\\..\\src\\assets\\images\\menu\\creditsbuttonpressed.png")]
		private static const CREDITSBUTTONPRESSED:Class;
		
		[Embed(source = "..\\..\\src\\assets\\images\\test.png")]
		private static const TEST:Class;
		
		[Embed(source = "..\\..\\src\\assets\\images\\menu\\krijtboord.png")]
		private static const BACKGROUND:Class;
		
		public static function load(name:String) : Bitmap {
			if (Assets[name.toUpperCase()] == null) {
				throw new Error("The requested asset '" + name + "' wasn't found in Assets.as");
			}
			
			return new Assets[name.toUpperCase()] as Bitmap;
		}
		
	}
}