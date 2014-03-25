package com.display.cards
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	
	public class Thumb extends Sprite
	{
		public var asset:CardHolder;
		public var idtxt:TextField;
		public var nametxt:TextField;
		public var tenhotxt:TextField;
		public var equippedtxt:TextField;
		
		public function Thumb()
		{
			super();
			asset = new CardHolder();
			idtxt = asset.idtxt;
			nametxt = asset.nametxt;
			tenhotxt = asset.tenhotxt;
			equippedtxt = asset.equippedtxt;
			this.addChild(asset);
		}
		public function addGlow():void
		{
			var glow:GlowFilter = new GlowFilter(); 
			glow.color = 0x009922; 
			glow.alpha = 1; 
			glow.blurX = 25; 
			glow.blurY = 25; 
			asset.filters = [glow];
		}
		public function removeGlow():void
		{
			var glow:GlowFilter = new GlowFilter();
			asset.filters = [glow];
		}
	}
}