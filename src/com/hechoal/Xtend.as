package  com.hechoal{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.hechoal.AleatoryTD.Engine;

	public class Xtend extends MovieClip{

		private var warn:XtendWarning;
		private var engine:Engine;
		public function Xtend(xx:uint, yy:uint, e:Engine) {
			x=xx;
			y=yy;
			engine = e;
			addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
		}
		
		private function added(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE,added);
			alpha = 0.5;
			buttonMode = true;
			mouseEnabled = true;
			addEventListener(MouseEvent.CLICK, clicked, false, 0, true);
		}
		
		public function clicked(e:Event){
			removeEventListener(MouseEvent.CLICK, clicked);
			alpha = 1;
			buttonMode = false;
			mouseEnabled = false;
			warn = new XtendWarning(this);			
			warn.x = 140;
			warn.y = 100;
			engine.addChild(warn);
		}
		public function proceed(e:Event){
			warn.destroy();
			engine.removeChild(warn);
			engine.infiniteOn();
		}
	}
	
}
