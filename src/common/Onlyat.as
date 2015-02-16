package src.common.AleatoryTD {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.*;
	import flash.display.MovieClip;
	public class Onlyat extends MovieClip{
		private var kong:KongButtonSmall = new KongButtonSmall();
		private var map:MapSelect;
		
		public function Onlyat(_ms:MapSelect) {			
			/*map = _ms;
			kong.x = 6;
			kong.y = 40;
			kong.addEventListener(Event.ADDED_TO_STAGE, mochilink, false, 0, true);
			addChild(kong);*/
		}
		
		private function mochilink(e:Event){
			//kong.removeEventListener(Event.ADDED_TO_STAGE, mochilink);
		}

	}
	
}
