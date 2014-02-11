package com.smoothtiles.abstracttile
{
	import flash.display.Shape;
	import flash.display.Sprite;

	public class GenericTile extends Sprite
	{
		public const TYPE_CLEAR		:String = "C";
		public const TYPE_OBSTACLE	:String = "O";
		public const TYPE_1ST_SLOPE	:String = ">";
		public const TYPE_2ND_SLOPE	:String = ">>";
		public const TYPE_3RD_SLOPE	:String = ">>>";
		
		public var asset	:Sprite;
		public var type		:String;
		public var reverseX	:Boolean;
		public var reverseY	:Boolean;
		public var show		:Boolean;
		public var colour	:uint;
		public var size		:Number;
		public var border	:Number;
		
		public function GenericTile(t_type:String, t_size:Number, revX:Boolean = false, revY:Boolean = false, visible:Boolean = false)
		{
			type		= t_type;
			reverseX 	= revX;
			reverseY 	= revY;
			show 		= visible;
			size 	= t_size;
			border = size * 0.05;
			updateAsset();
		}
		
		public function updateAsset():void
		{
			asset = new Sprite();
			var rect		:Shape = new Shape();
			var rectBorder	:Shape = new Shape();
			switch(type)
			{
				case TYPE_CLEAR:
					colour = 0x99CC33;
					break;
				case TYPE_OBSTACLE:
					colour = 0x990000;
					break;
				case TYPE_1ST_SLOPE:
					colour = 0x0099FF;
					break;
				case TYPE_2ND_SLOPE:
					colour = 0x0066FF;
					break;
				case TYPE_3RD_SLOPE:
					colour = 0x0000FF;
					break;
			}
			rectBorder.graphics.beginFill(0xFFFFFF);
			rectBorder.graphics.drawRect(0, 0, size + border, size + border);
			rectBorder.graphics.endFill();
			asset.addChild(rectBorder);
			rect.graphics.beginFill(colour);
			rect.graphics.drawRect(border, border, size - border, size - border);
			rect.graphics.endFill();
			asset.addChild(rect);
			addChild(asset);
		}
	}
}