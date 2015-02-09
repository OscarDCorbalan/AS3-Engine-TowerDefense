package com.hechoal.AleatoryTD.Editor {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	
	public class BorderTD extends Sprite{
		static const S:uint = 2;//2
		static const F:uint = 3;//3
		
		protected var type:uint;
		protected var map:MapEdit;
		protected var where:uint;
		public function BorderTD(_me:MapEdit, _w:uint) {
			map = _me;
			where = _w;
			type = 0;
			fill(0x133937,0.3, true);
			addEventListener(MouseEvent.CLICK, clicked);
		}

		private function clicked (me:MouseEvent = null){
			type = (type+1)%4;
			if(type == 1) type == S;
			switch(type){
				case 0: fill(0x133937,0.3,true); break;
				case 1: fill(0,0.7); break;
				case S: 
					drawGradient(0x00c000);
					break;	
				case F: 
					drawGradient(0xc00000);
					break;		
			}
			map.f5();
		}
		
		protected function drawGradient(_c:uint){
			var m:Matrix = new Matrix();
			switch(where){
				case 0:
					m.createGradientBox(25,25,Math.PI/2,0,0);		
					break;
				case 1:
					m.createGradientBox(25,25,3*Math.PI/2,0,0);
					break;
				case 2:
					m.createGradientBox(25,25,0,0,0);
					break;
				case 3:
					m.createGradientBox(25,25,Math.PI,0,0);
					break;
			}
			graphics.beginGradientFill(GradientType.LINEAR, [_c, 0x000000], [1,1], [0,180], m);
			graphics.drawRect(0,0,25,25);
			graphics.endFill();
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
