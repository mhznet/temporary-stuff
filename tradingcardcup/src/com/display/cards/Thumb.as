package com.display.cards
{
	import com.data.Utility;
	import com.greensock.events.LoaderEvent;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	public class Thumb extends Sprite
	{
		public var imgContainer	:Sprite;
		public var asset		:CardHolder;
		public var idtxt		:TextField;
		public var nametxt		:TextField;
		public var tenhotxt		:TextField;
		public var equippedtxt	:TextField;
		public var imgurl		:String;
		
		public function Thumb(url:String)
		{
			super();
			imgurl = url;
			loadImage();
			asset = new CardHolder();
			idtxt = asset.idtxt;
			nametxt = asset.nametxt;
			tenhotxt = asset.tenhotxt;
			equippedtxt = asset.equippedtxt;
			this.addChild(asset);
			asset.addChild(imgContainer);
			setIndex();
		}
		
		private function setIndex():void
		{
			Utility.getInstance().bringForward(asset,asset.idtxt);
			Utility.getInstance().bringForward(asset,asset.nametxt);
			Utility.getInstance().bringForward(asset,asset.tenhotxt);
			Utility.getInstance().bringForward(asset,asset.equippedtxt);
		}
		private function loadImage():void
		{
			imgContainer = new Sprite();
			if (imgurl!="")
			{
				var loader:Loader = new Loader();
				var req:URLRequest = new URLRequest(imgurl);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onIMGLoaded);
				loader.contentLoaderInfo.addEventListener(LoaderEvent.IO_ERROR, onIOError);
				loader.load(req);
			}
		}
		
		protected function onIOError(event:Event):void
		{
			trace("Thumb.onIOError(event)");
		}
		protected function onIMGLoaded(event:Event):void
		{
			imgContainer.addChild(event.currentTarget.content as Bitmap);
		}
		public function addGlow():void
		{
			var glow:GlowFilter = new GlowFilter(); 
			glow.color = 0x009922; 
			glow.alpha = 1; 
			glow.blurX = 25; 
			glow.blurY = 25; 
			asset.filters = [glow];
		}
		public function removeGlow():void
		{
			var glow:GlowFilter = new GlowFilter();
			asset.filters = [glow];
		}
	}
}