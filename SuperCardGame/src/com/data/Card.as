package com.data
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public final class Card extends Sprite
	{
		public var id			:int;
		public var background	:Shape;
		public var imgContainer	:Sprite;
		public var textContainer:Sprite;
		public var text			:Vector.<Sprite>;
		public var paramsValue	:Vector.<String>;
		public var paramsNames	:Vector.<String>;
		
		public function Card(data:XML, paramsNum:int, paramNames:Vector.<String>)
		{
			paramsValue = new Vector.<String>();
			paramsNames = paramNames;
			id 			= data.@id;
			for (var i:int = 1; i <= paramsNum; i++) 
			{
				paramsValue.push(data.@["params"+i]);
			}
			imgContainer  = new Sprite();
			textContainer = new Sprite();
			createbg();
			startTextFields();
			this.addChild(textContainer);
			this.addChild(imgContainer);
		}
		
		private function createbg():void
		{
			background = new Shape();
			background.graphics.beginFill(0xFF794B);
			background.graphics.drawRect(0, 0, 200, 250);
			background.graphics.endFill();
			this.addChild(background);
		}
		
		private function startTextFields():void
		{
			text = new Vector.<Sprite>();
			for (var i:int = 0; i < paramsValue; i++) 
			{
				var txtContainer	:Sprite = new Sprite();
				var paramName		:TextField = new TextField();
				var paramValue		:TextField = new TextField();
				paramName.textColor  = 0xFF0000;
				paramName.border  = true;
				paramValue.textColor = 0xFF0000;
				paramValue.border = true;
				paramName.width   = 90;
				paramName.height  = 30;
				paramValue.width  = 90;
				paramValue.height = 30;
				paramValue.x = paramName.x + paramName.width + 10;
				paramName.y  = 10 * -i;
				paramValue.y = paramName.y;
				paramName.text = paramsNames[i];
				paramValue.text = paramsValue[i];
				txtContainer.addChild(paramName);
				txtContainer.addChild(paramValue);
				txtContainer.mouseChildren 	= false;
				txtContainer.buttonMode 	= true;
				txtContainer.addEventListener(MouseEvent.CLICK, onTxtSelected);
				textContainer.addChild(txtContainer);
				text.push(txtContainer);
			}
		}
		
		protected function onTxtSelected(event:MouseEvent):void
		{
			trace("Card.onTxtSelected(event)");
		}
		
		public function onImgLoaded(e:Event):void
		{
			imgContainer.addChild(e.currentTarget.content as Bitmap);
		}
		public function onIOError(e:IOErrorEvent):void
		{
			trace("Card.onIOError(e) " + id);
		}
	}
}