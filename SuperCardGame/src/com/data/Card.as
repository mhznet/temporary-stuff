package com.data
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;

	public final class Card
	{
		public var id			:int;
		public var imgContainer	:Sprite;
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
		}
		public function onImgLoaded(e:Event):void
		{
			imgContainer.addChild(e.currentTarget.content as Bitmap);
		}
		public function checkResult(index:int, value:int):int
		{
			var toReturn:int;
			if (value > int(paramsValue[index])) toReturn = -1;
			if (value == int(paramsValue[index])) toReturn = 0
			if (value < int(paramsValue[index])) toReturn = 1
			return toReturn;
		}
	}
}