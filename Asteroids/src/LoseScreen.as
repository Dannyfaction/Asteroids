package 
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	public class LoseScreen extends Sprite
	{
		//private var crossHair:CrossHair = new CrossHair();
		private var losingScreen:LosingScreen = new LosingScreen();
		private var tryAgainButton:TryAgain = new TryAgain();
		public var scoreVar:Number;
		
		public function LoseScreen():void
		{
			tryAgainButton.addEventListener(MouseEvent.CLICK, onClickTryAgain);
			losingScreen.x = -7
			losingScreen.scaleX = losingScreen.scaleY = 1.65;
			tryAgainButton.scaleX = tryAgainButton.scaleY = 1.65;
			addChild(losingScreen);
			addChild(tryAgainButton);
			//crossHair.revive();
			//addChild(crossHair);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//Mouse.show();
		}
		
		private function onClickTryAgain(e:MouseEvent):void 
		{
			trace("hoe");
		}
		
	}

}