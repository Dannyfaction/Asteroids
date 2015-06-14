package  
{
	import flash.text.*;
	import flash.events.Event;
	public class KeerSom extends TextField
	{  
		private var firstNumber:Number;
		private var secondNumber:Number;
		private var result:Number;
		private var screenResult:Number = 0;
		private var randomNumberGenerator:Number;
		private var welkeSom:Number;
		private var voegsel:String;
		private var color:String;
		
		[Embed(source = "../lib/EraserDust.ttf", fontName = "myFont", embedAsCFF="false")]
		private var _fontClass:Class;
		private var _font:Font = new _fontClass();
		
		public function KeerSom():void
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			this.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function randRange(min:Number, max:Number):Number {
			var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
			return randomNum;
		}
		
		public function randomSom():void
		{
			//welkeSom 1 = Keer
			//welkeSom 2 = Plus
			//welkeSom 3 = Min
			//welkeSom 4 = Gedeeld door
			firstNumber = randRange(1, 10);
			secondNumber = randRange(1, 10);
			welkeSom = randRange(1, 4);
			if (welkeSom == 1) {
				voegsel = "x";
				result = firstNumber * secondNumber;
				switch (randomNumberGenerator){
					case 1:
					screenResult = result;
					break;
					
					case 2:
					screenResult = result +(randRange(1,10));
					break;
					
					case 3:
					screenResult = result -(randRange(1, 10));
					break;
					
					case 4:
					screenResult = result;
					break;
				}
			}
			else if (welkeSom == 2) {
				voegsel = "+";
				result = firstNumber + secondNumber;
				switch (randomNumberGenerator){
					case 1:
					screenResult = result;
					break;
					
					case 2:
					screenResult = result +(randRange(1,10));
					break;
					
					case 3:
					screenResult = result -(randRange(1, 10));
					break;
					
					case 4:
					screenResult = result;
					break;
				}
			}
			else if (welkeSom == 3) {
				voegsel = "-";
				result = firstNumber - secondNumber;
				switch (randomNumberGenerator){
					case 1:
					screenResult = result;
					break;
					
					case 2:
					screenResult = result + (randRange(1,10));
					break;
					
					case 3:
					screenResult = result - (randRange(1, 10));
					break;
					
					case 4:
					screenResult = result;
					break;
				}
			}
			else if (welkeSom == 4) {
				voegsel = "/";
				result = firstNumber / secondNumber;
				switch (randomNumberGenerator){
					case 1:
					screenResult = result;
					break;
					
					case 2:
					screenResult = result + (randRange(1,10));
					break;
					
					case 3:
					screenResult = result - (randRange(1, 10));
					break;
					
					case 4:
					screenResult = result;
					break;
				}
			}
		}
		public function checkSom():Boolean {
			if (screenResult == result)
			{
				return true;
			}
			else {
				return false;
			}
		}
		
		private function init(e:Event):void 
		{
			randomNumberGenerator = randRange(1, 4);
			randomSom();
			removeEventListener(Event.ADDED_TO_STAGE, init);
			color = "0x000000";
			var format:TextFormat  = new TextFormat("myFont", 36, color, true);
			format.font = "myFont";
			this.embedFonts = true;
			this.defaultTextFormat = format;
			this.width = stage.stageWidth;
		}
		private function loop(e:Event):void 
		{
			if (welkeSom == 4) {
				this.text = firstNumber + voegsel + secondNumber + "=" + screenResult.toFixed(1);
			}
			else {
				this.text = firstNumber + voegsel + secondNumber + "=" + screenResult;
			}
		}
	}
}