package com.hechoal.AleatoryTD{
	//importing required classes for this to work
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.ColorTransform;

	
	public class EmptyBlock extends Sprite{//defining the class as EmptyBlock

		public function EmptyBlock(e:MovieClip){//this function will always run once EmptyBlock is called
			buttonMode = false;
			
			graphics.lineStyle(1, e.colorEmpty+0x202020, 0.8);
			graphics.beginFill(e.colorEmpty, 0.2);
			graphics.drawRect(0,0,25,25);
			graphics.endFill();
			
			addEventListener(MouseEvent.CLICK, thisClick);
		}
		
		
		protected function thisMouseOver(e:MouseEvent):void{}
		protected function thisMouseOut(e:MouseEvent):void{	}
		
		protected function thisClick(e:MouseEvent):void{
			if((mouseX%25)==0 || (mouseY%25)==0) return
			MovieClip(parent).makeTurret(x,y);
		}		
		
		public function destroy(){
			graphics.clear();
			MovieClip(parent).removeChild(this);
			removeEventListener(MouseEvent.CLICK, thisClick);
		}
	}
}