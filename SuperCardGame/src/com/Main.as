package com
{
	import com.data.Data;
	import com.display.Display;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	[SWF(width="950",height="705",frameRate="24",backgroundColor="#BBBBBB")]
	public class Main extends Sprite
	{
		public var data		:Data;
		public var display	:Display;
		public var version	:String = "?=v1.1";
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			display = new Display(this);
			this.addChild(display);
			loadXML();
		}
		public function loadXML():void
		{
			var loader:URLLoader = new URLLoader();
			var req:URLRequest = new URLRequest("../src/assets/fullalbum.xml"+version);
			loader.addEventListener(Event.COMPLETE, onXMLLoaded);
			loader.load(req);
		}
		protected function onXMLLoaded(event:Event):void
		{
			var xml:XML = new XML(event.target.data)
			data = new Data(this,xml.config, xml.card, xml.asset);
		}
		
		public function onDataReady():void
		{
			display.goTitle();
		}
	}
}