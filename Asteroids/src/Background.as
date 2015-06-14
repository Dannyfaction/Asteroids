package  
{
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	
	public class Background extends MovieClip
	{
		[Embed(source="../lib/Background.jpg")]
		public var backgroundArt: Class;
		private var art:Bitmap;
		
		public function Background() 
		{
			art = new backgroundArt();
			addChild(art);
		}
		
	}

}