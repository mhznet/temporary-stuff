package com.display.screens.match
{
	import com.data.Card;
	import com.display.MainDisplay;
	import com.display.screens.AbstractScreen;
	
	public final class MatchScreen extends AbstractScreen
	{
		private var totalRounds	:int = 10;
		private var homeStarts	:Boolean;
		private var p2			:Vector.<Card>;
		private var p1			:Vector.<Card>;
		public  var narrator	:Narrator;
		public var scoreBoard	:ScoreBoard;
		public var simulator	:ScoreSimulator;
		
		public function MatchScreen(disp:MainDisplay)
		{
			super(disp);
			narrator = new Narrator();
			narrator.asset.x = display.width * 0.5 - narrator.asset.width*0.5;
			narrator.asset.y = display.height * 0.5;
			this.addChild(narrator.asset);
			scoreBoard = new ScoreBoard();
			this.addChild(scoreBoard);
			simulator = new ScoreSimulator(p1,p2);
		}
		public function setTeams(ia:Vector.<Card>, player:Vector.<Card>):void
		{
			p1 = player;
			p2 = ia;
			testMatch();
		}
		
		public function tossTheCoin():void
		{
			var homeWants	:int = Math.ceil(Math.random() * 2);
			var refereeSays	:int = Math.ceil(Math.random() * 2);
			homeStarts = homeWants == refereeSays;
			trace ("Time da casa começa:", homeStarts);
		}
		
		private function testMatch():void
		{
			for (var i:int = 0; i < 10; i++) 
			{
				narrator.add(narrator.types.beginVector[Math.floor(Math.random() * narrator.types.beginQuantity)]);
				narrator.add(narrator.types.middleVector[Math.floor(Math.random() * narrator.types.middleQuantity)]);
				narrator.add(narrator.types.endVector[Math.floor(Math.random() * narrator.types.endQuantity)]);
				narrator.add(narrator.types.interruptionVector[Math.floor(Math.random() * narrator.types.interruptionQuantity)]);
			}
			//narrator.test();
			narrator.play();
		}
	}
}