package src.Engine.Turrets{
	import src.Engine.Engine;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import src.UI.UIBox;
	import src.ObjectPool.ObjectPool;
	
	
	public class TurretGreen extends Turret{
		protected const startX:Vector.<Number> 
					= new <Number>[-6,6,0,-6,6,6,-6,0,0];
		protected const startY:Vector.<Number> 
					= new <Number>[-6,6,0,6,-6,0,0,6,-6];
		protected var s:uint;
		var pool:ObjectPool;
		var poolT:ObjectPool;
		
		public function TurretGreen(u:UIBox, xml:XML){
			super(u,new Bitmap(new green1(0, 0)));
			reloadTime = xml.Turrets.Green.reloadtime;
			damage = xml.Turrets.Green.damage;
			range = xml.Turrets.Green.range;
			
			val = xml.Turrets.Green.price;
			price = xml.Turrets.Green.price;
			
			baseDmg = damage;
			baseRng = range;
			rngInc = xml.Turrets.Green.level.range;
			dmgInc = xml.Turrets.Green.level.damage;
			
			s=0;
			pool = new ObjectPool(Class(Missile),1);
			poolT = new ObjectPool(Class(MissileTrack),2);
		}
		
		var r:uint;
		var targets:Array = new Array();
		override protected function eFrameEvents(e:Event):void{ 			
			if(MovieClip(parent.parent).gameOver){//destroy this if game is over
				clean();
				return;
			}
			//LOADING THE TURRET
			if(!loaded){//if it isn't loaded
				cTime ++;//then continue the time
				if(cTime == reloadTime){//if time has elapsed for long enough
					loaded = true;//load the turret
					cTime = 0;//and reset the time
				}
			}
			
			if(!loaded) return;
			
			//FINDING RANDOM ENEMY WITHIN RANGE		
			targets = [];
			for(i = 0; i < MovieClip(parent.parent).enemyHolder.numChildren;i++){
				cEnemy = MovieClip(parent.parent).enemyHolder.getChildAt(i);
				if(Math.sqrt(Math.pow(cEnemy.y - y+12.5, 2) + Math.pow(cEnemy.x - x+12.5, 2)) < range){
					targets.push(cEnemy);
				}
			}
			
			if(targets.length > 0){
				r = Math.random() * targets.length;
				loaded = false;//then make in unable to do it for a bit
				newBullet = Missile(pool.getObj()); 
				newBullet.init(targets[r], damage, pool, poolT);
				
				//set the bullet's coordinates
				//trace(s);
				newBullet.x = x+startX[s];
				newBullet.y = y+startY[s];
				//set the bullet's target and damage
				MovieClip(parent.parent).addChild(newBullet);
				newBullet = null;
				s = (s+1)%(level);
			}
		}
		
		override protected function clean(){
			finalize();
			targets = [];
			targets = null;
			pool = null;
			poolT=null;
		}	
		
		override public function getLevelUpCost():uint{
			return 50+(level)*25;
		}
		
		override public function levelup(e:Event){
			levelUpCommon();
			cTime -= 2;
			reloadTime -= 2;			
			switch(level){
				case 2: _b = new Bitmap(new green2(0, 0)); break;
				case 3: _b = new Bitmap(new green3(0, 0)); break;
				case 4: _b = new Bitmap(new green4(0, 0)); break;
				case 5: _b = new Bitmap(new green5(0, 0)); break;
				case 6: _b = new Bitmap(new green6(0, 0)); break;
				case 7: _b = new Bitmap(new green7(0, 0)); break;
				case 8: _b = new Bitmap(new green8(0, 0)); break;
				case 9: _b = new Bitmap(new green9(0, 0)); break;
			}			
			weaponUpCommon(_b);			
			_b = null;
			loaded = false;			
		}
		
		override public function getLevelText():String{
			return "Adds an extra launcher\n"
		}
		
		override public function getWeapInfo():String{
			if(level == 1) return "1 launcher";
			return level + " launchers";
		}
	}
	
}
