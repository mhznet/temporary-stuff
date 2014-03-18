package com
{
	import flash.display.Sprite;
	import flash.text.TextField;

	public final class Deck extends Sprite
	{
		public var inUse	:Vector.<Card>;
		/**ASSETS**/
		public var asset	:DeckAsset;
		public var assetAtk	:TextField;
		public var assetDef	:TextField;
		public var assetSP	:TextField;
		public var assetHb	:TextField;
		public var assetAtt	:TextField;
		public var assetDft	:TextField;
		public var assetOvr	:TextField;
		/**PLAY STYLE**/
		public var atk_type	:String = "";
		public var def_type	:String = "";
		/**STATS**/
		public var overall 	:int;
		public var offense 	:int;
		public var defense 	:int;
		public var hability	:int;
		public var speed	:int;
		
		public function fillDeckOverall():void
		{
			for each (var fig:Card in inUse) 
			{
				overall += fig.overall; 
				offense += fig.offense;
				defense += fig.defense;
				hability+= fig.hability;
				speed 	+= fig.speed;
			}
			overall  = overall  / inUse.length;
			offense  = offense  / inUse.length;
			defense  = defense  / inUse.length;
			hability = hability / inUse.length;
			speed  	 = speed	/ inUse.length;
			
			asset = new DeckAsset();
			assetAtk = asset.txt_Atk;
			assetAtk.text = offense.toString();
			assetDef = asset.txt_Def;
			assetDef.text = defense.toString();
			assetSP = asset.txt_Speed;
			assetSP.text = speed.toString();
			assetHb = asset.txt_Hab;
			assetHb.text = hability.toString();
			assetAtt = asset.txt_Atype;
			assetAtt.text = atk_type;
			assetDft = asset.txt_Dtype;
			assetDft.text = def_type;
			assetOvr = asset.txt_Overall;
			assetOvr.text = overall.toString();
			
			asset.p1.text = inUse[0].m_name;
			asset.p2.text = inUse[1].m_name;
			asset.p3.text = inUse[2].m_name;
			asset.p4.text = inUse[3].m_name;
			asset.p5.text = inUse[4].m_name;
			this.addChild(asset);
		}
		public function traceDeckInfo():void
		{
			var teamInfo:String = "ATK: " + offense + " / DEF: " + defense + " / HAB: " + hability + " / SPD: " + speed + " / OVR: " + overall;
			var lineUp	:String = "";
			for (var i:int = 0; i < inUse.length; i++) 
			{
				lineUp += "["+inUse[i].jersey+"] - " + inUse[i].m_name + " "+ inUse[i].overall + "\n"; 
			}
			trace (teamInfo + " ATK: " + atk_type + " / " + "DEF: " + def_type + "\n" + lineUp);
		}
		public function Deck(cardVector:Vector.<Card>)
		{
			inUse = cardVector;
			fillDeckOverall();
		}
	}
}