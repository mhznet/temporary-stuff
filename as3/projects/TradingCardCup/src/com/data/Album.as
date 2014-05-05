package com.data
{
	public final class Album
	{
		public var data				:XMLList;
		public var fullDeck			:Vector.<Card>;
		public var playerDeck		:Vector.<Card>;
		
		public function Album(albumData:XML)
		{
			data = albumData.card;
			fullDeck = getAlbumVectorFromData();
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
		public function getCardById(id:int):Card
		{
			var card:Card;
			for (var i:int = 0; i < fullDeck.length; i++) 
			{
				if (fullDeck[i].id == id)
				{
					card = fullDeck[i];
					break;
				}
			}
			return card;
		}
		public function getCardVectorFromIdVector(vec:Vector.<int>):Vector.<Card>
		{
			var cards:Vector.<Card> = new Vector.<Card>();
			for (var i:int = 0; i < vec.length; i++) 
			{
				var card:Card = this.getCardById(vec[i]);
				if (card!=null)cards.push(card);
			}
			return cards;
		}
		public function getAllPlayerCards():Vector.<Card>
		{
			if (!playerDeck)
			{
				playerDeck = new Vector.<Card>();
				for (var i:int = 0; i < fullDeck.length; i++) 
				{
					if (fullDeck[i].doHave)
					{
						playerDeck.push(fullDeck[i]);
					}
				}
			}
			return playerDeck;
		}
		
		public function pushToPlayerDeck(card:Card):void
		{
			for (var i:int = 0; i < playerDeck.length; i++) 
			{
				if (playerDeck[i].id == card.id)
				{
					return;
				}
				playerDeck.push(card);
			}
		}
		
		public function updateDeck(player:Vector.<Card>):void
		{
			for (var i:int = 0; i < player.length; i++) 
			{
				for (var j:int = 0; j < fullDeck.length; j++) 
				{
					if (fullDeck[j].id == player[i].id)
					{
						fullDeck[j].doHave = true;
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
					if (vec[j].doHave && !vec[j-1].doHave)
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