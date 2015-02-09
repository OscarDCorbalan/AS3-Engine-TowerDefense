package com.hechoal.AleatoryTD {
	import flash.events.*;
	import flash.net.*;
	import flash.display.MovieClip;
	import mochi.as3.MochiServices;
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
		
		private function mochilink(e:Event){
			kong.removeEventListener(Event.ADDED_TO_STAGE, mochilink);
			MochiServices.addLinkEvent("http://x.mochiads.com/link/4641208750a4ed41", "http://www.kongregate.com/games/ketero/chromatic-tower-defense?referrer=ketero", kong);
		}
	}
	
}
