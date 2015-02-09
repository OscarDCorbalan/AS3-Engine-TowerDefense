package com.hechoal.AleatoryTD.Editor {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	
	public class SquareTD extends Sprite{
		static const S:uint = 2;//2
		static const F:uint = 3;//3
		static const U:uint = 4;//4
		static const R:uint = 5;//5
		static const D:uint = 6;//6
		static const L:uint = 7;//7
		
		protected var type:uint;
		protected var map:MapEdit;
		public function SquareTD(_me:MapEdit) {
			map = _me;
			type = 0;
			fill(0x133937,0.3,true);
			addEventListener(MouseEvent.CLICK, clicked);
		}

		private function clicked (me:MouseEvent = null){
			type = (type+1)%8;
			if(type == S || type == F) 
				type = U;
			trace(type);
			switch(type){
				case 0: fill(0x133937,0.3,true); break;
				case 1: fill(0,0.7); break;
				case U: 
					fill(0,0.7); 
					graphics.lineStyle(1,0xffffff,1);
					graphics.beginFill(0xffffff, 1);
					graphics.moveTo(8,10);
					graphics.lineTo(17,10);
					graphics.lineTo(12,5);
					graphics.endFill()
					graphics.lineStyle(1,0xffffff,1);
					graphics.moveTo(12,10);
					graphics.lineTo(12,18);
					break;
				case R: 
					fill(0,0.7);
					graphics.lineStyle(1,0xffffff,1);
					graphics.beginFill(0xffffff, 1);
					graphics.moveTo(14,8);
					graphics.lineTo(14,16);
					graphics.lineTo(20,12);
					graphics.endFill()
					graphics.lineStyle(1,0xffffff,1);
					graphics.moveTo(14,12);
					graphics.lineTo(6,12);
					break;
				case D: 
					fill(0,0.7); 
					graphics.lineStyle(1,0xffffff,1);
					graphics.beginFill(0xffffff, 1);
					graphics.moveTo(8,14);
					graphics.lineTo(17,14);
					graphics.lineTo(12,19);
					graphics.endFill()
					graphics.lineStyle(1,0xffffff,1);
					graphics.moveTo(12,14);
					graphics.lineTo(12,6);
					break;
				case L: 
					fill(0,0.7); 
					graphics.lineStyle(1,0xffffff,1);
					graphics.beginFill(0xffffff, 1);
					graphics.moveTo(10,8);
					graphics.lineTo(10,16);
					graphics.lineTo(5,12);
					graphics.endFill()
					graphics.lineStyle(1,0xffffff,1);
					graphics.moveTo(10,12);
					graphics.lineTo(18,12);
					break;
			}
			map.f5();
		}
		
		protected function fill(_c:uint, _a:Number, _b:Boolean = false){
			graphics.clear();
			if(_b){
				graphics.lineStyle(1,0x28719B,1);
				graphics.beginFill(_c, _a);
				graphics.drawRect(0,0,25,25);
				graphics.endFill();			
			}
			else{
				graphics.beginFill(_c, _a);
				graphics.drawRect(0,0,25,25);
				graphics.endFill();			
			}
		}
		
		public function getType():uint{
			return type;
		}
	}
	
}
