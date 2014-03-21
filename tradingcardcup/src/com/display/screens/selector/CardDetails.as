package com.display.screens.selector
{
	import com.display.MainDisplay;
	import com.display.screens.AbstractScreen;
	
	import flash.text.TextField;
	
	public class CardDetails extends AbstractScreen
	{
		public var asset		:CardAsset;
		public var assetName	:TextField;
		public var assetDesc	:TextField;
		public var assetOvr		:TextField;
		public var assetStyle	:TextField;
		public var assetRarity	:TextField;
		
		public function CardDetails(disp:MainDisplay)
		{
			super(disp);
			asset = new CardAsset();
			this.addChild(asset);
		}
		
		public function fill(name:String,id:int,desc:String,off:int,def:int,hab:int,spd:int,style:String,star:String):void
		{
			var overall:int = (off + def + hab + spd) / 4;
			assetName = asset.txt_Name;
			assetName.text = name;
			assetDesc = asset.txt_Desc;
			assetDesc.text = desc;
			assetOvr = asset.txt_Overall;
			assetOvr.text = overall.toString();
			assetStyle = asset.txt_Style;
			assetStyle.text = style.toString();
			assetRarity = asset.txt_Rarity;
			assetRarity.text = star.toString();
		}
	}
}