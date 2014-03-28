package com.data
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class Utility
	{
		public static var instance:Utility;
		public static var ready:Boolean = false;
		public function Utility()
		{
			if (ready)
			{
				throw new Error("Utility não pode ter mais de uma instancia!");
			}
		}
		public static function getInstance():Utility
		{
			if (!instance)
			{
				instance = new Utility();
				ready = true;
			}
			return instance;
		}
		
		public function getIfAlreadyAddedInVector(cardid:int, vec:Vector.<Card>):Boolean
		{
			var alrdyAdded:Boolean = false;
			for (var i:int = 0; i < vec.length; i++) 
			{
				if (cardid == vec[i].id)
				{
					alrdyAdded = true;
					break;
				}
			}
			return alrdyAdded;
		}
		public function getIndex(cardid:int, vec:Vector.<Card>):int
		{
			var index:int;
			for (var i:int = 0; i < vec.length; i++) 
			{
				if (cardid == vec[i].id)
				{
					index = i;
					break;
				}
			}
			return index;
		}
		public function bringForward(cont:DisplayObjectContainer, spr:DisplayObject):void
		{
			if (cont.contains(spr))
			{
				cont.setChildIndex(spr, cont.numChildren-1);
			}
		}
	}
}