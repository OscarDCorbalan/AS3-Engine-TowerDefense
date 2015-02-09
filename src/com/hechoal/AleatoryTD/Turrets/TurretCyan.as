package  com.hechoal.AleatoryTD.Turrets{
	import com.hechoal.AleatoryTD.Engine;
	import com.hechoal.AleatoryTD.Enemies.*;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import com.hechoal.AleatoryTD.UI.UIBox;
	import com.hechoal.AleatoryTD.gaObjectPool.gaObjectPool;
	
	
	public class TurretCyan extends Turret{

		private var pool:gaObjectPool;
		
		override protected function clean(){
			finalize();
			vTarget = null;
			//targets = [];
			//targets = null;
			pool = null;
		}
		
		public function TurretCyan(u:UIBox, xml:XML, po:gaObjectPool){
			super(u,new Bitmap(new cyan1(0, 0)));
			reloadTime = xml.Turrets.Cyan.reloadtime;
			damage = xml.Turrets.Cyan.damage;
			range = xml.Turrets.Cyan.range;
			
			val = xml.Turrets.Cyan.price;
			price = xml.Turrets.Cyan.price;
			
			baseDmg = damage;
			baseRng = range;
			rngInc = xml.Turrets.Cyan.level.range;
			dmgInc = xml.Turrets.Cyan.level.damage;
			pool = po
			vTarget = new Vector.<Enemy>(1);
		}

		var distance:Number;
		var vTarget:Vector.<Enemy>;
		override protected function eFrameEvents(e:Event):void{ 			
			if(MovieClip(parent.parent).gameOver){//destroy this if game is over
				clean();
				return
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
			
			loaded = false;
			for(j=0; j< vTarget.length; j++){
				
				vTarget[j] = null;
				vnearEnemy(j);
				
				
				if(vTarget[j] != null){
					newBullet = pool.getObj();
					newBullet.init(x,y, vTarget[j], damage, pool);
					
					MovieClip(parent.parent).addChild(newBullet);
					newBullet = null;
				}
			}

			
		}
		
		override public function levelup(e:Event){
			levelUpCommon();
			switch(level){
				case 2: 
					_b = new Bitmap(new cyan2(0, 0));
					vTarget = new Vector.<Enemy>(2);
					break;
				case 3: 
					_b = new Bitmap(new cyan3(0, 0));
					cTime-=5;
					reloadTime-=5;
					break;
				case 4: 
					_b = new Bitmap(new cyan4(0, 0)); 
					vTarget = new Vector.<Enemy>(3);
					break;
				case 5: 
					_b = new Bitmap(new cyan5(0, 0)); 
					cTime-=5;
					reloadTime-=5;
					break;
				case 6: 
					_b = new Bitmap(new cyan6(0, 0)); 
					vTarget = new Vector.<Enemy>(4);
					break;
				case 7: 
					_b = new Bitmap(new cyan7(0, 0)); 
					cTime-=5;
					reloadTime-=5;
					break;
				case 8: 
					_b = new Bitmap(new cyan8(0, 0)); 
					vTarget = new Vector.<Enemy>(5);
					break;
				case 9: 
					_b = new Bitmap(new cyan9(0, 0)); 
					cTime-=5;
					reloadTime-=5;
					break;
			}
			weaponUpCommon(_b);			
			_b = null;
		}
		
		override public function getLevelText():String{
			switch(level){
				case 2:
				case 4:
				case 6:
				case 8:
					return "Reduces reload time\n";					
				case 1:
				case 3:
				case 5: 
				case 7:
					return "1 extra target\n"
				case 9:
					return "Cannot upgrade further\n";
			}
			return "Error\n";
		}
		
		override public function getWeapInfo():String{
			switch(level){
				case 1:
					return "1 target, 50% slowdown";
				case 2: 
				case 3:
					return "2 targets, 50% slowdown";
				case 4:
				case 5: 
					return "3 targets, 50% slowdown";
				case 6:
				case 7:
					return "4 targets, 50% slowdown";
				case 8:
				case 9:
					return "5 targets, 50% slowdown";
			}
			return "Error";
		}
		
		protected function voutRange(_i:uint){
			if(vTarget[_i] == null) return true;
			if(vTarget[_i].health <= 0) return true;	
			if(Math.sqrt(Math.pow(vTarget[_i].y - y+12.5, 2) + Math.pow(vTarget[_i].x - x+12.5, 2)) >= range) return true;			
		}
		
		var _boo:Boolean;
		protected function vnearEnemy(_i:uint){
			_chosen = range;
			for(i = 0; i < MovieClip(parent.parent).enemyHolder.numChildren;i++){
				cEnemy = MovieClip(parent.parent).enemyHolder.getChildAt(i);
				
				_boo = true;
				for(k=0; k < vTarget.length ; k++){
					if(k != _i && cEnemy == vTarget[k]) 
					   //|| cEnemy.slowed)
					{
						_boo = false;
						_chosen = range;
					}
				}
				
				if(_boo){
					_tmp = Math.sqrt(Math.pow(cEnemy.y - y+12.5, 2) + Math.pow(cEnemy.x - x+12.5, 2));
					if(_tmp < _chosen){
						vTarget[_i] = cEnemy;
						_chosen = _tmp;
					}

				}
			}
		}
	}
	
}
