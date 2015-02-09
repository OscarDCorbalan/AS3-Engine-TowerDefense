package com.hechoal {
	import flash.display.*;
	import com.hechoal.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import mochi.as3.*;
	import flash.text.*;
	
	public class Popup extends MovieClip{
		private var ttb:TextField = new TextField();
		private var user:TextField = new TextField();
		private var ttf:TextFormat = new TextFormat();	
		private var jolt:GameJoltAPI;
		public function Popup(_j:GameJoltAPI) {
			jolt = _j;
			ttf.font = "Arial";
			ttf.size = 10;
			ttf.color = 0xEEEEEE;	
			ttb.x = 5;
			ttb.y = 5;
			ttb.width = 140;	
			user.x = 5;
			user.y = 22;
			user.width = 140;
			addChild(ttb);
			addChild(user);
			mouseChildren = false;
			mouseEnabled = false;
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		private function added(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE, added);
			ttb.text = "GameJolt.com detected";
			ttb.setTextFormat(ttf);
			user.setTextFormat(ttf);
			jolt.authUser(joltIsAuth);
		}

		public function joltIsAuth(_b:Boolean){
			if(_b){
				user.text = "Hello, " + jolt.un;				
			}
			else{
				user.text = "Hello, random guest";		
			}
			user.setTextFormat(ttf);
		}

	}
	
}
