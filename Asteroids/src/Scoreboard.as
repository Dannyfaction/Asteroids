package  
{
	import flash.text.*;
	import flash.events.Event;
	public class Scoreboard extends TextField
	{  
		public var _score:Number = 0;
		
		[Embed(source = "../lib/EraserDust.ttf", fontName = "myFont", embedAsCFF="false")]
		private var _fontClass:Class;
		private var _font:Font = new _fontClass();
		
		public function set score(s:Number):void
		{
			_score = s;
			this.text = "Score: " + _score;
		}
		public function get score():Number
		{
			return _score;
		}
		public function Scoreboard():void
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void 
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var format:TextFormat  = new TextFormat("myFont", 36, 0xff0000, true);
			format.font = "myFont";
			this.embedFonts = true;
			this.defaultTextFormat = format;
			this.width = stage.stageWidth;
			this.text = "Score: " + _score;
			this.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void 
		{
			this.text = "Score: " + _score;
		}
		
		public function addScore():void
		{
			_score += 10;
		}
		
		public function removeScore():void
		{
			_score -= 20;
		}
	}
}