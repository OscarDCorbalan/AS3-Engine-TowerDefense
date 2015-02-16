package src.UI {
	
	import src.Engine.Engine;

	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	
	public class UIStats extends Sprite{
		
		var score:Number = 0;
		var money:uint;
		var lives:int;
		var level:uint = 0;
		var maxlevel:uint;
		var extended:String = "";
		protected var titleTurretsTxt:TextField = new TextField();
		protected var titleTurretsTf:TextFormat = new TextFormat();
		
		protected var scoreTxt:TextField = new TextField();
		protected var moneyTxt:TextField = new TextField();
		protected var livesTxt:TextField = new TextField();
		protected var levelTxt:TextField = new TextField();
		protected var statsTf:TextFormat = new TextFormat();
		
		protected var engine:Engine;
		protected var ui:UIBox;
		
		public function UIStats(e:Engine, u:UIBox, ml:uint) {
			engine = e;
			ui = u;
			maxlevel = ml;
			//initTitle();
			initStatFormat();
			
			initStatField(moneyTxt, 123, 24);
			initStatField(livesTxt, 123, 39);
			initStatField(levelTxt, 123, 54);
			initStatField(scoreTxt, 123, 69);
			setScore(0);
			setLevel(0);		
			
		}
		
		private function initTitle(){
			titleTurretsTf.font = "Arial";
			titleTurretsTf.size = 12;
			titleTurretsTf.color = 0xCCCCCC;
			//= 0xA35848;	
			titleTurretsTxt.x = 124;
			titleTurretsTxt.y = 4;
			titleTurretsTxt.selectable = false;
			//titleTurretsTxt.background = true;
			//titleTurretsTxt.backgroundColor = 0;
			titleTurretsTxt.autoSize = TextFieldAutoSize.LEFT;
			titleTurretsTxt.text = "Stats";
			titleTurretsTxt.setTextFormat(titleTurretsTf);
			addChild(titleTurretsTxt);	
		}
		
		private function initStatFormat(){
			statsTf.font = "Arial";
			statsTf.size = 11;
			statsTf.color = 0xEEEEEE;
		}
		
		private function initStatField(t:TextField, xx:uint, yy:uint){
			t.x = xx;
			t.y = yy;
			t.selectable = false;
			t.autoSize = TextFieldAutoSize.LEFT;
			addChild(t);				
		}
		
		public function setScore(n:Number){
			score = n*5;
			scoreTxt.text = "Score: " +score/5;
			scoreTxt.setTextFormat(statsTf);
		}
		public function setLevel(n:Number){
			level = n*10;
			levelTxt.text = "Level: " + level/10 +"/"+maxlevel +extended;
			levelTxt.setTextFormat(statsTf);
		}
		public function setMoney(n:Number){
			money = n*20;
			moneyTxt.text = "Money: $" + money/20;
			moneyTxt.setTextFormat(statsTf);
			ui.refreshUITurrets(money/20);
		}
		public function setLives(n:Number){
			if((n/3) <0) n = 0;
			lives = n*3;
			livesTxt.text = "Lives: " + lives/3;
			livesTxt.setTextFormat(statsTf);
		}
		
		public function removeLife(){
			setLives((lives/3)-1);
		}
		public function getMoney():uint{return money/20;}
		public function getLives():int{return lives/3;}
		public function getLevel():uint{return level/10;}
		public function getScore():Number{return score/5;}
		
		public function addMoney(n:uint){
			setMoney(n+money/20);
		}
		public function addScore(n:uint){
			setScore(n+score/5);
		}
		public function subMoney(n:uint){
			setMoney(money/20-n);
		}
		public function setInfinite(){
			extended = "+inf";
 		}
	
	}
	
	
	
}
