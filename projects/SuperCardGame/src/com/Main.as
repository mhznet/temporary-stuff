package com
{
	import com.data.Data;
	import com.display.Display;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.Font;

	[SWF(width="940",height="600",frameRate="24",backgroundColor="#BBBBBB")]
	public class Main extends Sprite implements IMain
	{
		public var data		:Data;
		public var display	:Display;
		public var isLocal	:Boolean = true;
		public var version	:String = "?=v1.113";
		public var mayShow	:Function;
		public var font		:Font;
		public function Main()
		{
			//addEventListener(Event.ADDED_TO_STAGE, onAdded);
			onAdded();
		}
		public function setCompleteFunction(func:Function):void
		{
			mayShow = func;
		}
		protected function onAdded(event:Event=null):void
		{
			//removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			display = new Display(this);
			this.addChild(display);
			loadXML();
		}
		public function loadXML():void
		{
			trace ("Main - I'm Loading XML's");
			var loader:URLLoader = new URLLoader();
			var url	  :String;
			if (!isLocal)
			{
				url = "http://media.mundodositio.globo.com.s3.amazonaws.com/face/matamata/assets/fullalbum.xml"+version; 
			}
			else
			{
				url = "../src/assets/fullalbumlocal.xml"+version;
			}
			var req:URLRequest = new URLRequest(url);
			loader.addEventListener(Event.COMPLETE, onXMLLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onXMLIOError);
			loader.load(req);
		}
		
		protected function onXMLIOError(event:IOErrorEvent):void
		{
			trace ("IOERROR Carregando XML", event.errorID, event.text);
		}
		protected function onXMLLoaded(event:Event):void
		{
			var xml:XML = new XML(event.target.data)
			data = new Data(this,xml.config, xml.card, xml.asset, xml.bmp);
		}
		
		public function onDataReady():void
		{
			if (mayShow!=null) mayShow();
			display.goTitle();
		}
	}
}