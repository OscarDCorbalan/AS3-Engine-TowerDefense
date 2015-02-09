package com.hechoal.AleatoryTD.UI {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.hechoal.AleatoryTD.Engine;
	
	
	public class UITurretCyan extends UITurret {
		
		
		public function UITurretCyan(e:Engine,u:UIBox,xl:XMLList){
			super(e, u, xl);
			addEventListener(MouseEvent.MOUSE_OVER, ui.overTCyan);//adding function for mouseOver
			type = _cyan;
			overFun = ui.overTCyan;
		}
		
		public function getText(){
			return statsToString()
				+"\nAltering the fabric of space-time itself"
				+"\ncauses gravity wells that attract the mass"
				+"\nof near enemies, hence slowing them.";																																
		}
	}
}