package com.display.screens.match
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class ScoreBoard extends Sprite
	{
		public var homeScore:TextField;
		public var awayScore:TextField;
		
		public function ScoreBoard()
		{
			super();
			homeScore =  new TextField();
			awayScore =  new TextField();
			show(homeScore,0,0);
			show(awayScore,60,0);
			homeScore.text = "3";
			awayScore.text = "1";
		}
		private function show(field:TextField, x:Number,y:Number):void
		{
			field.width = 50;
			field.height = 20;
			field.x = x;
			field.y = y;
			//bla bla configs
			this.addChild(field);
		}
	}
}