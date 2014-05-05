package com
{
	import com.data.MainData;
	import com.display.MainDisplay;
	
	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(width="950",height="705",frameRate="24",backgroundColor="#BBBBBB")]
	public class Main extends Sprite
	{
		public var data		:MainData;
		public var display	:MainDisplay;
		
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			display = new MainDisplay(this);
			this.addChild(display);
			data = new MainData(this);
		}
		public function albumReady():void
		{
			display.gotoTitle();
		}
		
		public function sortPlayerDeck():void
		{
			data.album.playerDeck = data.album.getRandomDeck(10);
			data.album.updateDeck(data.album.playerDeck);
			data.album.bubbleSort(data.album.fullDeck);
		}
	}
}