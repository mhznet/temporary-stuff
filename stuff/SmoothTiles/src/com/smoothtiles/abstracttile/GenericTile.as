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
		public var rectBorder:Shape;
		public var rect		:Shape;
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
			asset 		= new Sprite();
			createAsset();
		}
		
		private function createAsset():void
		{
			var func:Function;
			drawBorder();
			switch(type)
			{
				case TYPE_CLEAR:
					colour = 0x99CC33;
					func = drawRect;
					break;
				case TYPE_OBSTACLE:
					colour = 0x990000;
					func = drawRect;
					break;
				case TYPE_1ST_SLOPE:
					colour = 0x0099FF;
					func = drawSlope;
					break;
				case TYPE_2ND_SLOPE:
					colour = 0x0066FF;
					break;
				case TYPE_3RD_SLOPE:
					colour = 0x0000FF;
					break;
			}
			func();
			drawTextFields();
			addChild(asset);
		}
		private function drawBorder():void
		{
			rectBorder = new Shape();
			rectBorder.graphics.beginFill(0xFFFFFF);
			rectBorder.graphics.drawRect(0, 0, size, size);
			rectBorder.graphics.endFill();
			asset.addChild(rectBorder);
		}
		public function drawSlope():void
		{
			var triangleShape		:Shape = new Shape();
			triangleShape.graphics.beginFill(colour);
			triangleShape.graphics.moveTo(border, border);
			triangleShape.graphics.lineTo(size,border);
			triangleShape.graphics.lineTo(size, size);
			
			var triangleShape2		:Shape = new Shape();
			triangleShape2.graphics.beginFill(0x99CC33);
			triangleShape2.graphics.moveTo(size, size);
			triangleShape2.graphics.lineTo(border, size - border);
			triangleShape2.graphics.lineTo(border, border);
			asset.addChild(triangleShape);
			asset.addChild(triangleShape2);
		}
		public function drawRect():void
		{
			rect = new Shape();
			rect.graphics.beginFill(colour);
			rect.graphics.drawRect(border, border, size - border * 1.5, size - border * 1.5);
			rect.graphics.endFill();
			asset.addChild(rect);
		}
		public function drawTextFields():void
		{
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
			textField.width = rectBorder.width - border;
			secondTF.width = rectBorder.width - border;
			textField.height = 25;
			secondTF.height = 25;
			/*trace ("TF",textField.width,textField.height);
			trace ("STF:",secondTF.width,secondTF.height);*/
			textField.x = 0;
			secondTF.x = textField.x;
			textField.y = 0;
			secondTF.y = 25;
			asset.addChild(textField);
			asset.addChild(secondTF);
		}
		public function isType(oType:String):Boolean
		{
			return this.type == oType;
		}
		public function updateSecondTF(text:String):void
		{
			secondTF.text = text;
		}
		
	}
}