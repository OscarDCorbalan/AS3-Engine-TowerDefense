package com.hechoal.AleatoryTD.Enemies{
	import com.hechoal.AleatoryTD.*;
	import com.hechoal.AleatoryTD.gaObjectPool.*;
	import flash.system.Security;
	public class EnemyBoss extends Enemy{

		public function EnemyBoss(e:Engine, t:uint, i:uint, level:uint) {
			super(e,t,i,level);
			gotoAndPlay(1);
			beginClass();
			maxHealth *= 15;
			health *= 15;
			trace("BOSS")
			maxSpeed *= 0.8;
		}
		
		override protected function drawMe(){
		}

		override protected function destroyThis(removeLife:Boolean,giveMoney:Boolean = false):void{
			graphics.clear();
			//hack
			//if (Security.sandboxType != Security.REMOTE) engine.removeChild(engine.enemyHolder);
			if(removeLife) 
				engine.removeLife();
			else if(giveMoney){
				engine.bosskills++;
				engine.addMoney(money*20);
				engine.addScore(maxHealth);				
				for(sta = 0; sta < 100; sta++){
					_part = Particle(engine.poolP.getObj());					
					_part.init(x+12.5,y+12.5,color,engine.poolP);
					engine.addChild(_part);		
				}
			}
			
			engine.enemyHolder.removeChild(this);			
			life = null;
			engine = null;
		}
	}
	
}
