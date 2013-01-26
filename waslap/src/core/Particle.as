package core
{
	import Box2D.Common.Math.b2Vec2;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Particle extends Sprite
	{
		public var position:b2Vec2;
		public var velocity:b2Vec2;
		public var acceleration:b2Vec2;
		public var scale:Number;
		public var color:uint;
		public var lifetime:Number;
		
	}

}