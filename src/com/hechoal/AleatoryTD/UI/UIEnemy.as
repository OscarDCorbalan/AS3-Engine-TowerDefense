package com.hechoal.AleatoryTD.UI  {
	import com.hechoal.AleatoryTD.Engine;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	
	public class UIEnemy extends MovieClip{
		static const _boss:uint = 0;
		static const _red:uint = 1;
		static const _green:uint = 2;
		static const _blue:uint = 3;
		static const _yellow:uint = 4;
		static const _magenta:uint = 5;
		static const _cyan:uint = 6;		
		static const _gray:uint = 7;
		
		private var engine:Engine;
		private var ui:UIBox;
		
		protected var active:Boolean = false;
		
		protected var type:uint;
		protected var health:uint;
		protected var money:uint;
		
		protected var txt:TextField = new TextField();
		protected var tf:TextFormat = new TextFormat();
		
		protected var flashme = false;
		protected var flashcount = 0;
		protected var graph:Clicktosend;
		public function UIEnemy(e:Engine, u:UIBox, t:uint, level:uint, _f:Boolean = false){
			engine =e ;
			ui = u;
			alpha = 0.3;
			
			//trace(xml);
			health = engine.hpEnemy[level];
			type = t;
			money = engine.mnEnemy[level];
			tf.font = "Arial";
			tf.size = 10;
			tf.color = 0xEEEEEE;	
			tf.leading = 0.5;
			
			
			txt.x = 25;
			txt.y = 15;
			txt.selectable = false;
			txt.autoSize = TextFieldAutoSize.LEFT;
			addEventListener(Event.ADDED, beginClass);
			if(_f){
				graph  = new Clicktosend();
				graph.y = 12;
				flashme = true;
				activate();
			}
		}
		
		private function clickme(e:Event){
			flashcount++;
			if(flashcount == 18){
				addChild(graph);
			}
			else if(flashcount >=36){
				flashcount = 0;
				removeChild(graph);
			}
		}
		
		private function beginClass(e:Event):void{
			removeEventListener(Event.ADDED, beginClass);
			graphics.beginFill(1, 0);
			graphics.drawRect(2,14,95,30);
			graphics.endFill();
			txt.text = health +"hp\n$" + money;			
			var _gr:Sprite;
			switch(type){
				case _boss:
					/*graphics.lineStyle(1,0xBBBBBB);
					graphics.beginFill(0x333333);
					graphics.drawCircle(15,30,6);
					graphics.endFill();*/
					_gr = new BossMain();
					_gr.x = 0;
					_gr.y = 24;		
					txt.text = "Boss\n"+ health*15 +"hp\n$" + money*20;
					break;
				case _gray:
					_gr = new GrayMain();
					_gr.x = 7;
					_gr.y = 32;
					/*
					graphics.lineStyle(1,0xBBBBBB);
					graphics.beginFill(0x333333);
					graphics.drawCircle(15,36,6);
					graphics.endFill();*/
					txt.text = "Gray drops\n"+ health +"hp\n$" + money;
					break;
				case _red:			
					_gr = new RedMain();
					_gr.x = 0;
					_gr.y = 24;
					/*
					graphics.lineStyle(1,0xFF0000);
					graphics.moveTo(8,36);
					graphics.lineTo(15,29);
					graphics.lineTo(22,36);
					graphics.lineTo(15,43);
					graphics.lineTo(8,36);*/
					txt.text = "Red diamonds\n"+((uint)(health*1.3)) +"hp\n$" + money;
					break;
				case _green:
					_gr = new GreenMain();
					_gr.x = 0;
					_gr.y = 24;
					/*
					graphics.lineStyle(1,0x00FF00);
					graphics.drawRect(9,27,12,12);*/
					txt.text = "Green pashers\n"+ health +"hp\n$" + money;
					break;	
				case _blue:					
					_gr = new BlueMain();
					_gr.x = 0;
					_gr.y = 24;
					/*
					graphics.lineStyle(2,0x0000FF);
					graphics.moveTo(10,25);					
					graphics.lineTo(16.75, 29.5);
					graphics.lineTo(10,24);					
					graphics.moveTo(14.25,25);	
					graphics.lineTo(21, 29.5);			
					graphics.lineTo(14.25,34);*/
					txt.text = "Blue runners\n"+ ((uint)(health*0.75)) +"hp\n$" + money;
					break;
				case _yellow:
					_gr = new YellowMain();
					_gr.x = 0;
					_gr.y = 24;/*
					graphics.lineStyle(1,0xFFFF00);
					graphics.drawRect(9,30,11,11);
					graphics.drawCircle(15,35.5,5.5);*/
					txt.text = "Yellow nuts\n"+health +"hp\n$" + money;
					break;					
				case _magenta:
					_gr = new MagentaMain();
					_gr.x = 0;
					_gr.y = 24;/*
					graphics.lineStyle(1,0xFF00FF);
					graphics.moveTo(15, 33);					
					graphics.lineTo(9.5, 41.5);
					graphics.lineTo(20.5, 41.5);
					graphics.lineTo(15, 32);
					graphics.beginFill(0x000000);
					graphics.drawCircle(15,32,2.5);
					graphics.drawCircle(9.5, 41.5,2.5);
					graphics.drawCircle(20.5,41.5,2.5);
					graphics.endFill();*/
					txt.text = "Magenta atoms\n"+health +"hp\n$" + money;
					break;
				case _cyan:
					_gr = new CyanMain();
					_gr.x = 0;
					_gr.y = 24;/*
					graphics.lineStyle(1,0x00FFFF);
					graphics.beginFill(0xFF00, 0.3);
					graphics.moveTo(8,30);						
					graphics.lineTo(14,36);
					graphics.lineTo(8,42);
					graphics.lineTo(8,30);
					graphics.endFill();
					graphics.beginFill(0xFF, 0.3);
					graphics.moveTo(19,31);						
					graphics.lineTo(14,36);
					graphics.lineTo(19,41);
					graphics.lineTo(19,31);
					graphics.endFill();
					
					graphics.drawRect(8,30,11,11);
					graphics.moveTo(6,28);						
					graphics.lineTo(8,30);
					graphics.moveTo(22,28);						
					graphics.lineTo(20,30);
					graphics.moveTo(6,44);						
					graphics.lineTo(8,42);
					graphics.moveTo(22,44);						
					graphics.lineTo(20,42);*/
					txt.text = "Cyan comets\n"+health +"hp\n$" + money;
					break;
				default: return;
				
			}
					
			addChild(_gr);
			txt.setTextFormat(tf);
			addChild(txt)
			if(flashme) addEventListener(Event.ENTER_FRAME, clickme,false,0,true);
		}
		
		public function activate(){
			alpha = 1;
			
			addEventListener(MouseEvent.MOUSE_UP, clickWave);
			buttonMode = true;
			mouseChildren = false;
			//addEventListener(Event.ENTER_FRAME, eFrame);
			active = true;
		}
		
		public function activated():Boolean{
			return active;
		}
		
		
		private function clickWave(e:MouseEvent){			
			removeEventListener(MouseEvent.MOUSE_UP, clickWave);
			removeEventListener(Event.ENTER_FRAME, clickme);
			//removeEventListener(Event.ENTER_FRAME, eFrame);
			ui.sendNextWave();
			engine = null;
			ui = null;
			txt = null;
			tf = null;
			if(graph != null && contains(graph)){
				removeChild(graph);
				graph = null;
			}
		}
	}
	
}
