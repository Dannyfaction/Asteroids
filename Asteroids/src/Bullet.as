package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Bullet extends MovieClip
	{
		private var bulletPlace:bulletFlash;
		private var plane:Plane;
		public var _isShooting:Boolean;
		public var _positionShip:Point;
		public var _rotationNumber:Number;
		public var counter:Number = 0;
		private var main:Main;
		public var xMovePlane:Number;
		public var yMovePlane:Number;
		private var moveX:Number = 0;
		private var moveY:Number = 0;
		private var speed:Number = 15;
		
		//public function timer(e:Event):void
		//{
		//	counter += 1;
		//}
		public function Bullet(r:Number, tPos:Point) 
		{
			this.addEventListener(Event.ENTER_FRAME, loop);
			super();
			addChild(new bulletFlash());
			this.rotation = r;	
			var radian:Number = r * Math.PI / 180;
			moveX = Math.cos(radian);
			moveY = Math.sin(radian);
			plane = new Plane();
			this.scaleX = this.scaleY = 0.25;
			
			this.x = tPos.x + (66 * moveX);
			this.y = tPos.y + (66 * moveY);
		}
		public function set rotationPlane(rotationNumber:Number):void
		{
			_rotationNumber = rotationNumber;
		}
		
		public function set positionShip(pos:Point):void
		{
			_positionShip = pos;
		}
		
		private function loop(e:Event):void 
		{
			
			this.x += moveX * speed;
			this.y += moveY * speed;
			/*
			this.x += xMovePlane * 15;
			this.y += yMovePlane * 15;
			if (_isShooting == true) {
				trace("hoe");
				this.x = _positionShip.x;
				this.y = _positionShip.y;
				this.rotation = _rotationNumber;
				addChild(bulletPlace);
				this.addEventListener(Event.ENTER_FRAME, timer);
			}
			if (counter >= 150) {
				removeChild(bulletPlace);
				this.removeEventListener(Event.ENTER_FRAME, timer);
				counter = -1;
			}
			this.x += moveX * speed;
			this.y += moveY * speed;
			*/
		}
		
		public function update():void
		{
			
		}
	}

}