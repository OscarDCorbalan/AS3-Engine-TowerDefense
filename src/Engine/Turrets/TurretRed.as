package src.Engine.Turrets{
	import src.Engine.Engine;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import src.UI.UIBox;
	import src.Engine.Enemies.*;
	import src.ObjectPool.*;
	
	public class TurretRed extends Turret {
		
		override protected function clean(){
			finalize();
			vTarget = null;
			pool = null;
		}
		
		var distance:Number;
		var vTarget:Vector.<Enemy>;
		var pool:ObjectPool;
		protected var damage75:uint;
		protected var damage50:uint;
		
		public function TurretRed(u:UIBox, xml:XML){
			super(u,new Bitmap(new red1(0, 0)));
			//maxwpnlevel = 5;
			reloadTime = xml.Turrets.Red.reloadtime;
			damage = xml.Turrets.Red.damage;
			damage75 = damage * 0.75;
			damage50 = damage * 0.5;
			range = xml.Turrets.Red.range;
			
			val = xml.Turrets.Red.price;
			price = xml.Turrets.Red.price;
			
			baseDmg = damage;
			baseRng = range;
			rngInc = xml.Turrets.Red.level.range;
			dmgInc = xml.Turrets.Red.level.damage;
			
			vTarget = new Vector.<Enemy>(1);
			
			pool = new ObjectPool(Class(Laser),5);
		}
		
		
		override protected function eFrameEvents(e:Event):void{
			if(MovieClip(parent.parent).gameOver){//destroy this if game is over
				clean();
				return;
			}

			for(j=0; j< vTarget.length; j++){
				if( voutRange(j)) {
					vTarget[j] = null;
					vnearEnemy(j);
				}
				
				if(vTarget[j] != null){
					newBullet = Laser(pool.getObj());
					newBullet.init(vTarget[j].x+15-x, vTarget[j].y+10-y,pool);
					newBullet.x = x-2.5;
					newBullet.y = y+2.5;
					
					
					if(vTarget[j] is EnemyRed){
						vTarget[j].health -= damage50 * vTarget[j].radared;
					}
					else if(vTarget[j] is EnemyMagenta || vTarget[j] is EnemyYellow){
						vTarget[j].health -= damage75 * vTarget[j].radared;		
					}
					else
						vTarget[j].health -= damage * vTarget[j].radared;
					
					MovieClip(parent.parent).addChild(newBullet);
					newBullet = null;
				}
			}
			

		}

		protected function voutRange(_i:uint){
			if(vTarget[_i] == null) return true;
			if(vTarget[_i] != null && vTarget[_i].health < 0) return true;			
			if(Math.sqrt(Math.pow(vTarget[_i].y - y+12.5, 2) + Math.pow(vTarget[_i].x - x+12.5, 2)) >= range) return true;			
		}
		
		var _boo:Boolean;
		protected function vnearEnemy(_i:uint){
			_chosen = range;
			for(i = 0; i < MovieClip(parent.parent).enemyHolder.numChildren;i++){
				cEnemy = MovieClip(parent.parent).enemyHolder.getChildAt(i);
				
				_boo = true;
				for(k=0; k < vTarget.length ; k++){
					if(k != _i && cEnemy == vTarget[k]){
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
		
		override public function getLevelUpCost():uint{
			return 150;
		}
		
		override public function levelup(e:Event){
			levelUpCommon();
			damage75 = damage * 0.75;
			damage50 = damage * 0.5;
			

			switch(level){
				case 2: _b = new Bitmap(new red2(0, 0)); break;
				case 3: _b = new Bitmap(new red3(0, 0)); break;
				case 4:	_b = new Bitmap(new red4(0, 0)); break;
				case 5:	_b = new Bitmap(new red5(0, 0)); break;
				case 6:	_b = new Bitmap(new red6(0, 0)); break;
				case 7:	_b = new Bitmap(new red7(0, 0)); break;
				case 8:	_b = new Bitmap(new red8(0, 0)); break;
				case 9:	_b = new Bitmap(new red9(0, 0)); break;
			}
			vTarget = new Vector.<Enemy>(level);//*2 -1);
			weaponUpCommon(_b);			
			_b = null;			
		}
		
		override public function weaponup(e:Event){

		}
		
		override public function getLevelText():String{
			return "Adds an extra laser\n"
		}
		
		override public function getWeapInfo():String{
			if(level==1) return "1 laser";
			return (level) + " lasers";
		}
	}
	
}
