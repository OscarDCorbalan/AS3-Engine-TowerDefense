package  com.hechoal{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class XtendWarning extends MovieClip{

		private var btn:ProceedGreen;
		private var xt:Xtend;
		public function XtendWarning(_xt:Xtend) {
			xt = _xt;
			btn = new ProceedGreen();
			btn.x = 85;
			btn.y = 180;
			addChild(btn);
			addEventListener(Event.ADDED_TO_STAGE,added, false, 0, true);
		}
		
		private function added(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE,added);
			buttonMode = true;
			mouseEnabled = true;
			btn.addEventListener(MouseEvent.CLICK, xt.proceed, false, 0, true);
		}
		
		public function destroy(){
			btn.removeEventListener(MouseEvent.CLICK, xt.proceed);
			removeChild(btn);
			btn = null;
			xt = null;
		}

	}
	
}
