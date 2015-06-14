package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class DyingAsteroid extends MovieClip
	{
		public var deathAsteroid:DeathAsteroid;
		private var counter:Number = 0;
		
		[Embed(source = "../lib/Death_Asteroids_-.mp3")]
		private var soundClass1:Class;
		private var destroyAsteroidSound:Sound;
		private var soundChannel1:SoundChannel;
		
		public function DyingAsteroid():void
		{
			this.addEventListener(Event.ENTER_FRAME, loop);
			destroyAsteroidSound = new soundClass1 as Sound;
			deathAsteroid = new DeathAsteroid();
			addChild(deathAsteroid);
			this.scaleX = this.scaleY = 0.65;
		}
		
		private function loop(e:Event):void 
		{
			counter++;
			if (counter == 20)
			{
				soundChannel1 = destroyAsteroidSound.play(2, 1);
			}
			else if (counter == 60)
			{
				removeChild(deathAsteroid);
			}
		}
		
	}

}