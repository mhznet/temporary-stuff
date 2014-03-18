package com
{
	public final class Album
	{
		public var data		:XMLList;
		public var fullDeck	:Vector.<Card>;
		public var asset	:AlbumAsset;
		public function Album(albumData:XML)
		{
			data = albumData.card;
			fullDeck = getAlbumVectorFromData();
			asset = new AlbumAsset();
			trace ("AlbumSize:", data.length());
		}
		public function getAlbumVectorFromData():Vector.<Card>
		{
			var vec:Vector.<Card> = new Vector.<Card>();
			for (var i:int = 0; i < data.length(); i++) 
			{
				var card:Card = new Card(data[i]);
				vec.push(card);
			}
			return vec;
		}
		public function updateDeck(player:Vector.<Card>):void
		{
			for (var i:int = 0; i < player.length; i++) 
			{
				for (var j:int = 0; j < fullDeck.length; j++) 
				{
					if (fullDeck[j].id == player[i].id)
					{
						fullDeck[j].equipped = true;
					}
				}
			}
		}
		public function bubbleSort(vec:Vector.<Card>):void
		{
			for (var i:int = vec.length-1; i >= 0; i--)
			{
				for (var j:int = 1; j < vec.length; j++) 
				{
					var hold:Card;
					if (vec[j].equipped && !vec[j-1].equipped)
					{
						hold = vec[j-1];
						vec[j-1] = vec[j]
						vec[j] = hold;
					}
				}
			}
		}
		public function getRandomDeck(length:int):Vector.<Card>
		{
			var allCards	:Vector.<Card> =  getAlbumVectorFromData();
			var returnCards	:Vector.<Card> = new Vector.<Card>();
			if (length <= allCards.length)
			{
				for (var i:int = 0; i < length; i++) 
				{
					var random:Number = Math.ceil(Math.random() * allCards.length-1);
					returnCards.push(allCards[random]);
					allCards.splice(random, 1);
				}
			}
			return returnCards;
		}
	}
}