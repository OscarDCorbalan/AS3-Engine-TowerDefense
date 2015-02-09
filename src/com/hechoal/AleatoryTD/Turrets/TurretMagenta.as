package  com.hechoal.AleatoryTD.Turrets{
	import com.hechoal.AleatoryTD.Engine;
	import com.hechoal.AleatoryTD.Enemies.*;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import com.hechoal.AleatoryTD.UI.UIBox;
	import com.hechoal.AleatoryTD.gaObjectPool.gaObjectPool;
	
	
	public class TurretMagenta extends Turret{

		private var pool:gaObjectPool;
		var distance:Number;
		//var vTarget:Vector.<Enemy>;
		var angle:uint = 0;
		var ralpha:Number = 0.1;
		var connect:Sprite = new Sprite();
		const factor:Number = Math.PI/180;
		
		override protected function clean(){
			for(i = 0; i < MovieClip(parent.parent).turretHolder.numChildren;i++){
				cEnemy = MovieClip(parent.parent).turretHolder.getChildAt(i);

				if(cEnemy != this && cEnemy != null)
					if(cEnemy.y - y == -25 || cEnemy.y - y == 25 || cEnemy.y - y == 0)
						if(cEnemy.x - x == -25 || cEnemy.x - x == 25 || x - cEnemy.x == 0) 
							cEnemy.subRangeMult(0.1);
				
			}
			connect.graphics.clear();
			finalize();
			pool = null;
			targets = null;
		}
		
		public function TurretMagenta(u:UIBox, xml:XML, po:gaObjectPool){
			super(u,new Bitmap(new magenta1(0, 0)));
			reloadTime = xml.Turrets.Magenta.reloadtime;
			damage = xml.Turrets.Magenta.damage;
			range = xml.Turrets.Magenta.range;
			
			val = xml.Turrets.Magenta.price;
			price = xml.Turrets.Magenta.price;
			
			baseDmg = damage;
			baseRng = range;
			rngInc = xml.Turrets.Magenta.level.range;
			dmgInc = xml.Turrets.Magenta.level.damage;
			pool = po;
			//vTarget = new Vector.<Enemy>(5);
			connect.alpha = 0.7;
			connect.graphics.lineStyle(1,0xCCCCCC);
			connect.mouseEnabled = false;
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		
		override protected function added(e:Event){
			var _w:Boolean;
			var _h:Boolean;
			
			trace("added");
			for(i = 0; i < MovieClip(parent.parent).turretHolder.numChildren;i++){
				cEnemy = MovieClip(parent.parent).turretHolder.getChildAt(i);
				_w = false;
				_h = false;
				
				if(cEnemy != this){
					if(cEnemy.y - y == -25 || cEnemy.y - y == 25 || cEnemy.y - y == 0){
						_h = true;
						if(cEnemy.x - x == -25 || cEnemy.x - x == 25 || x - cEnemy.x == 0) _w = true;
					}
					if(_h && _w){
						cEnemy.addRangeMult(0.1);// * rngMult
						connect.graphics.moveTo(x,y);
						connect.graphics.lineTo(cEnemy.x,cEnemy.y);
						if(cEnemy is TurretMagenta)
							cEnemy.linkMe(this);
					}
				}
			}
			MovieClip(parent.parent).effectsHolder.addChild(connect);
			removeEventListener(Event.ADDED_TO_STAGE, added);
			addEventListener(Event.ENTER_FRAME, eFrameEvents);
		}

		public function linkMe(_tt:Turret){
			trace("link me" + _tt);
			_tt.addRangeMult(0.1);
			connect.graphics.moveTo(x,y);
			connect.graphics.lineTo(_tt.x,_tt.y);
		}
		
		public function unLinkMe(_tt:Turret){
			var _w:Boolean;
			var _h:Boolean;
			
			trace("unlink me" + _tt);
			connect.graphics.clear();
			connect.graphics.lineStyle(1,0xCCCCCC);
			for(i = 0; i < MovieClip(parent.parent).turretHolder.numChildren;i++){
				cEnemy = MovieClip(parent.parent).turretHolder.getChildAt(i);
				_w = false;
				_h = false;
				
				if(cEnemy != this && cEnemy != _tt){
					if(cEnemy.y - y == -25 || cEnemy.y - y == 25 || cEnemy.y - y == 0){
						_h = true;
						if(cEnemy.x - x == -25 || cEnemy.x - x == 25 || x - cEnemy.x == 0) _w = true;
					}
					if(_h && _w){
						connect.graphics.moveTo(x,y);
						connect.graphics.lineTo(cEnemy.x,cEnemy.y);
					}
				}
			}
		}
		
		var targets:Array = new Array();
		override protected function eFrameEvents(e:Event):void{ 			
			if(MovieClip(parent.parent).gameOver){//destroy this if game is over
				clean();
				return
			}
			
			angle = (angle>359)? 0 : angle + 1;
			newBullet = pool.getObj();
			newBullet.init(Math.cos(angle*factor)*range, Math.sin(angle*factor)*range,pool);
			//newBullet.init(0,0,pool,angle);
			newBullet.x = x;
			newBullet.y = y;
			MovieClip(parent.parent).addChild(newBullet);
			/*
			angle = (angle>359)? 0 : angle + 1;						
			newBullet = pool.getObj();
			newBullet.init(Math.cos(angle*factor)*range, Math.sin(angle*factor)*range,pool);
			newBullet.x = x;
			newBullet.y = y;
			MovieClip(parent.parent).addChild(newBullet);
			/*
			angle = (angle>range)? 0 : angle + 1;				
			newBullet = pool.getObj();
			newBullet.init(Math.cos(angle*factor)*range, Math.sin(angle*factor)*range,pool,angle);
			newBullet.x = x;
			newBullet.y = y;
			MovieClip(parent.parent).addChild(newBullet);*/
			newBullet = null;
			
			
			while(targets.length > 0){
				cEnemy = targets.pop();
				if(Math.sqrt(Math.pow(cEnemy.y - y+12.5, 2) + Math.pow(cEnemy.x - x+12.5, 2)) > range){
					cEnemy.unradar();					
				}
			}
			
			for(i = 0; i < MovieClip(parent.parent).enemyHolder.numChildren;i++){
				cEnemy = MovieClip(parent.parent).enemyHolder.getChildAt(i);
				if(Math.sqrt(Math.pow(cEnemy.y - y+12.5, 2) + Math.pow(cEnemy.x - x+12.5, 2)) < range){								
					cEnemy.radar(1.05 + (level/20));
					targets.push(cEnemy);
				}
			}
						
		}
		
		override public function getLevelUpCost():uint{
			return 50+25*level;
		}
		
		override public function levelup(e:Event){
			levelUpCommon();
			switch(level){
				case 2: _b = new Bitmap(new magenta2(0, 0)); break;
				case 3: _b = new Bitmap(new magenta3(0, 0)); break;
				case 4: _b = new Bitmap(new magenta4(0, 0)); break;
				case 5: _b = new Bitmap(new magenta5(0, 0)); break;
				case 6: _b = new Bitmap(new magenta6(0, 0)); break;
				case 7: _b = new Bitmap(new magenta7(0, 0)); break;
				case 8: _b = new Bitmap(new magenta8(0, 0)); break;
				case 9: _b = new Bitmap(new magenta9(0, 0)); break;
			}
			weaponUpCommon(_b);			
			_b = null;
		}
		

		
		override public function getLevelText():String{
			return "+5% damage to targets\n"
		}
		
		override public function getWeapInfo():String{
			return "+"+ (5+level*5) + "% damage to "
				+"\ntargets in range";
		}
	}
	
}
