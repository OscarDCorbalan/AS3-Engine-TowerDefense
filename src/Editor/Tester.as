package src.Editor {
	
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.geom.Matrix;
	import flash.display.*;
	import flash.ui.Keyboard;
	import flash.system.Security;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import src.Engine.*;
	import src.Engine.Enemies.*;
	import src.Editor.*;
	
	public class Tester extends MovieClip{
		
		[Embed(source="/assets/data.xml", mimeType="application/octet-stream")] 
		const EmbeddedXML:Class;
		var xml:XML = new XML();
		var att:XMLList;
		
		static const S:uint = 0x010;
		static const F:uint = 0x011;
		static const U:uint = 0x100;
		static const R:uint = 0x101;
		static const D:uint = 0x110;
		static const L:uint = 0x111;
		
		static const _boss:uint = 0;
		static const _red:uint = 1;
		static const _green:uint = 2;
		static const _blue:uint = 3;
		static const _yellow:uint = 4;
		static const _magenta:uint = 5;
		static const _cyan:uint = 6;
		static const _gray:uint = 7;
		
		public var colorEmpty:uint = 0x133937;
		
		private var statsTf:TextFormat = new TextFormat();
		private var tf:TextField = new TextField();
		private var tfe:TextField = new TextField();
		private var tfq:TextField = new TextField();
		private var ret:Return = new Return();
		
		public var gameOver:Boolean = false;
		public var startDir:Array = new Array();//uint;//the direction the enemies go when they enter
		public var finDir:Array = new Array();//:uint;//the direction the enemies go when they exit		
		public var startCoord:Array = new Array();//:int;//the coordinates of the beginning of the road
		
		private var lvlArray:Array;
					
		var level:uint;
		var currentEnemy:int = 0;//the current enemy that we"re creating from the array
		var enemyTime:int = 0;//how many frames have elapsed since the last enemy was created
		var enemyLimit:int = 12;//how many frames are allowed before another enemy is created
		var enemiesLeft:int;//how many enemies are left on the field
		
		//the names of these variables explain what they do
		var currentLvl:int = 1;
		
		//create an object that will hold all parts of the road			
		var roadHolder:Sprite = new Sprite();
		public var enemyHolder:Sprite = new Sprite();

		var waveLength:Vector.<uint>;// = new Vector();
		var waveCreated:Vector.<uint>;// = new Vector();
		var waveType:Vector.<uint>;// = new Vector();
		public var hpEnemy:Vector.<uint>;
		public var mnEnemy:Vector.<uint>;		
		private var editor:MapEdit;
		private var i:uint;
		
		private var numtodelete:uint = 0;
		private var numdeleted:uint = 0;
		private var reds:Boolean = false;
		private var enemies:Boolean = false;
		
		public function Tester(_ms:MapEdit, _la:Array) {
			editor = _ms;
			lvlArray = _la;
			
			var _btm:Bitmap = new Bitmap(new mifas(0, 0));
			var _spr:Sprite = new Sprite();
			_spr.addChild(_btm);
			addChild(_spr);
			_spr.x=0;
			_spr.y=0;
			
			var contentfile:ByteArray = new EmbeddedXML();
			var contentstr:String = contentfile.readUTFBytes( contentfile.length );
			xml =  new XML( contentstr );	
			
			colorEmpty = 0x0B5682;			
			
			addChild(roadHolder);
			makeRoad();	
			addChild(enemyHolder);
			enemyHolder.mouseEnabled = false;
			enemyHolder.mouseChildren = false;
			
			var _btm2:Bitmap = new Bitmap(new uibottom(0, 0));
			var _spr2:Sprite = new Sprite();
			_spr2.addChild(_btm2);
			addChild(_spr2);			
			_spr2.y=401;
			
			hpEnemy =
			Vector.<uint>([0,150]);
					
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		}		

		private function init(e:Event):void {		
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			waveLength = new Vector.<uint>(2);
			waveCreated = new Vector.<uint>(2);
			waveType = new Vector.<uint>(2);
			mnEnemy = new Vector.<uint>(2);

			level = 1;
			var hpbase:uint = xml.Waves.hp,
				hpinc:Number = xml.Waves.hpinc,
				mnbase:uint = xml.Waves.money,
				mninc:uint = xml.Waves.moneyinc;
				
			att = xml.Waves.Wave.attributes();			
			i = 0;
			waveLength[i+1] = 1;
			waveCreated[i+1] = 0;
			waveType[i+1] = _blue;
			mnEnemy[i+1] = mnbase+i;

			trace("hpenemy: " + hpEnemy);
			trace("mnenemy: " + mnEnemy);
			
			tabChildren = false; 
 			tabEnabled = false;  
			
			statsTf.font = "Arial";
			statsTf.size = 14;
			statsTf.color = 0xEEEEEE;
			initStatField(tf, 25, 425);
			initStatField(tfe, 25, 450);
			initStatField(tfq, 25, 475);
			ret.x = 400;
			ret.y = 425;
			ret.selectable = false;
			ret.autoSize = TextFieldAutoSize.LEFT;
			addChild(ret)
			ret.addEventListener(MouseEvent.CLICK, retClick);
			
			tfe.text = "Not all enemies have exited the map through an exit";
			tfe.setTextFormat(statsTf);	
			tf.text = "Not all exit lines (red) have been reached"
			tf.setTextFormat(statsTf);	
			tfq.text = "Your map is being tested. You will automatically return to the editor when both\nconditions are met. If a monster gets blocked by a wall press the Return button\nand correct your map. When the map passes the test you will be able to Play it."
			tfq.setTextFormat(statsTf);	
			addEventListener(Event.ENTER_FRAME, eFrame);
		}

		public function removeLife(){
			trace("enemy destroyed");
			if(numwalks >= numtodelete){
				tfe.text = "All enemies have exited the map";
				tfe.setTextFormat(statsTf);	
				enemies = true;
			}
			if(reds && enemies){
				trace("MAP OK");
				gameOver = true;
			}
		}
		
		private function retClick(e:MouseEvent){
			trace("MAP NOK");
			gameOver = true;
			removeEventListener(Event.ENTER_FRAME, eFrame);
			destroyThis();
			editor.returnTest(false);
		}
		
		var cen:EnemyBlue,
			fb:FinishBlock,
			j:uint,
			numwalks:uint,
			numtowalk:uint = 0;
		function eFrame(e:Event):void{
			if(reds && enemies){
				removeEventListener(Event.ENTER_FRAME, eFrame);
				destroyThis();
				editor.returnTest(true);
				return;
			}
			makeEnemies();
			for(i = 0; i<enemyHolder.numChildren; i++){
				cen = enemyHolder.getChildAt(i) as EnemyBlue;
				
				for(j = 0; j<numChildren; j++){
					if (cen.hitTestObject(getChildAt(j))){
						if(getChildAt(j) is EmptyBlock){
							cen.maxSpeed = 0;
						}						
					}
					
				}
				
				for(j = 0; j<roadHolder.numChildren; j++){
					if (cen.hitTestObject(roadHolder.getChildAt(j))){
						if(roadHolder.getChildAt(j) is FinishBlock){
							fb = roadHolder.getChildAt(j) as FinishBlock;
							if(fb.www.indexOf(cen) < 0){
								fb.www.push(cen);
								trace((roadHolder.getChildAt(j) as FinishBlock).www.length);						
							}
						}						
					}					
				}				
			}
			
			numwalks = 0;
			for(j = 0; j<roadHolder.numChildren; j++){
				if(roadHolder.getChildAt(j) is FinishBlock){
					fb = roadHolder.getChildAt(j) as FinishBlock;
					numwalks += fb.www.length;					
				}						
			}
			if(numwalks >= numtowalk) {
				tf.text = "All finish lines (red) have been reached."
				reds = true;
			}
			tf.setTextFormat(statsTf);	
			
		}
		
		
		 
		var type:uint;
		var _newEnemy:Enemy;
		function makeEnemies():void{
			if(waveCreated[level] >= waveLength[level]){
				return;
			}
			for(i=0; i<startCoord.length; i++){
				_newEnemy = new EnemyBlue(this, type, i, level);
				enemyHolder.addChild(_newEnemy);
				_newEnemy = null;
			}
			waveCreated[level]++;
			
		}

		function makeRoad():void{
			var row:int = 0;
			var block;
			var c:int;
			var m:Matrix = new Matrix();
			for(i=0;i<lvlArray.length-1;i++){
				if(lvlArray[i] == 1){
					block = new Shape();
					block.graphics.beginFill(0);
					block.graphics.drawRect(0,0,25,25);
					block.graphics.endFill();
					block.x = (i-row*22)*25;
					block.y = row*25;
					roadHolder.addChild(block);//add it to the roadHolder
				} else if(lvlArray[i] == S){
					block = new Shape();
					if(row == 0) {
						m.createGradientBox(25,25,Math.PI/2,0,0);					
					}else if(row == 15){
						m.createGradientBox(25,25,3*Math.PI/2,0,0);
					}else if(i%22 == 0){
						m.createGradientBox(25,25,0,0,0);
					}else if(i%22 == 21){
						m.createGradientBox(25,25,Math.PI,0,0);
					}
					block.graphics.beginGradientFill(GradientType.LINEAR, [0x00c000, 0x000000], [1,1], [0,180], m);
					block.graphics.drawRect(0,0,25,25);
					block.graphics.endFill();
					block.x = (i-row*22)*25;
					block.y = row*25;
					roadHolder.addChild(block);
					numtodelete++;
					if(block.x == 0){
						startDir.push(R);
						startCoord.push(block.y);
					} else if (block.y == 0){
						startDir.push(D);
						startCoord.push(block.x);
					} else if (block.x == 525){
						startDir.push(L);
						startCoord.push(block.y);
					} else if (block.y == 375){
						startDir.push(U);
						startCoord.push(block.x);
					} else {					
						trace("DirectBlock.beginClass(...) START else");
					}
				}
				else if(lvlArray[i] == F){
					block = new FinishBlock(this);
					if(row == 0) {
						m.createGradientBox(25,25,Math.PI/2,0,0);					
					}else if(row == 15){
						m.createGradientBox(25,25,3*Math.PI/2,0,0);
					}else if(i%22 == 0){
						m.createGradientBox(25,25,0,0,0);
					}else if(i%22 == 21){
						m.createGradientBox(25,25,Math.PI,0,0);
					}
					block.graphics.beginGradientFill(GradientType.LINEAR, [0xc00000, 0x000000], [1,1], [0,180], m);
					//beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0)
					block.graphics.drawRect(0,0,25,25);
					block.graphics.endFill();
					block.x = (i-row*22)*25;
					block.y = row*25;
					roadHolder.addChild(block);//add it to the roadHolder
					numtowalk++;
				}				
				else if(lvlArray[i] >= 0x100){
					block = new DirectBlock(this,lvlArray[i],(i-row*22)*25,row*25);
					addChild(block);
				}
				else if(lvlArray[i] != 0)
					trace("Error. lvlArray"+i+"="+lvlArray[i]);
					
				block = null;
				
				for(c = 1;c<=16;c++){
					if(i == c*22-1){
						row++;
					}
				}
				
			}
			row=0;
			for(i=0;i<lvlArray.length-1;i++){
				if(lvlArray[i] == 0){		
					block = new EmptyBlock(this);
					addChild(block);
					block.x= (i-row*22)*25;
					block.y = row*25;
				}
				for(c = 1;c<=16;c++){
					if(i == c*22-1){
						row++;
					}
				}
			}
			block = null;
		}
	
		private function destroyThis(){
			removeEventListener(Event.ENTER_FRAME, eFrame);
			//removeChild(roadHolder);
			//removeChild(enemyHolder);
			roadHolder = null;
			enemyHolder = null;
			xml = null;
			att = null;
			startDir = []; startDir = null;
			finDir = []; finDir = null;
			startCoord = []; startCoord = null;
			lvlArray = []; lvlArray = null;
			waveLength = null;
			waveCreated = null;
			waveType = null;
			hpEnemy = null;
			mnEnemy = null;
			stage.removeChild(this);
		}
		
		public function makeTurret(xx:uint, yy:uint){
			
		}
		private function initStatField(t:TextField, xx:uint, yy:uint){
			t.x = xx;
			t.y = yy;
			t.selectable = false;
			t.autoSize = TextFieldAutoSize.LEFT;
			addChild(t);				
		}
	}
	
}
