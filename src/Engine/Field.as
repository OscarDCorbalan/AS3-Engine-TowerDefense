﻿package src.Engine {
	
	public class Field {
		private const cc:uint = 22;
		private const rr:uint = 16;
		static const S:uint = 0x010;//"START";
		static const F:uint = 0x011;//"FINISH";
		static const U:uint = 0x100;//"UP";
		static const R:uint = 0x101;//"RIGHT";
		static const D:uint = 0x110;//"DOWN";
		static const L:uint = 0x111;//"LEFT";
		
		public function Field() {
		}

		static public function getmap(_n:uint):Array{
			switch(_n){
				case 1: return getmap1();
				case 2: return getmap2();
				case 3: return getmap3();
				case 4: return getmap4();
				case 5: return getmap5();
				case 6: return getmap6();
				default:
					trace("getmap Error. Parameter out of range");
					return null;
			}
		}
		
		
		
		static private function getmap15():Array{
			return [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,R,1,1,1,D,D,1,1,1,L,0,0,0,0,0,0,
					S,D,0,0,0,0,1,0,0,0,1,1,0,0,0,1,0,0,0,0,D,S,
					0,1,0,0,0,0,1,0,0,0,1,1,0,0,0,1,0,0,0,0,1,0,
					0,1,0,0,0,0,1,0,0,0,1,1,0,0,0,1,0,0,0,0,1,0,
					S,R,D,0,0,0,1,0,0,0,1,1,0,0,0,1,0,0,0,D,L,S,
					0,0,1,0,0,0,1,0,0,0,1,1,0,0,0,1,0,0,0,1,0,0,
					0,0,1,0,0,0,1,0,0,0,1,1,0,0,0,1,0,0,0,1,0,0,
					S,1,R,D,0,0,1,0,0,0,1,1,0,0,0,1,0,0,D,L,1,S,
					0,0,0,1,0,0,1,0,0,0,1,1,0,0,0,1,0,0,1,0,0,0,
					0,0,0,1,0,0,1,0,0,0,1,1,0,0,0,1,0,0,1,0,0,0,
					S,1,1,R,D,0,1,0,0,0,1,1,0,0,0,1,0,D,L,1,1,S,
					0,0,0,0,1,0,1,0,0,0,1,1,0,0,0,1,0,1,0,0,0,0,
					0,0,0,0,1,0,1,0,0,0,1,1,0,0,0,1,0,1,0,0,0,0,
					S,1,1,1,R,1,U,0,0,0,1,1,0,0,0,U,1,L,1,1,1,S,					
					0,0,0,0,0,0,0,0,0,0,F,F,0,0,0,0,0,0,0,0,0,0,
					4];
		}
		
		
		
		
		static private function getmap5():Array{
			return [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,R,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,F,
					0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,R,1,1,1,F,
					0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,
					0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,
					0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,
					0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,
					0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,
					0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,
					0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,
					0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,
					S,1,1,1,1,U,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,
					S,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,U,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					10];
		}
		
		static private function getmap7():Array{
			return [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					S,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,D,0,0,
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,
					0,0,R,1,1,1,1,1,1,1,1,1,1,1,1,1,D,0,0,1,0,0,
					0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,
					0,0,1,0,0,R,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,F,
					0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,
					0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,
					F,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,L,0,0,1,0,0,
					0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,
					0,0,1,0,0,U,1,1,1,1,1,1,1,1,1,1,1,1,1,L,0,0,
					0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,U,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,S,							
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					10];
		}
	
		
		static private function getmap1():Array{
			return [0,0,0,0,0,F,F,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,1,1,0,0,0,0,D,1,1,1,1,1,1,L,0,0,0,
					0,0,0,0,0,1,1,0,0,0,0,1,D,1,1,1,1,L,1,0,0,0,
					0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,
					0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,
					0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,
					0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,
					S,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,U,1,0,0,0,
					S,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,U,0,0,0,
					0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,1,U,1,1,1,1,L,1,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,U,1,1,1,1,1,1,L,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					10];
		}
		
		static private function getmap2():Array{
			return [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,F,0,0,0,0,
					0,0,0,0,D,1,1,1,1,1,1,1,1,1,L,0,0,1,0,0,0,0,
					0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,
					0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,
					0,0,0,0,1,0,0,D,1,1,1,L,0,0,1,0,0,1,0,0,0,0,
					0,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,1,0,0,0,0,
					0,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,1,0,0,0,0,
					0,0,0,0,1,0,0,1,0,0,D,1,1,1,1,1,1,1,1,1,1,S,
					S,1,1,1,1,1,1,1,1,1,1,U,0,0,1,0,0,1,0,0,0,0,
					0,0,0,0,1,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,0,
					0,0,0,0,1,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,0,
					0,0,0,0,1,0,0,1,0,0,R,1,1,1,U,0,0,1,0,0,0,0,
					0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,
					0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,
					0,0,0,0,1,0,0,R,1,1,1,1,1,1,1,1,1,U,0,0,0,0,
					0,0,0,0,F,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					10];
		}
		
		
		
		static private function getmap3():Array{
			return [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,R,1,1,1,1,1,1,1,D,0,0,0,0,0,0,
					0,0,0,0,0,0,R,1,1,1,1,1,1,1,1,1,D,0,0,0,0,0,
					0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,
					0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,
					S,1,1,1,1,1,1,U,0,0,0,0,0,0,0,1,1,0,0,0,0,0,
					S,1,1,1,1,1,U,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,0,D,1,1,1,L,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,D,1,1,1,L,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,F,F,0,0,0,0,0,0,0,0,0,
					10];
		}
		
		static private function getmap4():Array{
			return [0,0,0,0,0,0,0,0,0,0,0,0,0,0,F,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,0,R,1,U,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,R,1,1,1,U,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,R,1,1,1,U,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,R,1,1,1,U,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,R,1,1,1,U,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,R,1,1,1,U,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					S,1,1,1,U,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,S,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					10];
		}
		static private function getmap6():Array{
			return [0,0,0,0,S,0,0,0,0,0,0,0,0,0,0,0,0,S,0,0,0,0,
					0,0,0,0,R,1,D,0,0,0,0,0,0,0,0,D,1,L,0,0,0,0,
					0,0,0,0,0,0,R,1,D,0,0,0,0,D,1,L,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,R,1,D,D,1,L,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,				
					0,0,0,0,0,0,0,0,0,0,F,F,0,0,0,0,0,0,0,0,0,0,
					10];
		}
	}
	
}
