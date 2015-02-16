package src.Engine{
	//imports
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import src.Engine.Enemies.Enemy;

	public class DirectBlock extends Sprite{
		static const S:uint = 0x010;//"START";
		static const F:uint = 0x011;//"FINISH";
		static const U:uint = 0x100;//"UP";
		static const R:uint = 0x101;//"RIGHT";
		static const D:uint = 0x110;//"DOWN";
		static const L:uint = 0x111;//"LEFT";
		
		private var directType:uint;//type of special block
 		private var posType:uint;
		
		public function DirectBlock(e:MovieClip, type:uint,xVal:int,yVal:int){
			directType = type;
			x = xVal;
			y = yVal;
			addEventListener(Event.ADDED, beginClass);		
		}
		
		private function beginClass(e:Event):void{
			graphics.beginFill(0);
			graphics.drawRect(0,0,25,25);
			graphics.endFill();
			
			removeEventListener(Event.ADDED, beginClass);			
			addEventListener(Event.ENTER_FRAME, eFrame,false,0,true);
		}
		
		var enTarget;
		var i:uint;
		private function eFrame(e:Event):void{
			if(MovieClip(parent).gameOver){
				removeEventListener(Event.ENTER_FRAME, eFrame);
				MovieClip(parent).removeChild(this);
				enTarget = null;
				return;
			}
			//if(directType != S){				
				for(i = 0;i<MovieClip(parent).enemyHolder.numChildren;i++){
					enTarget = MovieClip(parent).enemyHolder.getChildAt(i);
					
					if(		x >= enTarget.x - enTarget.width*.1
					  	&& x <= enTarget.x + enTarget.width*.1
						&& y >= enTarget.y - enTarget.height*.1 
						&& y <= enTarget.y + enTarget.height*.1){

						if(directType == U){
							enTarget.x = x;
							enTarget.xSpeed = 0;
							enTarget.ySpeed = -enTarget.maxSpeed;
						} else if(directType == R){
							enTarget.y = y;
							enTarget.xSpeed = enTarget.maxSpeed;
							enTarget.ySpeed = 0;
						} else if(directType == D){
							enTarget.x = x;
							enTarget.xSpeed = 0;
							enTarget.ySpeed = enTarget.maxSpeed;
						} else if(directType == L){
							enTarget.y = y;
							enTarget.xSpeed = -enTarget.maxSpeed;
							enTarget.ySpeed = 0;
						}
					}
				}
			//}
		}
	}
}