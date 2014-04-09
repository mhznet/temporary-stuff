package com.display
{
	import com.Main;
	import com.display.Screens.ModeSelectionScreen;
	import com.display.Screens.SingleGameScreen;
	import com.display.Screens.WinnerSplashScreen;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class Display extends Sprite
	{
		public var main			:Main;
		public var title		:TitleScreen;
		public var modeSelect	:ModeSelectionScreen;
		public var game			:SingleGameScreen;
		public var background	:Shape;
		public var realbg		:Sprite;
		public var load			:MovieClip;
		public var winnerSplash	:WinnerSplashScreen;
		
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
			background.graphics.beginFill(0x000000);
			background.graphics.drawRect(0, 0, 940, 600);
			background.graphics.endFill();
			this.addChild(background);
		}
		private function addLoading():void
		{
			load = new MovieClip();
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFF794B);
			shape.graphics.drawCircle(50, 50, 30);
			shape.graphics.endFill();
			load.addChild(shape);
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
		public function goTitle():void
		{
			hideLoad();
			addRealBG();
			if (!title) title = new TitleScreen(this);
			this.addChild(title);
		}
		public function goModeSelect():void
		{
			if (this.contains(title)) this.removeChild(title);
			if (!modeSelect) modeSelect = new ModeSelectionScreen(this);
			this.addChild(modeSelect);
		}
		public function goGame(p_num:int, ia:Boolean):void
		{
			if (this.contains(modeSelect)) this.removeChild(modeSelect);
			if (!game)
			{
				game = new SingleGameScreen(this, p_num, ia);
			}
			else
			{
				game.begin(p_num,0, ia);
			}
			this.addChild(game);
		}
		public function goToWinner(name:String):void
		{
			//resetOlderScreens
			if (this.contains(game)) 
			{
				this.removeChild(game);
				game.reset();
			}
			if (!winnerSplash) winnerSplash= new WinnerSplashScreen(this,name);
			this.addChild(winnerSplash);
		}
		public function reset(e:MouseEvent):void
		{
			if (this.contains(winnerSplash)) this.removeChild(winnerSplash);
			goModeSelect();
		}
	}
}