package com.display
{
	import com.Main;
	import com.display.screens.ModeSelectionScreen;
	import com.display.screens.SingleGameScreen;
	import com.display.screens.WinnerSplashScreen;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.display.screens.RuleScreen;
	import com.display.screens.TitleScreen;
	import com.display.utils.CardShuffleAnimation;
	import com.display.utils.InitialLoading;

	public class Display extends Sprite
	{
		public var main			:Main;
		public var title		:TitleScreen;
		public var rules		:RuleScreen;
		public var modeSelect	:ModeSelectionScreen;
		public var game			:SingleGameScreen;
		public var background	:Shape;
		public var realbg		:Sprite;
		public var load			:InitialLoading;
		public var winnerSplash	:WinnerSplashScreen;
		public var turns		:int = 1;
		public var shuffle		:CardShuffleAnimation;
		public function Display(m_main:Main)
		{
			main=m_main;
			addBackground();
			addLoading();
		}
		
		public function addRealBG():void
		{
			realbg = new Sprite();
			var bgImg:Bitmap = new Bitmap();
			bgImg.bitmapData = main.data.getBMPById(4).clone();
			realbg.addChild(bgImg);
			this.addChild(realbg);
			this.setChildIndex(realbg, this.getChildIndex(realbg)-1);
		}
		
		private function addBackground():void
		{
			background = new Shape();
			background.graphics.beginFill(0xFFFFFF);
			background.graphics.drawRect(0, 0, 940, 600);
			background.graphics.endFill();
			this.addChild(background);
		}
		private function addLoading():void
		{
			load = new InitialLoading();
			load.x = background.width*0.5 - load.width * 0.5;
			load.y = background.height*0.5 - load.height * 0.5;
			addChild(load);
		}
		public function hideLoad():void
		{
			load.visible = false;
		}
		public function showLoad():void
		{
			load.visible = true;
		}
		public function goTitle(e:MouseEvent=null):void
		{
			hideLoad();
			addRealBG();
			if (!title) title = new TitleScreen(this);
			this.addChild(title);
		}
		public function goRules():void
		{
			if (this.contains(title)) this.removeChild(title);
			if(!rules) rules = new RuleScreen(this);
			this.addChild(rules);
		}
		public function goModeSelect():void
		{
			if (rules) if (this.contains(rules)) this.removeChild(rules);
			if (this.contains(title)) this.removeChild(title);
			if (!modeSelect) 
			{
				modeSelect = new ModeSelectionScreen(this);
			}
			else
			{
				modeSelect.begin();
			}
			this.addChild(modeSelect);
		}
		public function goGame(p_num:int, ia:Boolean):void
		{
			if (this.contains(modeSelect))
			{
				this.removeChild(modeSelect);
				modeSelect.close();
			}
			if (!game)
			{
				game = new SingleGameScreen(this, p_num, ia);
			}
			else
			{
				game.begin(p_num, turns, ia);
			}
			this.addChild(game);
		}
		public function goToWinner(hasIa:Boolean,winLostOrDraw:int,name:int,cardNum:int):void
		{
			//resetOlderScreens
			if (this.contains(game)) 
			{
				this.removeChild(game);
				game.reset();
			}
			switch(name)
			{
				case 0:
					name = 1;
					break;
				case 1:
					name = 2;
					break;
			}
			if (!winnerSplash)
			{
				winnerSplash= new WinnerSplashScreen(this,winLostOrDraw,name,cardNum,hasIa);
			}
			else
			{
				winnerSplash.begin(winLostOrDraw,name,cardNum,hasIa);
			}
			this.addChild(winnerSplash);
		}
		public function reset(e:MouseEvent):void
		{
			if (this.contains(winnerSplash)) 
			{
				this.removeChild(winnerSplash);
				winnerSplash.close();
			}
			goModeSelect();
		}
	}
}