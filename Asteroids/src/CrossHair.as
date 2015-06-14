package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	
	public class CrossHair extends Sprite
	{
		[Embed(source="../lib/Shooting_Plane_-.mp3")]
		private var GunSound:Class;
		private var gunshotSound:Sound;
		private var soundChannel:SoundChannel;
		
		[Embed(source="../lib/ChalkRotated.png")]
		private var CrossHairArt:Class;
		private var art:Bitmap;
		public static const SHOOT:String = "Shoot";
		
		
		public function CrossHair() //Crosshair Toevoegen
		{
			this.mouseEnabled = false;
			Mouse.hide();
			art = new CrossHairArt();
			addChild(art);
			this.scaleX = this.scaleY = 0.5;
			art.x = -art.width / 2-20;
			art.y = -art.height / 2+120;
			
			this.addEventListener(Event.ENTER_FRAME, loop);
			this.addEventListener(MouseEvent.CLICK, onClick);
			
			gunshotSound = new GunSound as Sound;
		}
		
		private function onClick(e:MouseEvent):void
		{
			trace("Klik");
			soundChannel = gunshotSound.play(2, 1);
		}
		
		private function loop(e:Event):void 
		{
			this.x = stage.mouseX;
			this.y = stage.mouseY;
		}
		public function destroy():void
		{
			this.removeEventListener(Event.ENTER_FRAME, loop);
			//this.removeEventListener(MouseEvent.CLICK, onClick);
		}
		public function revive():void
		{
			this.addEventListener(Event.ENTER_FRAME, loop);
			//this.addEventListener(MouseEvent.CLICK, onClick);
		}
	}

}