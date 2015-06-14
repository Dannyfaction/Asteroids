package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;

	public class Asteroid extends MovieClip
	{
		private var controlDir:Point;
		private var asteroidFlash:AsteroidFlash;
		private var speed:Number = 0;
		public var xMove:Number;
		public var yMove:Number;
		public var randomPoint1:Point;
		public var randomNumber:Number;
		public var leftOrRight:Number;
		private var timer:Number;
		private var flySpeed:Number;
		private var boolean:Boolean = false;
		
		public function Asteroid():void
		{
			//var my_color:ColorTransform = new ColorTransform();
			//my_color.color = 0xFF0000;
			//this.transform.colorTransform = my_color;
			
			controlDir = new Point(0, 0);
			randomPoint1 = new Point(0, 0);
			this.addEventListener(Event.ENTER_FRAME, loop);
			asteroidFlash = new AsteroidFlash();
			this.scaleX = this.scaleY = 0.8;
			addChild(asteroidFlash);
			randomPoint1.y = randRange(-100, 800);
			randomNumber = randRange(5, 20);
			leftOrRight = randRange(1, 11);
			flySpeed = randRange(2, 4);
			if (leftOrRight <= 5) {
				controlDir.y = -1;
				this.x = -100;
				this.y = randomPoint1.y;
			}
			else {
				controlDir.y = 1;
				this.x = 1500;
				this.y = randomPoint1.y;
			}
		}
		private function randRange(min:Number, max:Number):Number {
			var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
			return randomNum;
		}
		private function randomTurnLeft():void {
			this.rotation -= randomNumber;
		}
		private function randomTurnRight():void {
			this.rotation += randomNumber;
		}
				
		public function get AsteroidX():Number {
			return this.x;
		}
		
		public function get AsteroidY():Number {
			return this.y;
		}
		
		private function loop(e:Event):void 
		{
			speed = controlDir.y * -flySpeed;
			this.rotation += controlDir.x * 5;
			var radian:Number = this.rotation * Math.PI / 180;
			xMove = Math.cos(radian);
			yMove = Math.sin(radian);
			this.x += xMove * speed;
			this.y += yMove * speed;
			
			if (leftOrRight <= 5 && this.y < 490 && boolean == false) {
				boolean = true;
				randomTurnRight();
				//controlDir.x = 2;
			}
			if (leftOrRight <= 5 && this.y > 490 && boolean == false) {
				boolean = true;
				randomTurnLeft();
				//controlDir.x = -2;
			}
			if (leftOrRight > 5 && this.y < 490 && boolean == false) {
				boolean = true;
				randomTurnLeft();
				//controlDir.x = -2;
			}
			if (leftOrRight > 5 && this.y > 490 && boolean == false) {
				boolean = true;
				randomTurnRight();
				//controlDir.x = 2;
			}
			else {
				controlDir.x = 0;
			}
		}
		
	}

}