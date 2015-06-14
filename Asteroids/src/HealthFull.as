package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Bitmap;
	
	public class HealthFull extends MovieClip
	{
		public var hartjeVol:HartjeVol;
		
		public function HealthFull():void
		{
			hartjeVol = new HartjeVol();
			addChild(hartjeVol);
			this.scaleX = this.scaleY = 0.65;
		}
		
	}

}