package com.data
{
	import com.Main;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class MainData
	{
		public var main 	:Main;
		public var version	:String = "?v=1";
		public var album	:Album;
		public var teams	:Teams;
		public function MainData(maine:Main)
		{
			main = maine;
			loadXML();
		}
		public function loadXML():void
		{
			var loader:URLLoader = new URLLoader();
			var req:URLRequest = new URLRequest("../assets/fullalbum.xml"+version);
			loader.addEventListener(Event.COMPLETE, onXMLLoaded);
			loader.load(req);
		}
		protected function onXMLLoaded(event:Event):void
		{
			var xml:XML = new XML(event.target.data)
			album = new Album(xml);
			teams = new Teams(xml,this);
			main.albumReady();
		}
	}
}