package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	public class Main extends Sprite 
	{
		//Sound Files
		[Embed(source="../lib/Kevin MacLeod - Monkeys Spinning Monkeys.mp3")]
		private var soundClass:Class;
		private var backgroundMusic:Sound;
		private var soundChannel:SoundChannel;
		[Embed(source = "../lib/Death_Asteroids_-.mp3")]
		private var soundClass1:Class;
		private var destroyAsteroidSound:Sound;
		private var soundChannel1:SoundChannel;
		[Embed(source="../lib/Death_Plane_-.mp3")]
		private var soundClass2:Class;
		private var destroyPlaneSound:Sound;
		private var soundChannel2:SoundChannel;
		[Embed(source = "../lib/Points_-.mp3")]
		private var soundClass3:Class;
		private var pointSound:Sound;
		private var soundChannel3:SoundChannel;
		[Embed(source="../lib/voicebuzzer.mp3")]
		private var soundClass4:Class;
		private var wrongSound:Sound;
		private var soundChannel4:SoundChannel;
		
		//private var health:Health;
		private var background:Background;
		private var lives:Number = 3;
		private var apple:Apple;
		private var scoreboard:Scoreboard;
		private var keerSom:KeerSom;
		private var backToMenu:BackToMenu = new BackToMenu();
		private var plane:Plane;
		private var b:Bullet;
		private var bulletBar:BulletBar;
		public var asteroid:Asteroid;
		private var playerPos:Point;
		private var loseScreen:LoseScreen;
		private var bullets:Vector.<Bullet>;
		private var asteroids:Vector.<Asteroid>;
		private var keersommen:Array = new Array(100);
		private var healthFullArray:Array = new Array(3);
		private var healthEmptyArray:Array = new Array(3);
		private var keerAsteroidsSpawned:Boolean;
		private var plusAsteroidsSpawned:Boolean;
		private var bool:Boolean = false;
		private var toRemove:Boolean;
		public var isDead:Boolean = false;
		public var enemyTimer:Timer;
		public var i:Number = 0;
		public var timerNumber:Number = 2000;
		public var virtualLives:Number = 3;
		private var dyingAsteroid:DyingAsteroid;
		public var shakeCounter:Number = 40;
		public var colorCounter:Number = 30;
		public var colorBool:Boolean = false;
		
		public function Main():void 
		{
			Mouse.hide();
			backToMenu.scaleX = backToMenu.scaleY = 0.6;
			background = new Background();
			//health = new Health();
			addChild(background);
			addChild(backToMenu);
			scoreboard = new Scoreboard();
			apple = new Apple();
			scoreboard.x = 620;
			scoreboard.y = -5;
			addChild(scoreboard);
			bulletBar = new BulletBar();
			addChild(bulletBar);
			healthSpawnLeeg();
			healthSpawnVol();
			addChild(apple);
			plane = new Plane();
			addChild(plane);
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		public function destroy():void
		{
			plane.removeEventListener("onShoot", createBullet);
			//this.removeEventListener(Event.ENTER_FRAME, loop);
			plane.destroy();
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			plane.addEventListener("onShoot", createBullet);
			bullets = new Vector.<Bullet>();
			asteroids = new Vector.<Asteroid>();
			playerPos = new Point();
			backgroundMusic = new soundClass as Sound;
			soundChannel = backgroundMusic.play(2, 1);
			destroyAsteroidSound = new soundClass1 as Sound;
			destroyPlaneSound = new soundClass2 as Sound;
			pointSound = new soundClass3 as Sound;
			wrongSound = new soundClass4 as Sound;
			this.addEventListener(Event.ENTER_FRAME, loop);
			this.addEventListener(Event.ENTER_FRAME, loop2);
			
			enemyTimer = new Timer(timerNumber, 0);
			enemyTimer.addEventListener(TimerEvent.TIMER, asteroidSpawn);
			enemyTimer.start();
			
		}
		
		private function deleteBullet(index:Number):void
		{
			removeChild(bullets[index]);
			bullets.splice(index, 1);
			bool = false;
		}
		
		private function loop2(e:Event):void 
		{
			if (plane.dieCounter >= 59) {
				loseScreen = new LoseScreen();
				this.removeEventListener(Event.ENTER_FRAME, loop);
				soundChannel2 = destroyPlaneSound.play(2, 1);
				addChild(loseScreen);
				scoreboard.x = 630;
				scoreboard.y = 300;
				addChild(scoreboard);
			}
		}
		public function remove():void {
			soundChannel.stop();
			enemyTimer.removeEventListener(TimerEvent.TIMER, asteroidSpawn);
			this.removeEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void 
		{
			
			if (colorCounter < 40) {
				colorCounter ++;
			}
			else if (colorCounter >= 40) {
				apple.my_color.color = 0xFFFFFF;
			}
			
			if (shakeCounter < 40) {
				shakeCounter++;
				this.x = this.y = 0;
				this.x += ShakeScreen(8).x, this.y += ShakeScreen(8).y;
			}
			else if (shakeCounter >= 40) {
				this.x = this.y = 0;
			}
			
			if(timerNumber>0){
			timerNumber -= 0.55;
			}
			
			bulletBar.scaleX = plane.counter * 0.015;
			for (var q:int = 0; q < bullets.length; q++)
			{
				toRemove = false;
				bullets[q].update();
				if (bullets[q].x > stage.stageWidth || bullets[q].x < 0 || bullets[q].y > stage.stageHeight || bullets[q].y < 0)
				{
					deleteBullet(q);
				}				
			}
			for (var p:int = 0; p < healthFullArray.length; p++) 
			{
				if (lives == 2 && virtualLives == 3)
				{
					virtualLives--;
					removeChild(healthFullArray[p]);
					healthFullArray.splice(p, 1);
				}
				if (lives == 1 && virtualLives == 2)
				{
					virtualLives--;
					removeChild(healthFullArray[p]);
					healthFullArray.splice(p, 1);
				}
				if (lives == 0 && virtualLives == 1)
				{
					virtualLives--;
					removeChild(healthFullArray[p]);
					healthFullArray.splice(p, 1);
				}
				
			}
			if (keerAsteroidsSpawned) {
				for (var k:int = 0; k < i; k++) 
				{
					keersommen[k].x = asteroids[k].AsteroidX - 70;
					keersommen[k].y = asteroids[k].AsteroidY;
					if (asteroids[k].hitTestObject(plane))
					{
						if (lives == 1) {
							destroy();
							lives--;
							i--;
							
							dyingAsteroid = new DyingAsteroid();
							addChild(dyingAsteroid);
							dyingAsteroid.x = asteroids[k].x;
							dyingAsteroid.y = asteroids[k].y;
							
							soundChannel.stop();
							soundChannel2 = destroyPlaneSound.play(2, 1);
							removeChild(asteroids[k]);
							asteroids.splice(k, 1);
							removeChild(keersommen[k]);
							keersommen.splice(k, 1);
							enemyTimer.removeEventListener(TimerEvent.TIMER, asteroidSpawn);
						}
						else {
							lives--;
							i--;
							
							dyingAsteroid = new DyingAsteroid();
							addChild(dyingAsteroid);
							dyingAsteroid.x = asteroids[k].x;
							dyingAsteroid.y = asteroids[k].y;
							
							soundChannel1 = destroyAsteroidSound.play(2, 1);
							removeChild(asteroids[k]);
							asteroids.splice(k, 1);
							removeChild(keersommen[k]);
							keersommen.splice(k, 1);
							
						}
						/*
						loseScreen = new LoseScreen();
						addChild(loseScreen);
						scoreboard.x = 630;
						scoreboard.y = 300;
						addChild(scoreboard);
						*/
						/*
						if (lives <= 0) {
							soundChannel.stop();
							enemyTimer.removeEventListener(TimerEvent.TIMER, keerAsteroidSpawn);
							soundChannel2 = destroyPlaneSound.play(2, 1);
							destroy();
							loseScreen = new LoseScreen();
							addChild(loseScreen);
							scoreboard.x = 630;
							scoreboard.y = 300;
							addChild(scoreboard);
						}
						else {
							lives--;
							removeChild(asteroids[k]);
							asteroids.splice(k, 1);
							removeChild(keersommen[k]);
							keersommen.splice(k, 1);
							soundChannel2 = destroyPlaneSound.play(2, 1);
						}
						break;
						*/
					}
				}
				for (var l:int = 0; l < bullets.length; l++) 
				{
					if (bool == true)
					{
						for (var m:int = 0; m < asteroids.length; m++) 
						{
							if (bullets[l].hitTestObject(asteroids[m]))
							{
								if (keersommen[m].checkSom() == false) {
									i--;
									
									dyingAsteroid = new DyingAsteroid();
									addChild(dyingAsteroid);
									dyingAsteroid.x = asteroids[m].x;
									dyingAsteroid.y = asteroids[m].y;
									
									soundChannel4 = wrongSound.play(2, 1);
									removeChild(asteroids[m]);
									asteroids.splice(m, 1);
									removeChild(keersommen[m]);
									keersommen.splice(m, 1);
									deleteBullet(l);
									scoreboard.removeScore();
									shakeCounter = 0;
									apple.my_color.color = 0xFF0000;
									colorCounter = 0;
								} 
								else
								{
									i--;
									soundChannel3 = pointSound.play(2, 1);
									
									dyingAsteroid = new DyingAsteroid();
									addChild(dyingAsteroid);
									dyingAsteroid.x = asteroids[m].x;
									dyingAsteroid.y = asteroids[m].y;
									
									removeChild(asteroids[m]);
									asteroids.splice(m, 1);
									removeChild(keersommen[m]);
									keersommen.splice(m, 1);
									deleteBullet(l);
									scoreboard.addScore();
									apple.my_color.color = 0x00FF00;
									colorCounter = 0;
								}
								break;
							}
						}
					}
				}
			}
			playerPos.x = plane.x;
			playerPos.y = plane.y;
		}
		private function randRange(min:Number, max:Number):Number {
			var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
			return randomNum;
		}
		
		private function asteroidSpawn(e:TimerEvent):void 
		{
			asteroid = new Asteroid();
			asteroids.push(asteroid);	
			addChild(asteroid);
			keerSom = new KeerSom();
			keersommen[i] = keerSom;
			addChild(keerSom);
			i++;
			keerAsteroidsSpawned = true;
		}
		private function healthSpawnVol():void
		{
			for (var a:int = 0; a < lives; a++) 
			{
				var healthFull:HealthFull = new HealthFull();
				healthFullArray.push(healthFull);
				healthFullArray[a] = healthFull;
				addChild(healthFull);
				healthFull.y = 680;
				healthFull.x = 270-a*90;
			}
		}
		private function healthSpawnLeeg():void
		{
			for (var w:int = 0; w < 3; w++) 
			{
				var healthEmpty:HealthEmpty = new HealthEmpty();
				healthEmptyArray.push(healthEmpty);
				healthEmptyArray[w] = healthEmpty;
				addChild(healthEmpty);
				healthEmpty.y = 680;
				healthEmpty.x = 90+w*90;
			}
		}
		private function ShakeScreen(shakynes:int):Point
		{
			var shakeX:int;
			var shakeY:int;
			
			if (Math.random() < 5) shakynes = shakynes;
			else shakynes = shakynes - (shakynes * 2);
			
			shakeX = Math.random() * shakynes;
			shakeY = Math.random() * shakynes;
			
			var movingPoint:Point = new Point(shakeX, shakeY);
			var opositeMovingPoint:Point = new Point(shakeX - (shakeX * 2), shakeY - (shakeY * 2))
			
			var shakePos:Point;
			
			if (Math.random() > 0.5) shakePos = movingPoint;
			
			else shakePos = opositeMovingPoint;
			
			return shakePos;

		}
		
		private function createBullet(e:Event):void 
		{
			var r:Number = plane.turretAngle + plane.rotation;
			var tPos:Point = new Point(plane.x, plane.y);
			b = new Bullet(r,tPos);
			bullets.push(b);			
			addChild(b);
			bool = true;
		}
		
	}
	
}