package src.UI.Screens {
	import flash.events.*;
	import flash.net.*;
	import flash.display.MovieClip;
	import fl.controls.TextInput;
	import flash.system.System;
	public class UploadNOK extends MovieClip{
		private var frames:uint;
		private var count:uint;
		private var kong:KongButton = new KongButton();
		private var ti:TextInput = new TextInput();
		private var cb:CopyCb = new CopyCb();
		
		public function UploadNOK(_f:uint, _s:String) {
			count = 0;
			frames = _f;
			
			ti.x = 10;
			ti.y = 140;
			ti.width = 200;
			ti.height = 22;
			ti.text = _s;
			addChild(ti);
			
			cb.x = 240;
			cb.y = 140;
			cb.addEventListener(MouseEvent.CLICK, copytocb,false,0,true);
			addChild(cb);
			
			addEventListener(Event.ENTER_FRAME, ef);
		}
		
		private function copytocb(e:MouseEvent){			
			System.setClipboard(ti.text);
		}
		
		private function ef(e:Event){
			count++;
			if(count >= frames){
				parent.removeChild(this);
				removeEventListener(Event.ENTER_FRAME, ef);
			}
		}

	}
	
}
