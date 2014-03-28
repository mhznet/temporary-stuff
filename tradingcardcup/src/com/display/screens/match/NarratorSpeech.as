package com.display.screens.match
{
	public class NarratorSpeech
	{
		public var id		:int;
		public var text		:String;
		public var time		:Number;
		public var priority	:Number; //0~10
		public function NarratorSpeech(ids:int,txt:String, timeframe:Number, odds:int)
		{
			id = ids;
			text = txt;
			time = timeframe;
			priority = odds;
		}
	}
}