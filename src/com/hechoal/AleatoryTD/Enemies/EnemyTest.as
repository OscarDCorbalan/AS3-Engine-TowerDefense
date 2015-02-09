package com.hechoal.AleatoryTD.Enemies{	
	import com.hechoal.AleatoryTD.t;
	import flash.filters.DropShadowFilter;
	import flash.display.MovieClip;
	import com.hechoal.AleatoryTD.Tester;
	import flash.events.Event;
	
	public class EnemyTest extends MovieClip{

		var bgmc:MovieClip = new MovieClip();
		var inc:Boolean = true;
		var tes:Tester;
		
		public function EnemyTest (e:Tester, t:uint, i:uint, level:uint) {
			tes = e;
			ini = i;
			addChild(life);
			frame = Math.random() * 12;
			addChild(bgmc);
			maxSpeed *= 1.5;
			maxHealth *= 0.75;
			health *= 0.75;
			beginClass();
		}
		
		override protected function eFrameEvents(e:Event):void{
			if(tes.gameOver){
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
 
			//checking what direction it goes when finishing the path
			if(y <= -25 || y >= 425 || x >= 575 || x <= -25){
				removeEventListener(Eventes.ENTER_FRAME, eFrameEvents);
				destroyThis(true);
				return;
			}
			
			graphics.clear();
			
			drawMe();
			countFrames();			
		}

		override protected function destroyThis(removeLife:Boolean,giveMoney:Boolean = false):void{
			graphics.clear();
			if(removeLife) 
				tes.removeLife();
			else if(giveMoney){
				tes.addMoney(money);
				tes.addScore(maxHealth);
				for(sta = 0; sta < 15; sta++){
					_part = Particle(tes.poolP.getObj());
					_partes.init(x+12.5,y+12.5,color,tes.poolP);
					tes.addChild(_part);		
				}
			}
			
			tes.enemyHolder.removeChild(this);			
			life = null;
			objective = null;
			t = null;
		}
		
		var ff:Number;
		override protected function drawMe(){			
			ff = frame/40;
			
			graphics.lineStyle(2,0x0000FF);
			if(xSpeed > 0){
				gotoAndStop(1);
				scaleX = 0.8 + ff;				
			}				
			else if (xSpeed < 0){
				gotoAndStop(3);
				scaleX = 0.8 + ff;
			}				
			else if (ySpeed > 0){
				gotoAndStop(2);
				scaleY = 0.8 + ff;				
			}
			else if (ySpeed < 0){
				gotoAndStop(4);
				scaleY = 0.8 + ff;				
			}
			life.scaleX = 1/scaleX;
    		life.scaleY = 1/scaleY;
		}
	
	
		override protected function countFrames(){
			if(inc) frame++;
			else frame--;
			if(frame>=12 || frame <= 0) inc = !inc;
			
		}
	}
}
