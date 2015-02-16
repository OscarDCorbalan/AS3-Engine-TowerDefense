package src.Engine.Enemies{
	//imports
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.display.Bitmap;
	import src.Engine.*

	//defining the class
	public class Enemy extends MovieClip{
		static const S:uint = 0x010;//"START";
		static const F:uint = 0x011;//"FINISH";
		static const U:uint = 0x100;//"UP";
		static const R:uint = 0x101;//"RIGHT";
		static const D:uint = 0x110;//"DOWN";
		static const L:uint = 0x111;//"LEFT";
		
		static const _boss:uint = 0;
		static const _red:uint = 1;
		static const _green:uint = 2;
		static const _blue:uint = 3;
		static const _yellow:uint = 4;
		static const _magenta:uint = 5;
		static const _cyan:uint = 6;		
		static const _gray:uint = 7;
		
		protected var engine:MovieClip;
		
		public var xSpeed:Number;
		public var ySpeed:Number;
		
		//stats
		public var maxSpeed:Number = 1.5;
		protected var minSpeed:Number = 0.75;
		protected var slowings:uint = 0;
		public var radared:Number = 1;
		
		public var health:int;
		public var maxHealth:uint;
		protected var money:uint;
		
		protected var type:uint;		
		protected var frame:uint = 0;
		protected var ini:uint;
		
		protected var life:Sprite = new Sprite();
		protected var objective:Sprite = new Sprite();
		protected var color:uint;
		
		public function Enemy(e:MovieClip, t:uint, i:uint, level:uint){
			engine = e;
			ini = i;
			type = t;
			health = engine.hpEnemy[level];
			maxHealth = health;		
			money = engine.mnEnemy[level];
			addChild(life);
			objective.graphics.clear();
			objective.graphics.beginFill(0xFF00FF,1);
			objective.graphics.drawRect(11,11,3,3);
			
			switch(type){
				case _boss:
					color = 0xFFFFFF;
					break;
				case _red:
					color = 0xFF0000;
					break;
				case _green:
					color = 0x00FF00;
					break;
				case _blue:
					color = 0x0000FF;
					break;
				case _yellow:
					color = 0xFFFF00;
					break;
				case _magenta:
					color = 0xFF00FF;
					break;
				case _cyan:
					color = 0x00FFFF;
					break;
				case _gray:
					color = 0xBBBBBB;
					break;
				default:
					trace("Enemy constructor error. Color " + type);
			}
		}
		
		protected function beginClass():void{
			//checking what the start direction is
			if(engine.startDir[ini] == U){//if it"s starting up
				y = 400;//set the y value off the field
				x = engine.startCoord[ini];//make the x value where it should be
				xSpeed = 0;//make it not move horizontally
				ySpeed = -maxSpeed;//make it move upwards
			} else if(engine.startDir[ini] == R){//and so on for other directions
				x = -25;
				y = engine.startCoord[ini];
				xSpeed = maxSpeed;
				ySpeed = 0;
			} else if(engine.startDir[ini] == D){
				y = -25;
				x = engine.startCoord[ini];
				xSpeed = 0;
				ySpeed = maxSpeed;
			} else if(engine.startDir[ini] == L){
				x = 550;
				y = engine.startCoord[ini];
				xSpeed = -maxSpeed;
				ySpeed = 0;
			}
			
			center = 12.5;
			radius = 5;

			addEventListener(Event.ENTER_FRAME, eFrameEvents);
		}
		
		var center:Number;
		var radius:uint;
		
		protected function drawMe(){
			
		}

		var long:uint,
			sta:int,
			end:int,
			greenbar:Number;
		protected function drawHealthBar(){
			long = (radius<<1)+5;
			sta = center-radius-2.5;
			end = center+radius+2.5;
			greenbar = health/maxHealth;
				
			//trace(ini+" "+end+" "+long+" "+greenbar+" "+redbar);
			life.graphics.clear();
			life.graphics.lineStyle(2,0x00FF00);
			life.graphics.moveTo(sta,3);
			life.graphics.lineTo(sta+long*greenbar,3);
			life.graphics.lineStyle(2,0xFF0000);
			life.graphics.lineTo(end,3);
		}
		
		protected function drawObjective(){
			//trace("pi");
			
		}
		
		public function slow(){
			if(slowings == 0) maxSpeed *= 0.5;
			slowings++;
		}
		public function unslow(){
			slowings--;
			if(slowings == 0) maxSpeed *= 2;
		}
		public function radar(_r:Number){
			if (radared < _r){
				radared = _r;
				objective.alpha = 0.8;
			}
			addChild(objective);
		}
		public function unradar(){
			if(radared==1) return;
			radared = 1;
			//trace("unradar");
			removeChild(objective);
			objective.alpha = 0;
		}
		protected var bs:Boolean = false;
		protected var i:uint;
		protected function eFrameEvents(e:Event):void{
			//checking what direction it goes when finishing the path
			if(engine.gameOver){
				removeEventListener(Event.ENTER_FRAME, eFrameEvents);
				destroyThis(false);
				return;
			}
			else if(health <= 0){
				removeEventListener(Event.ENTER_FRAME, eFrameEvents);
				destroyThis(false, true);
				return;
			}
			if(xSpeed > 0){
				xSpeed = maxSpeed;
			}
			else if(xSpeed < 0){
				xSpeed = -maxSpeed;
			}
			else if(ySpeed > 0){
				ySpeed = maxSpeed;
			}
			else if(ySpeed < 0){
				ySpeed = -maxSpeed;
			}
			x += xSpeed;
			y += ySpeed;
 			if(y <= -25 || y >= 425 || x >= 575 || x <= -25){
				removeEventListener(Event.ENTER_FRAME, eFrameEvents);
				destroyThis(true);
				return;
			}			
			graphics.clear();
			
			drawMe();
			drawHealthBar();
			if(radared > 1) drawObjective();
			countFrames();			
		}
		
		protected function countFrames(){
			
		}
		
		var _part:Particle;
		protected function destroyThis(removeLife:Boolean,giveMoney:Boolean = false):void{
			graphics.clear();
			if(removeLife) 
				engine.removeLife();
			else if(giveMoney){
				engine.addMoney(money);
				engine.addScore(maxHealth);
				for(sta = 0; sta < 15; sta++){
					_part = Particle(engine.poolP.getObj());
					_part.init(x+12.5,y+12.5,color,engine.poolP);
					engine.addChild(_part);		
				}
			}
			if(engine != null) engine.enemyHolder.removeChild(this);
			life = null;
			objective = null;
			engine = null;
		}
	}
}