package src.Engine.Turrets{
	import src.Engine.Engine;
	import flash.events.Event;
	import src.UI.UIBox;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	public class TurretBlue extends Turret{

		public function TurretBlue(u:UIBox, xml:XML){
			super(u,new Bitmap(new blue1(0, 0)));
			reloadTime = xml.Turrets.Blue.reloadtime;
			damage = xml.Turrets.Blue.damage;
			range = xml.Turrets.Blue.range;
			
			val = xml.Turrets.Blue.price;
			price = xml.Turrets.Blue.price;
			
			baseDmg = damage;
			baseRng = range;
			rngInc = xml.Turrets.Blue.level.range;
			dmgInc = xml.Turrets.Blue.level.damage;
		}


		var r:uint;
		var targets:Array = new Array();
		override protected function eFrameEvents(e:Event):void{ 			
			if(MovieClip(parent.parent).gameOver){
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
				loaded = false;
				
				newBullet = new BlueBullet(targets[r], damage, level);
				newBullet.x = x;
				newBullet.y = y;

				MovieClip(parent.parent).addChild(newBullet);				
			}			
		}
		
		override protected function clean(){
			finalize();
			targets = [];
			targets = null;
		}
		
		override public function getLevelUpCost():uint{
			return 250;
		}
		
		override public function levelup(e:Event){
			levelUpCommon();
			switch(level){
				case 2: _b = new Bitmap(new blue2(0, 0)); break;
				case 3: _b = new Bitmap(new blue3(0, 0)); break;
				case 4: _b = new Bitmap(new blue4(0, 0)); break;
				case 5: _b = new Bitmap(new blue5(0, 0)); break;
				case 6: _b = new Bitmap(new blue6(0, 0)); break;
				case 7: _b = new Bitmap(new blue7(0, 0)); break;
				case 8: _b = new Bitmap(new blue8(0, 0)); break;
				case 9: _b = new Bitmap(new blue9(0, 0)); break;
			}			
			weaponUpCommon(_b);
			_b = null;
		}
		

		
		override public function getLevelText():String{
			if(level == 9) return "Already at max level\n";
			return "Implodes an extra enemy\n";
		}
		override public function getWeapInfo():String{
			switch(level){
				case 1:
					return "Target + "+ 1 + " extra enemy";
				default:
					return "Target + "+ (level) + " extra enemies";
			}
			
		}
	}
	
}
