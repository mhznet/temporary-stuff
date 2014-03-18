package com
{
	import flash.display.Sprite;
	import flash.text.TextField;

	public final class Card extends Sprite
	{
		/**CONST**/
		public const OFFENSIVE	:int = 1;
		public const DEFENSIVE	:int = 2;
		/**DATA**/
		public var id			:int;
		public var star			:Boolean;
		public var equipped		:Boolean = false;
		public var m_name		:String;
		public var description	:String;
		public var nation		:String;
		public var jersey		:int;
		/**STATS**/
		public var offense 		:int;
		public var defense 		:int;
		public var hability		:int;
		public var speed 		:int;
		public var stamina 		:int;
		public var overall 		:int;
		public var style		:int;
		/**DISPLAY**/
		public var thumb		:CardHolder;
		public var asset		:CardAsset;
		public var assetName	:TextField;
		public var assetDesc	:TextField;
		public var assetOvr		:TextField;
		public var assetStyle	:TextField;
		public var assetRarity	:TextField;
		
		public function fillOverallAndAssets():void
		{
			overall = (offense + defense + hability + speed) / 4;
			asset = new CardAsset();
			assetName = asset.txt_Name;
			assetName.text = m_name;
			assetDesc = asset.txt_Desc;
			assetDesc.text = description;
			assetOvr = asset.txt_Overall;
			assetOvr.text = overall.toString();
			assetStyle = asset.txt_Style;
			assetStyle.text = style.toString();
			assetRarity = asset.txt_Rarity;
			assetRarity.text = star.toString();
			//this.addChild(asset);
			//trace (name, overall, translateSpeacialty(specialty));
		}
		public function Card(data:XML)
		{
			id 			= data.@id;
			star		= data.@star;
			m_name 		= data.@name;
			description = data.@desc;
			nation 		= data.@nation;
			jersey 		= data.@jersey;
			offense 	= data.@offense;
			defense 	= data.@defense;
			hability	= data.@hability;
			speed		= data.@speed;
			stamina 	= data.@stamina;
			offense > defense ? style = OFFENSIVE : style = DEFENSIVE;
			fillOverallAndAssets();
		}
	}
}