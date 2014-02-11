package com.smoothtiles.player
{
	import com.smoothtiles.input.Keyboard;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class Player extends Sprite
	{
		public var asset		:Sprite;
		public var speed		:Number;
		public function Player(pSpeed:Number)
		{
			super();
			this.speed = pSpeed;
			createPlayer();
			this.addChild(asset);
		}
		private function createPlayer():void
		{
			asset = new Sprite();
			var regAsset :Shape = new Shape();
			var playerAsset :Shape = new Shape();
			playerAsset.graphics.beginFill(0x000000);
			playerAsset.graphics.drawRect(-15, -15, 30, 30);
			playerAsset.graphics.endFill();
			regAsset.graphics.beginFill(0xFFFFFF);
			regAsset.graphics.drawRect(0, 0, 1, 1);
			regAsset.graphics.endFill();
			asset.addChild(playerAsset);
			asset.addChild(regAsset);
		}
		
		public function update():void
		{
			var input:Keyboard = Keyboard.getInstance();
			if (input.LEFT)
			{
				x-=speed;
			}
			if (input.RIGHT)
			{
				x+=speed;
			}
			if (input.UP)
			{
				y-=speed;
			}
			if (input.DOWN)
			{
				y+=speed;
			}
		}
	}
}