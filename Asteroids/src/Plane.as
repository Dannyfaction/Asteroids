package  
{
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	
	public class Plane extends MovieClip
	{
		[Embed(source="../lib/Shooting_Plane_-.mp3")]
		private var SoundClass:Class;
		private var portalSound:Sound;
		private var soundChannel:SoundChannel;
		//Resolution = 1400 * 979
		public var isStoppping:Boolean = false;
		public var timer:Number = 80;
		public var isShooting:Boolean;
		public var planeFlash:PlaneFlash;
		public var testExplode:TestExplode;
		private var controlDir:Point;		
		private var speed:Number = 0;
		public var turretAngle:Number = 0;
		public var shootCounter:Number = 0;
		public var xMove:Number;
		public var yMove:Number;
		public var counter:Number = 50;
		public var counterShot:Boolean = false;
		public var isDying:Boolean = false;
		public var dieCounter:Number = 0;
		//public var my_color:ColorTransform = new ColorTransform();
		
		public function Plane():void
		{
			//my_color.color = 0xDDDDDD;
			//my_color.color = undefined;
			planeFlash = new PlaneFlash();
			addChild(planeFlash);
			//addChild(testExplode);
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			this.addEventListener(Event.ENTER_FRAME, loop);
			this.x = 500;
			this.y = 490;
			controlDir = new Point(0,0);
			this.scaleX = this.scaleY = 0.25;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			portalSound = new SoundClass as Sound;
		}
		public function destroy():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			planeFlash.visible = false;
			testExplode = new TestExplode();
			addChild(testExplode);
			isDying = true;
		}
		
		private function loop(e:Event):void 
		{
			//this.transform.colorTransform = my_color;
			if (isDying == true)
			{
				dieCounter++;
				if (dieCounter == 60) {
					removeChild(testExplode);
					isDying = false;
					dieCounter = 0;
					this.removeEventListener(Event.ENTER_FRAME, loop);
				}
			}
			
			if (this.x > 1450)
			{
				this.x -= 1450;
			}
			if (this.x < -50)
			{
				this.x += 1450;
			}
			if (this.y < -50)
			{
				this.y += 845;
			}
			if (this.y > 845)
			{
				this.y -= 845;
			}
			speed = controlDir.y * -7.5;
			this.rotation += controlDir.x * 5;
			if(isStoppping == true && timer > 0)
			{
				timer--;
				controlDir.y = timer * -0.01;
			}
			else if (isStoppping == false)
			{
				timer = 80;
			}
			var radian:Number = this.rotation * Math.PI / 180;
			xMove = Math.cos(radian);
			yMove = Math.sin(radian);
			this.x += xMove * speed;
			this.y += yMove * speed;
			
			//planeFlash.rotation = angle;
			//turretAngle = planeFlash.rotation;//hiermee kun je in de main ook de turretangle lezen 
			
			if (counterShot == true) {
				counter += 1;
			}
			if (counter >= 50) {
				counterShot = false;
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.SPACE && counterShot == false)
			{
				counter = 0;
				counterShot = true;
				soundChannel = portalSound.play(2, 1);
				isShooting = true;
				dispatchEvent(new Event("onShoot"));
			}
			if (e.keyCode == Keyboard.W || e.keyCode == Keyboard.UP)
			{
				isStoppping = false
				controlDir.y = -1;
			}
			if (e.keyCode == Keyboard.A || e.keyCode == Keyboard.LEFT)
			{
				controlDir.x = -1;
			}
			/*
			if (e.keyCode == Keyboard.S || e.keyCode == Keyboard.DOWN)
			{
				controlDir.y = 1;
			}
			*/
			if (e.keyCode == Keyboard.D || e.keyCode == Keyboard.RIGHT)
			{
				controlDir.x = 1;
			}
		}
		
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.W || e.keyCode == Keyboard.UP)
			{
				isStoppping = true;
			}
			if (e.keyCode == Keyboard.A || e.keyCode == Keyboard.LEFT)
			{			
				controlDir.x = 0;
			}
			/*
			if (e.keyCode == Keyboard.S || e.keyCode == Keyboard.DOWN)
			{				
				controlDir.y = 0;
			}
			*/
			if (e.keyCode == Keyboard.D || e.keyCode == Keyboard.RIGHT)
			{					
				controlDir.x = 0;
			}
		}
		
	}
}