package core
{
	import Box2D.Common.Math.b2Vec3;
	import flash.display.Shape
	import Box2D.Common.Math.b2Vec2;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ParticleEmitter extends Entity
	{
		
		public var density:Number;
		public var randomness:int;
		public var count:uint;
		public var lifetime:Number;
		public var currentLifetime:Number;
		public var totalLifetime:Number;
		public var speed:Number;
		public var scale:Number;
		private var currentdensity:Number;
		private var particles:Array;
		public var location:b2Vec2;
		public var color:uint;
		public var randomnessHalf:Number;
		public var particle:Particle;
		//public var position:b2Vec2;
		//public var velocity:b2Vec2
		
		public function ParticleEmitter(count:uint = 500, color:uint = 0x000000, lifetime:Number = 1.5, totalLifetime:Number = -1.0, speed:Number = 5.0, scale:Number = 0.0 - 0.05, density:Number = 0.015, direction:b2Vec2 = new b2Vec2, randomness:int = 200)
		{
			this.count = count;
			this.scale = scale;
			this.direction = direction;
			this.density = density;
			this.lifetime = lifetime;
			this.currentLifetime = 0;
			this.totalLifetime = totalLifetime;
			this.color = color;
			this.currentdensity = 0;
			this.speed = speed;
			this.randomness = randomness + 1;
			this.randomnessHalf = this.randomness / 2.0;
			particles = new Array();
		
		}
		
		override public function update(time:Time):void
		{
			
			super.update(time);
			this.currentdensity -= time.delta;
			currentLifetime += time.delta;
			trace(particles.length);
			for (var i:uint = 0; i < particles.length; ++i)
			{
				//trace('dit');
				particles[i].lifetime -= time.delta;
				if (particles[i].lifetime < 0.0)
				{
					removeChild(particles[i]);
					removeItemFromArray(particles, particles[i]);
					createParticle();
					//continue;
				}
				
				//trace("hoi" );
				var random:b2Vec2 = new b2Vec2(Math.random() * 10 -5, Math.random() * 10 -5);
				
				random.x = random.x;
				random.y = random.y;
				
			//	trace(particles[i].position, particles[i].velocity);
			//	trace(particles[i].direction);
				particles[i].acceleration = this.direction.Add(random);
				particles[i].velocity.Add(particles[i].acceleration.multiply(speed));
				particles[i].position.Add(particles[i].velocity);
			}
			if (particles.length < count && this.currentdensity < 0)
			{
				this.currentdensity = this.density;
				createParticle();
			}
			if (currentLifetime > totalLifetime + lifetime && totalLifetime != -1)
			{
				parent.removeChild(this);
			}
			//trace("Particles length: ", particles.length); 
			render();
			
		}
		
		public override function render():void
		{
			graphics.clear();
			for (var i:uint = 0; i < particles.length; ++i)
			{
				
				graphics.beginFill(0x000000);
				graphics.lineStyle(0, 0x000000);
				graphics.drawEllipse(particles[i].position.x, particles[i].position.y, 10, 10);
				graphics.endFill();
				
			}
		}
		
		private function removeItemFromArray(thearray:Array, theItem:Particle):void
		{
			for (var i:int = 0; i < thearray.length; ++i)
			{
				if (thearray[i] == theItem)
				{
					thearray.splice(i, 1);
					i -= 1;
				}
			}
		}
		
		private function createParticle():void
		{
			if (currentLifetime < totalLifetime || totalLifetime < -0.9 && totalLifetime > -1.1)
			{
				var p:Particle = new Particle();
				p.position = new b2Vec2(0, 0);
				p.color = this.color;
				p.lifetime = this.lifetime;
				p.scale = this.scale
				particles.push(p);
				addChild(p);
			}
		}
	
	}

}