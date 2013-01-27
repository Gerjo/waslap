package core {
	import flash.display.Bitmap;
	
	public class Assets {
		
		public function Assets() {
		
		}
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\fuse.png")]
		private static const FUSE:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\pulse1.png")]
		private static const PULSE:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\pulse2.png")]
		private static const STATIC:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\groenpulse.png")]
		private static const GREENPULSE:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\groenkalm.png")]
		private static const GREENSTATIC:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\geelpulse.png")]
		private static const YELLOWPULSE:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\geelkalm.png")]
		private static const YELLOWSTATIC:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\roodpulse.png")]
		private static const REDPULSE:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\roodkalm.png")]
		private static const REDSTATIC:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\note.png")]
		private static const NOTE:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\in-game\\running.png")]
		private static const RUNNING:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\playbutton.png")]
		private static const PLAYBUTTON:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\playbuttonpressed.png")]
		private static const PLAYBUTTONPRESSED:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\buttoncontrols.png")]
		private static const CONTROLSBUTTON:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\buttoncontrolspressed.png")]
		private static const CONTROLSBUTTONPRESSED:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\buttoncredits.png")]
		private static const CREDITSBUTTON:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\buttoncreditspressed.png")]
		private static const CREDITSBUTTONPRESSED:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\buttoneasy.png")]
		private static const BUTTONEASY:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\buttoneasypressed.png")]
		private static const BUTTONEASYPRESSED:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\buttonnormal.png")]
		private static const BUTTONNORMAL:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\buttonnormalpressed.png")]
		private static const BUTTONNORMALPRESSED:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\buttonhard.png")]
		private static const BUTTONHARD:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\buttonhardpressed.png")]
		private static const BUTTONHARDPRESSED:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\test.png")]
		private static const TEST:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\menu\\menuachtergrond.png")]
		private static const BACKGROUND:Class;
		
		[Embed(source="..\\..\\src\\assets\\images\\logo.png")]
		private static const LOGO:Class;
		
		public static function load(name:String):Bitmap {
			if (Assets[name.toUpperCase()] == null) {
				throw new Error("The requested asset '" + name + "' wasn't found in Assets.as");
			}
			
			return new Assets[name.toUpperCase()] as Bitmap;
		}
	
	}
}