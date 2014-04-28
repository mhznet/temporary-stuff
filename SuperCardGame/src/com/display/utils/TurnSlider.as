package com.display.utils
{
	import com.display.screens.ModeSelectionScreen;
	import com.greensock.TweenLite;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;

	public class TurnSlider extends Sprite
	{
		private var text		:GenericBt;
		private var vec			:Vector.<Sprite>;
		private var shadowVec	:Vector.<Shape>;
		private var selectedId	:int = 2;
		private var original	:Array;
		public function TurnSlider(main:ModeSelectionScreen)
		{
			vec = new Vector.<Sprite>();
			shadowVec = new Vector.<Shape>();
			makeIt();
			text = new GenericBt(null,"",163,67,main.display.main.data.getBMPById(19),false);
			text.x = -20;
			text.y = 60;
			this.addChild(text);
		}
		private function makeIt():void
		{
			var back:Shape = new Shape();
			back.graphics.beginFill(0xFFFFFF, 1);
			back.graphics.drawRect(0, 20, 120, 10);
			back.graphics.endFill();
			var backShadow:Shape = new Shape();
			backShadow.graphics.beginFill(0x99CC33, 1);
			backShadow.graphics.drawRect(-1, 19, 120, 10);
			backShadow.graphics.endFill();
			this.addChild(backShadow);
			this.addChild(back);
			
			for (var i:int = 0; i < 5; i++) 
			{
				var sprite:Sprite = new Sprite();
				var shape:Shape = new Shape();
				var shapeShadow:Shape = new Shape();
				var selectShadow:Shape = new Shape();
				shapeShadow.graphics.beginFill(0x99CC33, 1);
				selectShadow.graphics.beginFill(0x000000, 1);
				shape.graphics.beginFill(0xFFFFFF, 1);
				if (i==0 || i ==4)
				{
					shape.graphics.drawRect(i * 30, 0, 10, 50);
					shapeShadow.graphics.drawRect((i * 30)-1, -1, 10, 50);
					selectShadow.graphics.drawRect((i * 30)-1, -1, 12, 52);
				}
				else
				{
					shape.graphics.drawRect(i * 30, 10, 10, 30);
					shapeShadow.graphics.drawRect((i * 30)-1, 9, 10, 30);
					selectShadow.graphics.drawRect((i * 30)-1, 9, 12, 32);
				}
				shape.graphics.endFill();
				shapeShadow.graphics.endFill();
				selectShadow.graphics.endFill();
				selectShadow.alpha = 0;
				sprite.addChild(shapeShadow);
				sprite.addChild(selectShadow);
				sprite.addChild(shape);
				sprite.addEventListener(MouseEvent.ROLL_OUT, overNOut);
				sprite.addEventListener(MouseEvent.ROLL_OVER, overNOut);
				sprite.addEventListener(MouseEvent.CLICK, select);
				sprite.buttonMode = true;
				shadowVec.push(selectShadow);
				vec.push(sprite);
				this.addChild(sprite);
			}
		}
		
		public function getTurnNumber():int
		{
			var turns:int;
			switch(selectedId)
			{
				case 0: //1
					//turns = 7;
					turns = 1;
					break;
				case 1: //4
					turns = 28;
					break;
				case 2: //6
					turns = 42;
					break;
				case 3: //9
					turns = 63;
					break;
				case 4: //12
					turns = 84;
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
					shadowVec[i].alpha = 1;
				}
				else
				{
					shadowVec[i].alpha = 0;
				}
			}
		}
		protected function overNOut(event:Event):void
		{
			if (event.type == MouseEvent.ROLL_OUT)
			{
				event.currentTarget.filters = original;
			}
			else if (event.type == MouseEvent.ROLL_OVER)
			{
				if (original==null) original = event.currentTarget.filters;
				var glow:GlowFilter = new GlowFilter(0x000000,0.3,9.0,9.0,1);
				event.currentTarget.filters = [glow];
			}
		}
		public function hide():void
		{
			shadowVec[selectedId].alpha = 0;
			this.alpha = 0;
		}
		public function show():void
		{
			TweenLite.to(this, 1.5,{alpha:1, onComplete:showSelected});
		}
		private function showSelected():void
		{
			shadowVec[selectedId].alpha = 1;
		}
	}
}