package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class MainScreen extends Sprite
	{
		public var isPlaying:Boolean = false;
		private var main:Main;
		private var menu:MenuSymbol;
		private var menuText:MenuNameSymbol;
		private var playSymbol:PlaySymbol;
		private var creditsSymbol:CreditsSymbol;
		private var tutorialSymbol:TutorialSymbol;
		private var backSymbol:BackSymbol;
		private var namesSymbol:NamesSymbol;
		private var howToPlaySymbol:HowToPlaySymbol;
		private var wadKeysSymbol:WadKeysSymbol;
		private var spaceKeysSymbol:SpaceKeysSymbol;
		private var crossHair:CrossHair;
		private var howToPlayTextSymbol:HowToPlayTextSymbol;
		
		private var clickedCredits:Boolean = false;
		private var clickedTutorial:Boolean = false;
		
		public function MainScreen():void
		{
			crossHair = new CrossHair();
			menu = new MenuSymbol();
			menuText = new MenuNameSymbol();
			playSymbol = new PlaySymbol();
			tutorialSymbol = new TutorialSymbol();
			creditsSymbol = new CreditsSymbol();
			backSymbol = new BackSymbol();
			namesSymbol = new NamesSymbol();
			howToPlaySymbol = new HowToPlaySymbol();
			wadKeysSymbol = new WadKeysSymbol();
			spaceKeysSymbol = new SpaceKeysSymbol();
			howToPlayTextSymbol = new HowToPlayTextSymbol();
			
			menu.scaleX = menu.scaleY = 1.65;
			menuText.scaleX = menuText.scaleY = 1.65;
			playSymbol.scaleX = playSymbol.scaleY = 1.65;
			tutorialSymbol.scaleX = tutorialSymbol.scaleY = 1.65;
			creditsSymbol.scaleX = creditsSymbol.scaleY = 1.65;
			backSymbol.scaleX = backSymbol.scaleY = 1.65;
			namesSymbol.scaleX = namesSymbol.scaleY = 1.65;
			howToPlaySymbol.scaleX = howToPlaySymbol.scaleY = 1.50;
			wadKeysSymbol.scaleX = wadKeysSymbol.scaleY = 1.65;
			spaceKeysSymbol.scaleX = spaceKeysSymbol.scaleY = 1.65;
			howToPlayTextSymbol.scaleX = howToPlayTextSymbol.scaleY = 1.65;
			
			addChild(menu);
			addChild(menuText);
			addChild(playSymbol);
			addChild(tutorialSymbol);
			addChild(creditsSymbol);
			addChild(crossHair);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			eventsOn();
		}
		
		public function eventsOn():void {
			playSymbol.addEventListener(MouseEvent.CLICK, onClickPlay);
			tutorialSymbol.addEventListener(MouseEvent.CLICK, onClickTutorial);
			creditsSymbol.addEventListener(MouseEvent.CLICK, onClickCredits);
			backSymbol.addEventListener(MouseEvent.CLICK, onClickBack);
		}
		
		public function eventsOff():void {
			playSymbol.removeEventListener(MouseEvent.CLICK, onClickPlay);
			tutorialSymbol.removeEventListener(MouseEvent.CLICK, onClickTutorial);
			creditsSymbol.removeEventListener(MouseEvent.CLICK, onClickCredits);
			backSymbol.removeEventListener(MouseEvent.CLICK, onClickBack);
		}
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.Q && isPlaying == true)
			{
				main.remove();
				crossHair.revive();
				addChild(crossHair);
				eventsOn();
				isPlaying = false;
				//main.destroy();
				removeChild(main);			
				main = null;
			}
		}
		
		private function onClickPlay(e:MouseEvent):void 
		{
			crossHair.destroy();
			removeChild(crossHair);
			isPlaying = true;
			eventsOff();
			main = new Main();
			addChild(main);
		}
		private function onClickTutorial(e:MouseEvent):void 
		{
			removeChild(menuText);
			clickedTutorial = true;
			addChild(backSymbol);
			addChild(howToPlaySymbol);
			addChild(wadKeysSymbol);
			addChild(spaceKeysSymbol);
			removeChild(playSymbol);
			removeChild(tutorialSymbol);
			removeChild(creditsSymbol);
			addChild(howToPlayTextSymbol);
			addChild(crossHair);
		}		
		private function onClickCredits(e:MouseEvent):void 
		{
			clickedCredits = true;
			addChild(namesSymbol);
			addChild(backSymbol);
			removeChild(playSymbol);
			removeChild(tutorialSymbol);
			removeChild(creditsSymbol);
			addChild(crossHair);
		}
		
		private function onClickBack(e:MouseEvent):void 
		{
			if (clickedCredits == true) {
				removeChild(namesSymbol);
				clickedCredits = false;
				addChild(crossHair);
			}
			if (clickedTutorial == true) {
				addChild(menuText);
				removeChild(howToPlaySymbol);
				removeChild(wadKeysSymbol);
				removeChild(spaceKeysSymbol);
				removeChild(howToPlayTextSymbol);
				clickedTutorial = false;
				addChild(crossHair);
			}
			removeChild(backSymbol);
			addChild(playSymbol);
			addChild(tutorialSymbol);
			addChild(creditsSymbol);
			addChild(crossHair);
		}
		
	}

}