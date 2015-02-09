package com.hechoal.AleatoryTD {
	import flash.display.*;
    import flash.system.*;
    import flash.utils.ByteArray;
	import mochi.as3.*;
	import flash.events.*;
	import flash.net.*;
	import com.hechoal.*;
	import flash.text.TextField;
	import flash.text.TextFormat;

	[SWF (width = 550, height = 550)]
	public class AleatoryTD extends Sprite{
		[Embed (source = "/AleatoryTD.swf", mimeType = "application/octet-stream")]
		private var f323:Class;
		var _mochiads_game_id:String = "f7d2b8f81e05ce10";
		private const nyet:String = "safe$gq342q3f3"
		private const da:String = "Dd	287hff9fah  7fa3#f0ia3r3a"
		private const arrivederchi:String = "da8h3@gmad`09jf";
		private var embeddedContent:MovieClip;
		
		public function AleatoryTD() {			
			addEventListener(Event.ADDED_TO_STAGE, onLoad, false, 0, true);	
		}
		var loader:Loader;
		private function onLoad(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE, onLoad);
			
			var data:ByteArray = new f323();
			for (var i:int = 0; i < (data.length & ~127); i += 128)
                agn56(data, i);
			for (; i < (data.length & ~15); i += 16)
                agn43(data, i);
			loader = new Loader();
			loader.loadBytes(data, new LoaderContext(false, new ApplicationDomain()));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad2, false,0,true);
		}

		public var _uname:String;
		public var _utoken:String;
		private function onLoad2(e:Event){
			embeddedContent = loader.content as MovieClip;
			addChild(embeddedContent);
			var mbd:Boolean = true;
			var paramObj:Object;
			if(mbd){
				var mochiLoader:Object = root.loaderInfo.loader;
			 	paramObj = LoaderInfo(mochiLoader.loaderInfo).parameters;
			}
			else{
				paramObj = LoaderInfo(root.loaderInfo).parameters;
			}
			
			
			var url:String = root.loaderInfo.url;
			
			if ( url.indexOf("gamejolt.com") != -1){
				embeddedContent.setGJ(paramObj.gjapi_username, paramObj.gjapi_token);
			}
			else{
				var apiPath:String = paramObj.kongregate_api_path || "http://www.kongregate.com/flash/API_AS3_Local.swf";
				Security.allowDomain(apiPath);
				var request:URLRequest = new URLRequest(apiPath);
				var loaderk:Loader = new Loader();
				loaderk.contentLoaderInfo.addEventListener(Event.COMPLETE, onKongLoad, false,0,true);
				loaderk.load(request);
				addChild(loaderk);
			}
			
			
		}
		private var kongregate:* = null;
		public function onKongLoad(event:Event):void
		{
			// Save Kongregate API reference
			
			kongregate = event.target.content;
			embeddedContent.setKong(kongregate);
			// Connect to the back-end
			kongregate.sharedContent.addLoadListener("Maps", onMapLoad);
			kongregate.services.connect();
			//embeddedContent.embedder = this;
			kongregate.stats.submit("Score", 0);
			kongregate.stats.submit("KillsTotal", 0); 
			kongregate.stats.submit("Kills", 0); 
			kongregate.stats.submit("Custom", 0);
			kongregate.stats.submit("Easy", 0); 
			kongregate.stats.submit("Slot", 0); 
			kongregate.stats.submit("Milky", 0); 
			kongregate.stats.submit("Normal", 0); 
			kongregate.stats.submit("Really", 0); 
			kongregate.stats.submit("Deox", 0); 
			kongregate.stats.submit("Veni", 0); 
			kongregate.stats.submit("Hard", 0); 
			kongregate.stats.submit("Waste", 0); 
			kongregate.stats.submit("UploadShared", 0);
			//embeddedContent.mapSelect.setKong(kongregate);
			//embeddedContent.mapEdit.setKong(kongregate);
			
			//stat submit at initialization
			 
			// You can now access the API via:
			// kongregate.services
			// kongregate.user
			// kongregate.scores
			// kongregate.stats
			// etc...
		}
		public function onMapLoad(params:Object) {
			var id:Number        = params.id;
			var name:String      = params.name;
			var permalink:String = params.permalink;
			var content:String   = params.content;
			var label:String     = params.label;
			   
			trace("Maps " + id + " [" + label + "] loaded: " + content);
			var la:Array = new Array();
			var k:uint;
			var l:uint = 0;
			var dbl:Boolean = false;
			
			if(content.charAt(0) == "8"){
				l = 1;
				dbl = true;
			}
			for(k = 0; k<352+l; k++){
				if(content.charAt(k) == "0") la.push(0);
				else if(content.charAt(k) == "1") la.push(1);
				else if(content.charAt(k) == "2") la.push(0x10);
				else if(content.charAt(k) == "3") la.push(0x11);
				else if(content.charAt(k) == "4") la.push(0x100);
				else if(content.charAt(k) == "5") la.push(0x101);
				else if(content.charAt(k) == "6") la.push(0x110);
				else if(content.charAt(k) == "7") la.push(0x111);	
			}			
			la.push(content.slice(352+l,content.length));			
			embeddedContent.mapSelect.custom(la,dbl);
		}
		private function agn56(block:ByteArray, index:uint=0):void
		{
			var state:ByteArray = new ByteArray();
			var round:uint;
			state.position=0;
			state.writeBytes(block, index, 128);
			dapoi209(state,52,27);
			dapoi209(state,23,62);
			dapoi209(state,42,8);
			dapoi209(state,4,17);			
			dapoi209(state,12,48);
			dapoi209(state,61,25);
			dapoi209(state,31,18);
			dapoi209(state,47,56);			
			dapoi209(state,44,15);
			dapoi209(state,33,38);
			dapoi209(state,20,55);
			dapoi209(state,58,1);			
			dapoi209(state,7,39);
			dapoi209(state,11,60);
			dapoi209(state,37,2);
			dapoi209(state,30,13);			
			dapoi209(state,35,53);
			dapoi209(state,64,14);
			dapoi209(state,28,32);
			dapoi209(state,5,57);				
			dapoi209(state,3,16);
			dapoi209(state,36,46);
			dapoi209(state,6,10);
			dapoi209(state,41,45);			
			dapoi209(state,49,9);			
			dapoi209(state,50,22);
			dapoi209(state,40,26);
			dapoi209(state,29,59);			
			dapoi209(state,25,61);
			dapoi209(state,63,21);
			dapoi209(state,34,51);
			dapoi209(state,54,19);
			block.position=index;
			block.writeBytes(state);
		}
		
		private function agn43(block:ByteArray, index:uint=0):void
		{
			var state:ByteArray = new ByteArray();
			var round:uint;
			state.position=0;
			state.writeBytes(block, index, 16);
			dapoi209(state,1,7);
			dapoi209(state,2,3);
			dapoi209(state,4,6);
			dapoi209(state,5,8);		
			block.position=index;
			block.writeBytes(state);
		}
		
		private function dapoi209(block:ByteArray, _i:uint, _j:uint):void
		{
			var tmp1:uint,
				tmp2:uint,
				tmp3:uint,
				tmp4:uint,
				tmp5:uint,
				tmp6:uint,
				tmp7:uint,
				tmp8:uint,
				tmp9:uint;
			tmp9 = block[_i];
			block[_i] = block[_j];
			block[_j] = uint.MAX_VALUE;	
			tmp2 = block[_i];
			block[_i] = block[_j];
			block[_j] = uint.MIN_VALUE				
			tmp7 = block[_i];
			block[_i] = block[_j];
			block[_j] = tmp7;	
			tmp6 = block[_i];
			block[_i] = block[_j];
			block[_j] = tmp6;	
			tmp1 = tmp7+tmp6;
			block[_i] = block[_j];
			block[_j] = tmp1;	
			tmp5 = block[_i];
			block[_i] = block[_j];
			block[_j] = tmp5;	
			tmp3 = block[_i];
			block[_i] = block[_j];
			block[_j] = tmp3;	
			tmp8 = tmp5+tmp3;
			block[_i] = block[_j];
			block[_j] = tmp2;	
			tmp4 = block[_i];
			block[_i] = block[_j];
			block[_j] = tmp9;	
		}

	}
	
}
