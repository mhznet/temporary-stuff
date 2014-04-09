package com.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class GenericBt extends Sprite
	{
		public var text:TextField;
		public var bmp	:Bitmap;
		public var bg	:Shape;
		public var u_bg:Shape;
		public var onClick:Function;
		private var original	:Array;
		public function GenericBt(click:Function=null, name:String="", width:Number = 100, height:Number = 50,bmpdata:BitmapData = null,overNout:Boolean=true)
		{
			addBg();
			if (bmpdata) addBMP(bmpdata);
			if (name!="")addText(name);
			this.width = width;
			this.height = height;
			if (click)
			{
				onClick = click;
				this.buttonMode = true;
				this.addEventListener(MouseEvent.CLICK, onClicked);
				if (overNout)
				{
					this.addEventListener(MouseEvent.ROLL_OVER, onOverEtOut);
					this.addEventListener(MouseEvent.ROLL_OUT, onOverEtOut);
				}
			}
			this.mouseChildren = false;
			super();
		}
		
		private function onClicked(event:MouseEvent):void
		{
			onClick(event);
		}
		
		protected function onOverEtOut(event:MouseEvent):void
		{
			if (event.type == MouseEvent.ROLL_OVER)
			{
				if (original==null) original = bmp.filters;
				//var glow:GlowFilter = new GlowFilter(0xf1c018);
				var glow:GlowFilter = new GlowFilter(0x000000);
				bmp.filters = [glow];
			}
			else if (event.type == MouseEvent.ROLL_OUT)
			{
				bmp.filters = original;
			}
		}
		
		private function addText(str:String):void
		{
			var format:TextFormat = new TextFormat();
			format.size = 25;
			format.align = TextFormatAlign.LEFT;
			format.bold = true;
			format.color = 0xFFFFFFF;
			text = new TextField();
			text.text = str;
			text.width = 100;
			text.height = 50;
			text.setTextFormat(format);
			this.addChild(text);
		}
		
		private function addBMP(bmpdata:BitmapData):void
		{
			bmp = new Bitmap();
			bmp.bitmapData = bmpdata.clone();
			this.addChild(bmp);
		}
		
		private function addBg():void
		{
			bg = new Shape();
			bg.graphics.beginFill(0xFFFFFF);
			bg.graphics.drawRect(0, 0, width, height);
			bg.graphics.endFill();
			this.addChild(bg);
		}
	}
}