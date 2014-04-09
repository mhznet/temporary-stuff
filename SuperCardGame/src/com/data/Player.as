package com.data
{
	public class Player
	{
		public var cards	:Vector.<int>;
		public var plays	:Boolean;
		public var id		:int;
		public function Player(ids:int, playable:Boolean, card:Vector.<int>)
		{
			id = ids;
			plays = playable;
			cards = card;
		}
		public function destroy():void
		{
			id = 0;
			plays = false;
			cards = null;
		}
	}
}