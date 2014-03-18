package com
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * TODO:
	 * 		Integrar com Facebook
	 * 		Carregar ids album da pessoa.
	 * 		Cruzar com album geral.
	 * 		Carregar fotos das cartas.
	 * 		
	 * 
	 * 
	 * 
	 * 
	 * **/
	[SWF(width="950",height="705",frameRate="24",backgroundColor="#BBBBBB")]
	public class Main extends Sprite
	{
		public var album	:Album;
		public var version	:String = "?v=1";

		public var match		:Match;
		
		public var background	:Shape;
		public var btloading	:LoadingAsset;
		public var btRandom		:RandomBt;
		public var btAlbum		:AlbumBt;
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			addBg();
			showOrHideLoading();
			loadAlbumXML();
		}
		private function addBg():void
		{
			background = new Shape();
			background.graphics.drawRect(0,0,950,705);
			background.graphics.beginFill(0xFF0000,1);
			this.addChild(background);
		}
		private function showOrHideLoading():void
		{
			if (!btloading)
			{
				btloading = new LoadingAsset();
				btloading.x = this.width * 0.5;
				btloading.y = this.height * 0.5;
				this.addChild(btloading);
			}
			else if (this.contains(btloading))
			{
				this.removeChild(btloading);
			}
		}
		private function showOrHideBtRandom():void
		{
			if (!btRandom)
			{
				btRandom = new RandomBt();
				btRandom.addEventListener(MouseEvent.CLICK, randomPlay);
				btRandom.x = stage.stage.width * 0.5;
				btRandom.y = stage.stage.height * 0.8;
				btRandom.buttonMode = true;
				this.addChild(btRandom);
			}
			else if (this.contains(btRandom))
			{
				this.removeChild(btRandom);
			}
		}
		private function showOrHideBtAlbum():void
		{
			if (!btAlbum)
			{
				btAlbum = new AlbumBt();
				btAlbum.addEventListener(MouseEvent.CLICK, showAlbum);
				btAlbum.x = stage.stage.width * 0.5;
				btAlbum.y = stage.stage.height * 0.8 + (btAlbum.height + 2);
				btAlbum.buttonMode = true;
				this.addChild(btAlbum);
			}
			else if (this.contains(btRandom))
			{
				this.removeChild(btAlbum);
			}
		}
		
		protected function showAlbum(event:MouseEvent):void
		{
			if (album)
			{
				if (album.asset)
				{
					if (!this.contains(album.asset))
					{
						album.asset.x = stage.stage.width * 0.5 - album.asset.width * 0.5;
						this.addChild(album.asset);
					}
					else
					{
						this.removeChild(album.asset);
					}
				}
			}
		}
		public function loadAlbumXML():void
		{
			var loader:URLLoader = new URLLoader();
			var req:URLRequest = new URLRequest("../assets/fullalbum.xml"+version);
			loader.addEventListener(Event.COMPLETE, onAlbumLoaded);
			loader.load(req);
		}
		protected function onAlbumLoaded(event:Event):void
		{
			var xml:XML = new XML(event.target.data)
			album = new Album(xml);
			showOrHideLoading();
			showOrHideBtRandom();
			showOrHideBtAlbum();
		}
		protected function randomPlay(event:MouseEvent):void
		{
			var m_deck	:Deck = new Deck(album.getRandomDeck(5));
			album.updateDeck(m_deck.inUse);
			album.bubbleSort(album.fullDeck);
			album.asset.fill(album.fullDeck);
			m_deck.x = 100;
			this.addChild(m_deck);
		}
		private function testMatch():void
		{
			match = new Match();
			match.x = stage.stage.width * 0.5 - match.width * 0.5;
			match.y = stage.stage.height * 0.7 - match.height * 0.5;
			this.addChild(match);
			match.narrator.test();
			match.narrator.play();
		}
	}
}