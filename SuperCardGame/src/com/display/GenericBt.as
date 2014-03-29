package com.display
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class GenericBt extends Sprite
	{
		private var text:TextField;
		private var bg	:Shape;
		private var onClick:Function;
		
		public function GenericBt(name:String,click:Function)
		{
			addBg();
			text = new TextField();
			text.text = name;
			onClick = click;
			this.addChild(text);
			this.mouseChildren = false;
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, onClick);
			super();
		}
		
		private function addBg():void
		{
			bg = new Shape();
			bg.graphics.beginFill(0xFFFFFF);
			bg.graphics.drawRect(0, 0, 100, 50);
			bg.graphics.endFill();
			this.addChild(bg);
		}
	}
}