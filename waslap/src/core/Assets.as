package core {
	import flash.display.Bitmap;

	public class Assets {
	
		public function Assets() {
			
		}
		
		[Embed(source = "..\\..\\src\\assets\\images\\test.png")]
		public static const TEST:Class;
		
		public static function load(name:String) : Bitmap {
			return new Assets[name.toUpperCase()] as Bitmap;
		}
		
	}
}