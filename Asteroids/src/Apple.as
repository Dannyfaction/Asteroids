package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.geom.ColorTransform;
	
	public class Apple extends MovieClip
	{
		public var healthSymbol:HealthSymbol;
		public var my_color:ColorTransform = new ColorTransform();
		
		public function Apple():void
		{
			my_color.color = 0xFFFFFF;
			healthSymbol = new HealthSymbol();
			addChild(healthSymbol);
			this.x = 1316;
			this.y = 733;
			this.scaleX = this.scaleY = 0.4;
			this.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void 
		{
			this.transform.colorTransform = my_color;
		}
		
	}

}