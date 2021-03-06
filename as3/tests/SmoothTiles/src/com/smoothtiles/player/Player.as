package com.smoothtiles.player
{
	import com.smoothtiles.abstracttile.BaseTile;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class Player extends BaseTile
	{
		public var asset		:Sprite;
		public var pSize		:Number = 30;
		public function Player()
		{
			super();
			createPlayer();
			this.addChild(asset);
			this.name = "PLAYER";
		}
		private function createPlayer():void
		{
			asset = new Sprite();
			var regAsset :Shape = new Shape();
			var playerAsset :Shape = new Shape();
			playerAsset.graphics.beginFill(0x000000);
			playerAsset.graphics.drawRect(0, 0, pSize, pSize);
			playerAsset.graphics.endFill();
			regAsset.graphics.beginFill(0xFFFFFF);
			regAsset.graphics.drawRect(0, 0, 1, 1);
			regAsset.graphics.endFill();
			asset.addChild(playerAsset);
			asset.addChild(regAsset);
		}
		
		public function setX(value:Number, increment:Boolean = true):void
		{
			increment ? this.x +=value : this.x = value /*+ this.width * 0.85*/;
		}
		public function setY(value:Number, increment:Boolean = true):void
		{
			increment ? this.y+=value : this.y = value /*+ this.height * 0.85*/;
		}
	}
}