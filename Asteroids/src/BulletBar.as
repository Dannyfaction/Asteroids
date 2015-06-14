package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Bitmap;
	
	public class BulletBar extends MovieClip
	{
		public var bulletBarPlace:BulletBarPlace;
		
		public function BulletBar() 
		{
			bulletBarPlace = new BulletBarPlace();
			addChild(bulletBarPlace);
			this.x = 90;
			this.y = 47;
		}
		
	}

}