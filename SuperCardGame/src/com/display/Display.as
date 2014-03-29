package com.display
{
	import com.Main;
	import com.display.Screens.ModeSelectionScreen;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;

	public class Display extends Sprite
	{
		public var main			:Main;
		public var modeSelect	:ModeSelectionScreen;
		public var game			:SingleGameScreen;
		public var background	:Shape;
		public var load			:MovieClip;
		
		public function Display(m_main:Main)
		{
			main=m_main;
			addBackground();
			addLoading();
		}
		
		private function addBackground():void
		{
			background = new Shape();
			background.graphics.beginFill(0x000000);
			background.graphics.drawRect(0, 0, 950, 705);
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
			if (!modeSelect) modeSelect = new ModeSelectionScreen(this);
			this.addChild(modeSelect);
		}
		
		public function goGame():void
		{
			if (this.contains(modeSelect)) this.removeChild(modeSelect);
			if (!game) game = new SingleGameScreen(this);
			this.addChild(game);
		}
	}
}