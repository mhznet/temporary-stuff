package com.display.utils
{
	import com.display.screens.ModeSelectionScreen;
	import com.greensock.TweenLite;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class TurnSlider extends Sprite
	{
		private var m_main		:ModeSelectionScreen;
		private var text		:GenericBt;
		private var over		:GenericBt;
		private var selected	:GenericBt;
		private var normal		:GenericBt;
		
		private var sprCont		:Sprite;
		private var vec			:Vector.<Sprite>;
		private var selectedId	:int = 2;
		public function TurnSlider(main:ModeSelectionScreen)
		{
			m_main = main;
			vec = new Vector.<Sprite>();
			makeImgs();
			makeText();
			makeIt();
		}
		
		private function makeImgs():void
		{
			normal = new GenericBt(null,"",167,34,m_main.display.main.data.getBMPById(21),false);
			over = new GenericBt(null,"",167,34,m_main.display.main.data.getBMPById(22),false);
			selected = new GenericBt(null,"",167,34,m_main.display.main.data.getBMPById(20),false);
			selected.visible = false;
			over.visible = false;
			this.addChild(normal);
			this.addChild(over);
			this.addChild(selected);
		}
		
		private function makeText():void
		{
			text = new GenericBt(null,"",98,38,m_main.display.main.data.getBMPById(19),false);
			text.x = 30;
			text.y = -50;
			this.addChild(text);			
		}
		private function makeIt():void
		{
			sprCont = new Sprite();
			for (var i:int = 0; i < 5; i++) 
			{
				var sprite:Sprite = new Sprite();
				var shape:Shape = new Shape();
				shape.graphics.beginFill(0xFFFFFF, 1);

				var x:Number;
				var y:int = 0;
				var width:int = 30;
				var height:int = 36;
				switch(i)
				{
					case 3:
						x = (i * 35) - 12;
						width = 35;
						break;
					case 4:
						x = (i * 34.5) - 5;
						width = 35;
						break;
					default:
						x = (i * 34.5) - 10
						break;
				}
				shape.graphics.drawRect(x, y, width,height);
				shape.alpha = 0;
				shape.graphics.endFill();
				sprite.addChild(shape);
				sprite.buttonMode = true;
				vec.push(sprite);
				sprCont.addChild(sprite);
			}
			this.addChild(sprCont);
		}
		
		public function getTurnNumber():int
		{
			var turns:int;
			switch(selectedId)
			{
				case 0: //1
					turns = 5;
					//turns = 1;
					break;
				case 1: //4
					turns = 10;
					break;
				case 2: //6
					turns = 15;
					break;
				case 3: //9
					turns = 20;
					break;
				case 4: //12
					turns = 35;
					break;
			}
			return turns;
		}
		
		protected function select(event:MouseEvent):void
		{
			for (var i:int = 0; i < vec.length; i++) 
			{
				if (vec[i] == event.currentTarget)
				{
					selectedId = i;
					selected.visible = true;
					over.visible = false;
					selected.mask = vec[i];
				}
			}
		}
		protected function overNOut(event:Event):void
		{
			if (event.type == MouseEvent.ROLL_OUT)
			{
				normal.visible = true;
				over.visible = false;
			}
			else if (event.type == MouseEvent.ROLL_OVER)
			{
				for (var i:int = 0; i < vec.length; i++) 
				{
					if (event.currentTarget == vec[i])
					{
						if (i!=selectedId)
						{
							over.mask = vec[i];
							over.visible = true;
						}
						else
						{
							over.mask = null;
							over.visible = false;
						}
					}
				}
			}
		}
		public function hide():void
		{
			this.alpha = 0;
		}
		public function show():void
		{
			TweenLite.to(this, 1.5,{alpha:1, onComplete:showSelected});
		}
		private function showSelected():void
		{
			for (var i:int = 0; i < vec.length; i++) 
			{
				vec[i].addEventListener(MouseEvent.ROLL_OUT, overNOut);
				vec[i].addEventListener(MouseEvent.ROLL_OVER, overNOut);
				vec[i].addEventListener(MouseEvent.CLICK, select);
			}
			vec[selectedId].dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
			vec[selectedId].dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
			vec[selectedId].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
	}
}