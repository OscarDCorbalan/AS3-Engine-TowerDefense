package  com.hechoal.AleatoryTD.Turrets{
	import com.hechoal.AleatoryTD.Engine;
	import com.hechoal.AleatoryTD.Enemies.*;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import com.hechoal.AleatoryTD.UI.UIBox;
	import com.hechoal.AleatoryTD.gaObjectPool.gaObjectPool;
	
	
	public class TurretYellow extends Turret{		
		
		var pool:gaObjectPool;
		protected var damage75:uint;
		protected var damage50:uint;
		
		public function TurretYellow(u:UIBox, xml:XML, p:gaObjectPool){
			super(u,new Bitmap(new yellow1(0, 0)));
			reloadTime = xml.Turrets.Yellow.reloadtime;
			damage = xml.Turrets.Yellow.damage;
			range = xml.Turrets.Yellow.range;
			
			val = xml.Turrets.Yellow.price;
			price = xml.Turrets.Yellow.price;
			
			damage75 = damage * 0.75;
			damage50 = damage * 0.5;
			baseDmg = damage;
			baseRng = range;
			rngInc = xml.Turrets.Yellow.level.range;
			dmgInc = xml.Turrets.Yellow.level.damage;
			pool = p;
		}
		
		override protected function clean(){
			finalize();
			pool = null;
		}
		
		override public function getLevelUpCost():uint{
			return price/2 + (level-1)*50;
		}
		
		override public function levelup(e:Event){
			levelUpCommon();
			damage75 = damage * 0.75;
			damage50 = damage * 0.5;
			cTime -= 5;
			reloadTime -= 5;			
			
			switch(level){
				case 2: _b = new Bitmap(new yellow2(0, 0)); break;
				case 3: _b = new Bitmap(new yellow3(0, 0)); break;
				case 4: _b = new Bitmap(new yellow4(0, 0)); break;
				case 5: _b = new Bitmap(new yellow5(0, 0)); break;
				case 6: _b = new Bitmap(new yellow6(0, 0)); break;
				case 7: _b = new Bitmap(new yellow7(0, 0)); break;
				case 8: _b = new Bitmap(new yellow8(0, 0)); break;
				case 9: _b = new Bitmap(new yellow9(0, 0)); break;
			}
			
			weaponUpCommon(_b);			
			_b = null;
			loaded = false;
			
		}

		var time:uint = 48;
		
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
			
			if(outRange()){
				enTarget = null;
				hardEnemy();
			}
			
			if(enTarget != null){
				loaded = false;
				newBullet = pool.getObj();
				newBullet.init(enTarget.x+12.5-x, enTarget.y+12.5-y,pool);
				newBullet.x = x;
				newBullet.y = y;
				if(enTarget is EnemyYellow){
					enTarget.health -= damage50 * enTarget.radared;		
				}
				else if(enTarget is EnemyRed || enTarget is EnemyGreen){
					enTarget.health -= damage75 * enTarget.radared;		
				}
				else
					enTarget.health -= damage * enTarget.radared;
				MovieClip(parent.parent).addChild(newBullet);
				newBullet = null;
				
			}		
			
		}
		
		override public function getLevelText():String{
			return "Reduces reload time\n"
		}
		
		override public function getWeapInfo():String{
			return "";
		}
	}
	
}
