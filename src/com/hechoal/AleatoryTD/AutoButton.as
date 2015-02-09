package com.hechoal.AleatoryTD {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	public class AutoButton extends Sprite{
		protected var engine:Engine;
		protected var active:Boolean = false;;
		
		public function AutoButton(e:Engine) {
			//var s:Sprite
			//var s:SimpleButton
			engine = e;
			mouseEnabled = true;
			buttonMode = true;
			graphics.beginFill(0x000000,0);
			graphics.drawRect(1,1,9,9);
			graphics.endFill();
			engine.setAutoWaves(active);
			addEventListener(MouseEvent.CLICK,onClick,false,0,true);
		}

		protected function onClick(e:MouseEvent):void{
			graphics.clear();
			active = !active;
			if(active){
				graphics.beginFill(0x00FF00,0.4);
				graphics.drawRect(1,1,9,9);
				graphics.endFill();
			}
			else{
				graphics.beginFill(0x000000,0);
				graphics.drawRect(1,1,9,9);
				graphics.endFill();
			}
			engine.setAutoWaves(active);
		}
	}
	
}
