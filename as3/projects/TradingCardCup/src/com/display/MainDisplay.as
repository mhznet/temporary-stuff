package com.display
{
	import com.Main;
	import com.display.screens.challenger.ChallengersScreen;
	import com.display.screens.CollectScreen;
	import com.display.screens.StatisticsScreen;
	import com.display.screens.TitleScreen;
	import com.display.screens.match.MatchScreen;
	import com.display.screens.selector.SelectionScreen;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class MainDisplay extends Sprite
	{
		public var main				:Main
		public var background		:Shape;
		public var btloading		:LoadingAsset;
		
		public var titleScreen		:TitleScreen;
		public var cardSelectScreen	:SelectionScreen;
		public var challengeScreen	:ChallengersScreen;
		public var matchScreen		:MatchScreen;
		public var statisticsScreen	:StatisticsScreen;
		public var collectScreen	:CollectScreen;
		
		public function MainDisplay(maine:Main)
		{
			main = maine;
			initBackGround();
			initLoading();
			initializeScreens();
			showOrHide(this, background);
			showOrHide(this, btloading);
		}
		private function initBackGround():void
		{
			background = new Shape();
			background.graphics.drawRect(0,0,950,705);
			background.graphics.beginFill(0xFF0000,1);
		}
		private function initLoading():void
		{
			if (!btloading)
			{
				btloading = new LoadingAsset();
				btloading.x = this.width * 0.5;
				btloading.y = this.height * 0.5;
			}
		}
		public function initializeScreens():void
		{
			statisticsScreen = new StatisticsScreen(this);
			collectScreen = new CollectScreen(this);
		}
		public function showOrHide(container:Sprite,spr:DisplayObject):void
		{
			if (!container.contains(spr))
			{
				container.addChild(spr);
			}
			else
			{
				container.removeChild(spr);
			}
		}
		public function gotoTitle(event:MouseEvent = null):void
		{
			if (!titleScreen) titleScreen = new TitleScreen(this);
			if (this.contains(btloading))
				this.removeChild(btloading);
			showOrHide(this,titleScreen);
		}
		public function gotoSelectCards(event:MouseEvent):void
		{
			if (!cardSelectScreen)cardSelectScreen = new SelectionScreen(this);
			showOrHide(this,titleScreen);
			showOrHide(this,cardSelectScreen);
			main.sortPlayerDeck();
			cardSelectScreen.selector.fill(main.data.album.fullDeck);
		}
		
		public function goToChallenger():void
		{
			if(!challengeScreen)challengeScreen = new ChallengersScreen(this);
			showOrHide(this,cardSelectScreen);
			showOrHide(this,challengeScreen);
		}
		
		public function goToMatch():void
		{
			if (!matchScreen) matchScreen = new MatchScreen(this);
			matchScreen.setTeams(main.data.teams.getTeamDeckById(challengeScreen.selectedId).inUse, main.data.teams.getPlayerTeam());
			showOrHide(this,challengeScreen);
			showOrHide(this,matchScreen);
		}
	}
}