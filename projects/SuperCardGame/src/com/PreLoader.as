package com
{
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.utils.Timer;

	//import flash.system.Security;
	
	public class PreLoader extends MovieClip
	{
		private var asset	:PLAsset;
		private var sndLoad	:SecondLoad;
		private var movieObj:IMain;
		private var mymovie	:URLRequest;
		private var myloader:Loader = new Loader();
		private var date	:Date;
		private var numVal	:Number;
		private var isLocal	:Boolean = true;
		private var timer	:Timer
		
		public function PreLoader()
		{
			/*SECURITY.LOADPOLICYFILE("HTTP://GRAPH.FACEBOOK.COM/CROSSDOMAIN.XML");
			SECURITY.LOADPOLICYFILE("HTTPS://GRAPH.FACEBOOK.COM/CROSSDOMAIN.XML");
			SECURITY.LOADPOLICYFILE("HTTP://PROFILE.AK.FBCDN.NET/CROSSDOMAIN.XML");
			SECURITY.LOADPOLICYFILE("HTTPS://PROFILE.AK.FBCDN.NET/CROSSDOMAIN.XML");
			SECURITY.LOADPOLICYFILE("HTTP://FBCDN-PROFILE-A.AKAMAIHD.NET/CROSSDOMAIN.XML");
			SECURITY.LOADPOLICYFILE("HTTPS://FBCDN-PROFILE-A.AKAMAIHD.NET/CROSSDOMAIN.XML");
			SECURITY.LOADPOLICYFILE("HTTP://FBCDN-SPHOTOS-A.AKAMAIHD.NET/CROSSDOMAIN.XML");
			SECURITY.LOADPOLICYFILE("HTTPS://FBCDN-SPHOTOS-A.AKAMAIHD.NET/CROSSDOMAIN.XML");
			SECURITY.ALLOWDOMAIN("*");
			SECURITY.ALLOWINSECUREDOMAIN("*");*/
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			asset = new PLAsset();
			this.addChild(asset);
			date = new Date();
			numVal = date.time;
			var url:String;
			if (isLocal)
			{
				url = "Main.swf"
			}
			else
			{
				url = "http://media.mundodositio.globo.com.s3.amazonaws.com/face/matamata/bin-release-build/Main.swf";
			}
			//url = "appfacebook.swf?v=" + String(numVal);
			mymovie = new URLRequest(url);
			myloader = new Loader();
			
			myloader.contentLoaderInfo.addEventListener(Event.COMPLETE, addMovie);
			myloader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, movieProgress);
			
			stage.align = "TL";
			stage.scaleMode = "noScale";
			myloader.load(mymovie);
		}		
		
		public function addMovie(e:Event):void
		{
			movieObj = e.target.content;
			movieObj.setCompleteFunction(showMovie);
			with (e.target.content)
			{
				x = 0;
				y = 0;
			}
			completeBar();
		}
		
		private function completeBar():void
		{
			var delay:uint = 500;
			timer = new Timer(delay);
			timer.addEventListener(TimerEvent.TIMER, tick);
			timer.start();
		}
		
		protected function tick(event:TimerEvent):void
		{
			if (asset.preloader.bar.scaleX<=1)
			{
				asset.preloader.bar.scaleX += 0.025;
			}
			else
			{
				timer.stop();
				showSecondLoad();
			}
		}
		private function showSecondLoad():void
		{
			sndLoad = new SecondLoad();
			sndLoad.x = 470;
			sndLoad.y = 300;
			sndLoad.scaleX = sndLoad.scaleY = 0.3;
			this.addChild(sndLoad);
			asset.preloader.visible = false;
		}
		public function showMovie():void
		{
			if (timer) timer.stop();
			destroy();
			addChild(movieObj as DisplayObject);
		}
		public function movieProgress(e:ProgressEvent):void
		{
			asset.preloader.bar.scaleX = (e.bytesLoaded / e.bytesTotal) * 0.2;
			//asset.preloader.porcent.porcentagem_txt.text = String(Math.ceil(e.target.bytesLoaded / e.target.bytesTotal * 80) + "%");
		}
		private function destroy():void
		{
			while (numChildren > 0)
			{
				removeChildAt(0);
			}
		}
	}
}