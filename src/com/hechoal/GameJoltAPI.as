package com.hechoal {
	
	import com.hechoal.MD5;
	import flash.net.*;
	import flash.events.*;
	import flash.text.TextField;
	import flash.errors.*;
	import flash.display.Loader;

	public class GameJoltAPI {

		private var dataArray:Array = [];
		private var callBack:Function;
		private var today:Date = new Date();
		public var gi:uint;
		public var pk:String;		
		public var un:String;
		public var ut:String;
		
		public function GameJoltAPI(_gi: uint, _pk:String, _un:String, _ut:String){
			gi = _gi;
			pk = _pk;
			un = _un;
			ut = _ut;
		}
		
		//A1 ----- Authorizes the user
		public function authUser(callBack:Function):void  
		{
			var _ul:URLLoader = new URLLoader(new URLRequest(getAuthURL()));
			_ul.addEventListener(Event.COMPLETE, checkAuth);
			this.callBack = callBack;
		}
		
		private function getAuthURL():String {
			today = new Date();
			var tempURL:String = "http://gamejolt.com/api/game/v1/users/auth/?format=dump" + "&game_id=" + gi + "&username=" + un + "&user_token=" + ut + "&time=" + today.time;
			var signature:String = encryptURL(tempURL, pk);
			var finalURL:String = tempURL + "&signature=" + signature;
			return finalURL;
		}
		private function checkAuth(e:Event):void {
			if (e.target.data.substr(0,7) == "SUCCESS") {
				callBack(true);
			} else {
				callBack(false);
			}
		}
		//-----

		//T1 ----- Adds trophy achieved
		public function addTrophyAchieved(trophyID:int):void {
			var _ul:URLLoader = new URLLoader(new URLRequest(getTrophyURL(trophyID)));
		}
		private function getTrophyURL(trophyID:int):String {
			today = new Date();
			var tempURL:String = "http://gamejolt.com/api/game/v1/trophies/add-achieved/?format=dump" + "&game_id=" + gi + "&username=" + un + "&user_token=" + ut + "&trophy_id=" + trophyID + "&time=" + today.time;
			var signature:String = encryptURL(tempURL, pk);
			var finalURL:String = tempURL + "&signature=" + signature;
			return finalURL;
		}
		//-----

		//T2 ----- Gets trophy data
		public function getTrophyData(type:*, callBack:Function):void {
			var _ul:URLLoader = new URLLoader(new URLRequest(getTrophyDataURL(type)));
			_ul.addEventListener(Event.COMPLETE, outputData);
			this.callBack = callBack;
		}
		private function getTrophyDataURL(type:String):String {
			today = new Date();
			var tempURL:String = "http://gamejolt.com/api/game/v1/trophies/?format=keypair" + "&game_id=" + gi + "&username=" + un + "&user_token=" + ut;
			switch (type) {
					// Returns all trophies
				case "all" :
					tempURL +=  "&time=" + today.time;
					break;
					// Returns only achieved or not achieved trophies, based on the input
				case "false" :
				case "true" :
					tempURL += "&achieved=" + type + "&time=" + today.time;
					break;
					// Returns a specific trophy
				default :
					tempURL += "&trophy_id=" + type + "&time=" + today.time;
					break;
			}
			var signature:String = encryptURL(tempURL, pk);
			var finalURL:String = tempURL + "&signature=" + signature;
			return finalURL;
		}
		private function outputData(e:Event):void {
			dataArray = [];
			dataArray = separateCode(e.target.data, "\n");
			dataArray.splice(0, 1);
			for (var i:int = 0; i < dataArray.length; i++) {
				if (dataArray[i].substr(0, 9) != "image_url" && dataArray[i].substr(0, 11) != "description") {
					dataArray[i] = separateCode(dataArray[i], ":")[1];
					dataArray[i] = dataArray[i].substr(1, dataArray[i].length - 3);
				} else if (dataArray[i].substr(0, 9) == "image_url") {
					dataArray[i] = dataArray[i].substr(11, dataArray[i].length - 13);
				} else if (dataArray[i].substr(0, 11) == "description") {
					dataArray[i] = dataArray[i].substr(13, dataArray[i].length - 15);
				}
			}
			dataArray["id"] = [];
			dataArray["title"] = [];
			dataArray["description"] = [];
			dataArray["difficulty"] = [];
			dataArray["image_url"] = [];
			dataArray["achieved"] = [];
			for (i = 0; i < dataArray.length; i++) {
				var secondNum:int = Math.floor(i / 6);
				switch (i % 6) {
					case 0 :
						dataArray[i] = Number(dataArray[i]);
						dataArray["id"][secondNum] = dataArray[i];
						break;
					case 1 :
						dataArray["title"][secondNum] = dataArray[i];
						break;
					case 2 :
						dataArray["description"][secondNum] = dataArray[i];
						break;
					case 3 :
						dataArray["difficulty"][secondNum] = dataArray[i];
						break;
					case 4 :
						dataArray["image_url"][secondNum] = dataArray[i];
						break;
					case 5 :
						dataArray["achieved"][secondNum] = dataArray[i];
						break;
				}
			}
			callBack(dataArray);
		}
		//-----
		
		//S2 ----- Sets highscore
		public function setHighscore(score:String, sort:Number, tableID:Number = NaN, extraData:String = ""):void {
			var _l2:URLLoader = new URLLoader(new URLRequest(setHighscoreURL(score, sort, tableID, extraData)));
		}
		private function setHighscoreURL(score:String, sort:Number, tableID:Number , extraData:String):String {
			today = new Date();
			var tempURL:String;
			tempURL = "http://gamejolt.com/api/game/v1/scores/add/" + "?game_id=" + gi + "&username=" + un + "&user_token=" + ut + "&table_id=" + tableID.toString() + "&score=" + score + "&sort=" + sort+ "&format=dump";
			var signature:String = encryptURL(tempURL, pk);
			var finalURL:String = tempURL + "&signature=" + signature;
			return finalURL;
		}
	
		private function booleanResponseData(e:Event):void {
			if (e.target.data.substr(0,7) == "SUCCESS") {
				callBack(true);
			} else {
				callBack(false);
			}
		}
		
		private function separateCode(code:String, separator:String):Array {
			if (code.substr(-separator.length, separator.length) == separator) {
				code = code.substr(0, code.length - separator.length);
			}
			var codeSegment:String;
			var codeArray:Array = [];
			for (var i:Number = 0; i < code.length; i++) {
				if (code.substr(i, separator.length) == separator) {
					codeSegment = code.substr(0, i);
					code = code.substr(i + separator.length, code.length - i + separator.length);
					codeArray.push(codeSegment);
					i = 0;
				}
			}
			codeArray.push(code);
			return codeArray;
		}

		private function encryptURL(url:String, privKey:String):String {
			return (MD5.encrypt(url + privKey));
		}
		//-----
	}
}