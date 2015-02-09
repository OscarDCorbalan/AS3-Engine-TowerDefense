package com.hechoal.AleatoryTD {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	public class BlindButton extends Sprite{
		protected var engine:Engine;
		protected var active:Boolean = false;;
		
		public function BlindButton(e:Engine) {
			//var s:Sprite
			//var s:SimpleButton
			engine = e;
			mouseEnabled = true;
			buttonMode = true;
			graphics.beginFill(0x000000,0.3);
			graphics.drawRect(1,1,9,9);
			engine.setBlindMode(active);
			addEventListener(MouseEvent.CLICK,onClick,false,0,true);
		}

		protected function onClick(e:MouseEvent):void{
			graphics.clear();
			active = !active;
			if(active){
				graphics.beginFill(0xFFFFFF,0.3);
				graphics.drawRect(1,1,9,9);
			}
			else{
				graphics.beginFill(0x000000,0.3);
				graphics.drawRect(1,1,9,9);
			}
			engine.setBlindMode(active);
		}
	}
	
}
