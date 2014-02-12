package com.smoothtiles.abstracttile
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class GenericTile extends BaseTile
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
		
		public var id		:int;
		public var column	:int;
		public var row		:int;
		public var textField:TextField;
		public var secondTF:TextField;
		
		public function GenericTile(m_id:int,columNum:int,rowNum:int,t_type:String, t_size:Number, revX:Boolean = false, revY:Boolean = false, visible:Boolean = false)
		{
			id 			= m_id;
			column 		= columNum;
			row 		= rowNum;
			type		= t_type;
			reverseX 	= revX;
			reverseY 	= revY;
			show 		= visible;
			size 		= t_size;
			border 		= size * 0.05;
			updateAsset();
		}
		public function getWalkable():Boolean
		{
			return true;/* type == TYPE_CLEAR;*/
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
			rectBorder.graphics.drawRect(-(size + border) * 0.5, -(size + border) * 0.5, size + border, size + border);
			rectBorder.graphics.endFill();
			asset.addChild(rectBorder);
			rect.graphics.beginFill(colour);
			rect.graphics.drawRect(border - (size + border) * 0.5, border -(size + border) * 0.5, size - border, size - border);
			rect.graphics.endFill();
			asset.addChild(rect);
			textField = new TextField();
			secondTF = new TextField();
			var format:TextFormat = new TextFormat();
			format.size = 6;
			textField.setTextFormat(format);
			textField.textColor = 0xFFFFFF;
			secondTF.textColor = 0xFFFFFF;
			textField.text = id +"/" + row + "/" + column;
			textField.selectable = false;
			secondTF.selectable = false;
			textField.width = rectBorder.width;
			secondTF.width = rectBorder.width;
			textField.x = -rectBorder.width * 0.5;
			secondTF.x = textField.x;
			textField.y = -25;
			secondTF.y = 0;
			asset.addChild(textField);
			asset.addChild(secondTF);
			addChild(asset);
		}
		
		public function updateSecondTF(text:String):void
		{
			secondTF.text = text;
		}
	}
}