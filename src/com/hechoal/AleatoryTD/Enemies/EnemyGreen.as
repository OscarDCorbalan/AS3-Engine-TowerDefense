package com.hechoal.AleatoryTD.Enemies{
	import com.hechoal.AleatoryTD.Engine;
	import flash.events.Event;
	
	public class EnemyGreen extends Enemy{

		public function EnemyGreen(e:Engine, t:uint, i:uint, level:uint) {
			super(e,t,i,level);
			var ff:uint = Math.random() * 35;
			this.gotoAndPlay(ff);
			beginClass();
			heal = maxHealth * 0.001;
		}
		
		override public function slow(){
			if(slowings == 0) maxSpeed *= 0.75;
			slowings++;
		}
		override public function unslow(){
			slowings--;
			if(slowings == 0) maxSpeed *= (4/3);
		}
		
		override protected function drawMe(){			
		}

		override protected function countFrames(){
		}
		
		var heal:uint;
		override protected function eFrameEvents(e:Event):void{
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
 			
			//trace(health + " " + maxHealth + " " + maxHealth*0.001);
 			//health += heal;
			//health = (health < maxHealth)? health : maxHealth;
			
			//checking what direction it goes when finishing the path
			if(y <= -25 || y >= 425 || x >= 575 || x <= -25){
				removeEventListener(Event.ENTER_FRAME, eFrameEvents);
				destroyThis(true);
				return;
			}
			
			graphics.clear();
			
			drawMe();
			drawHealthBar();
			countFrames();			
		}
		
	}
	
}
