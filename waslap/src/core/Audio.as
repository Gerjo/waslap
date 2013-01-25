package core {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class Audio {
		public static var channels:Object = {};
		
		public function Audio() {
			
		}
		
		[Embed(source = "..\\..\\src\\assets\\audio\\barrywhite.mp3")]
		public static const BARRYWHITE:Class;
		
		[Embed(source = "..\\..\\src\\assets\\audio\\airport.mp3")]
		public static const AIRPORT:Class;
		
		public static function load(name:String) : Sound {
			return new Audio[name.toUpperCase()] as Sound;
		}
	
		public static function play(name:String, channel:Number = 0) : SoundChannel {
			if (channels[channel] != null) {
				channels[channel].stop();
			}
			
			return channels[channel] = load(name).play(0, 1);
		}
	}
}