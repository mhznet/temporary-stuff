package com.data
{

	public class Teams
	{
		public var main_data	:MainData;
		public var data			:XMLList;
		public var fullteams	:Vector.<Deck>;
		public function Teams(teamData:XML,main:MainData)
		{
			main_data = main;
			data = teamData.team;
			fullteams = getTeamsFromData();
		}
		public function getTeamsFromData():Vector.<Deck>
		{
			var vec:Vector.<Deck> = new Vector.<Deck>();
			for (var i:int = 0; i < data.length(); i++) 
			{
				var deck:Deck = new Deck();
				deck.id			= data[i].@id;
				deck.m_name 	= data[i].@name;
				deck.description= data[i].@desc;
				var ids:String = data[i].@players;
				var players:Array = ids.split(",");
				var idVec:Vector.<int> = new Vector.<int>();
				for (var j:int = 0; j < players.length; j++) 
				{
					idVec.push(players[j]);
				}
				deck.inUse = main_data.album.getCardVectorFromIdVector(idVec);
				vec.push(deck);
			}
			return vec;
		}
		public function getTeamDeckById(id:int):Deck
		{
			var deckToReturn:Deck;
			for (var i:int = 0; i < fullteams.length; i++) 
			{
				if (fullteams[i].id == id)
				{
					deckToReturn = fullteams[i];
					break;
				}
			}
			return deckToReturn;
		}
		public function getIfAlreadyAddedInVector(cardid:int, vec:Vector.<Card>):Boolean
		{
			var alrdyAdded:Boolean = false;
			for (var i:int = 0; i < vec.length; i++) 
			{
				if (cardid == vec[i].id)
				{
					alrdyAdded = true;
					break;
				}
			}
			return alrdyAdded;
		}
	}
}