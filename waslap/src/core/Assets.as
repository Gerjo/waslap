package core {
	import flash.display.Bitmap;

	public class Assets {
	
		public function Assets() {
			
		}
		
		[Embed(source = "..\\..\\src\\assets\\images\\test.png")]
		private static const TEST:Class;
		
		[Embed(source = "..\\..\\src\\assets\\images\\krijtboord.png")]
		private static const BACKGROUND:Class;
		
		public static function load(name:String) : Bitmap {
			return new Assets[name.toUpperCase()] as Bitmap;
		}
		
	}
}