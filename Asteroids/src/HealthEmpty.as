package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Bitmap;
	
	public class HealthEmpty extends MovieClip
	{
		public var hartjeLeeg:HartjeLeeg;
		
		public function HealthEmpty():void
		{
			hartjeLeeg = new HartjeLeeg();
			addChild(hartjeLeeg);
			this.scaleX = this.scaleY = 0.65;
		}
		
	}

}