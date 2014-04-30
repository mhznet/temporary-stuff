package com.data
{
	import flash.display.BitmapData;
	import flash.events.Event;

	public class BMP
	{
		public var id:int;
		public var bmp:BitmapData;
		public var ready:Boolean = false;
		private var check:Function;
		public function BMP(id:int, verify:Function)
		{
			this.id = id;
			check = verify;
		}
		public function onBMPLoaded(e:Event):void
		{
			bmp = e.currentTarget.content.bitmapData;
			ready = true;
			check();
		}
	}
}