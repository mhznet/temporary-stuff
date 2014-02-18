package com.smoothtiles.abstracttile
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class GenericTile extends BaseTile
	{
		public const TYPE_CLEAR		:String = "cc";
		public const TYPE_OBSTACLE	:String = "oo";
		
		/**From upper left to bottom right, meaning that when collision happens the object will go "\" downward to the right **/
		public const TYPE_U2R_SLOPE	:String = "V>";
		/**From upper right to bottom left, meaning that when collision happens the object will go "/" downward to the left **/
		public const TYPE_U2L_SLOPE	:String = "V<";
		/**From lower right to upper left, meaning that when collision happens the object will go "\" upward to the left **/
		public const TYPE_B2L_SLOPE	:String = "A>";
		/**from lower left to upper right, meaning that when collision happens the object will go "/" upward to the right **/
		public const TYPE_B2R_SLOPE	:String = "A<";
		
		public var asset	:Sprite;
		public var rectBorder:Shape;
		public var rect		:Shape;
		public var type		:String;
		public var reverseX	:Boolean;
		public var reverseY	:Boolean;
		public var show		:Boolean;
		public var showTXT	:Boolean;
		public var colour	:uint;
		public var size		:Number;
		public var border	:Number;
		
		public var id		:int;
		public var column	:int;
		public var row		:int;
		public var textField:TextField;
		public var secondTF:TextField;
		
		public function GenericTile(m_id:int,columNum:int,rowNum:int,t_type:String, t_size:Number, showText:Boolean = false, visible:Boolean = false)
		{
			id 			= m_id;
			column 		= columNum;
			row 		= rowNum;
			type		= t_type;
			show 		= visible;
			size 		= t_size;
			border 		= size * 0.05;
			asset 		= new Sprite();
			createAsset();
		}
		
		private function createAsset():void
		{
			var reversed	:Boolean = false;
			var bottomHit	:Boolean = false;
			var fullTile	:Boolean = true;
			
			drawBorder();
			switch(type)
			{
				case TYPE_CLEAR:
					colour = 0x99CC33;
					fullTile = true;
					break;
				case TYPE_OBSTACLE:
					colour = 0x990000;
					fullTile = true;
					break;
				case TYPE_U2R_SLOPE:
					colour = 0x0099FF;
					fullTile = false;
					// Up to lower right
					// Not reversed
					// Hit in the upper part
					break;
				case TYPE_U2L_SLOPE:
					colour = 0x0066FF;
					fullTile = false;
					reversed = true;
					// Reversed!
					// Up to lower left
					// Hit in the upper part
					break;
				case TYPE_B2R_SLOPE:
					colour = 0x0000FF;
					fullTile = false;
					bottomHit = true;
					reversed = true;
					// Bottom to upper right
					// Hit in the lower part
					break;
				case TYPE_B2L_SLOPE:
					colour = 0x0000FF;
					fullTile = false;
					bottomHit = true;
					reversed = false;
					// Bottom to upper left
					// Hit in the lower part
					break;
				default:
					trace ("Suckit!");
					break;
			}
			drawAsset(fullTile,bottomHit,reversed);
			if (showTXT) drawTextFields();
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
		public function drawAsset(fullTile:Boolean = true, bottom:Boolean = false, reversed:Boolean = false):void
		{
			if (fullTile)
			{
				rect = new Shape();
				rect.graphics.beginFill(colour);
				rect.graphics.drawRect(border, border, size - border * 1.5, size - border * 1.5);
				rect.graphics.endFill();
				asset.addChild(rect);
			}
			else
			{
				var colour_1	:uint = colour;
				var colour_2	:uint = 0x99CC33;
				if (bottom)
				{
					colour_1 = 0x99CC33;
					colour_2 = colour;
				}
				
				var point_1		:Point = new Point(border, border);;
				var point_2		:Point = new Point(size, border);
				var point_3		:Point = new Point(size, size);
				
				var point_1_2	:Point = new Point(size, size);
				var point_2_2	:Point = new Point(border, size - border);
				var point_3_2	:Point = new Point(border, border);
				
				if (reversed)
				{
					point_1 = new Point(border, size);
					point_2 = new Point(size, border);
					point_3 = new Point(size, size);
					
					point_1_2 = new Point(border, size);
					point_2_2 = new Point(border, border);
					point_3_2 = new Point(size, border);
				}

				var triangleShape		:Shape = new Shape();
				triangleShape.graphics.beginFill(colour_1);
				triangleShape.graphics.moveTo(point_1.x, point_1.y);
				triangleShape.graphics.lineTo(point_2.x,point_2.y);
				triangleShape.graphics.lineTo(point_3.x, point_3.y);
				
				var triangleShape2		:Shape = new Shape();
				triangleShape2.graphics.beginFill(colour_2);
				triangleShape2.graphics.moveTo(point_1_2.x, point_1_2.y);
				triangleShape2.graphics.lineTo(point_2_2.x, point_2_2.y);
				triangleShape2.graphics.lineTo(point_3_2.x, point_3_2.y);
				
				asset.addChild(triangleShape);
				asset.addChild(triangleShape2);
			}
			
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
			textField.height = size * 0.5;
			secondTF.height = size * 0.5;
			/*trace ("TF",textField.width,textField.height);
			trace ("STF:",secondTF.width,secondTF.height);*/
			textField.x = 0;
			secondTF.x = textField.x;
			textField.y = 0;
			secondTF.y = size * 0.5;
			asset.addChild(textField);
			asset.addChild(secondTF);
		}
		public function isType(oType:String):Boolean
		{
			return this.type == oType;
		}
		public function updateSecondTF(text:String):void
		{
			if (secondTF)secondTF.text = text;
		}
		
	}
}