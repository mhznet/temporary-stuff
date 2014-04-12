package com.data
{
	import com.Main;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	public class Data
	{
		public var main			:Main;
		public var paramsNumber	:int;
		public var bmpVector	:Vector.<BMP>;
		public var paramsNames	:Vector.<String>;
		public var paramsIntera	:Vector.<String>;
		public var cardVector	:Vector.<Card>;
		public function Data(m_main:Main, xmlConfig:XMLList, xmlCards:XMLList, xmlAssets:XMLList, xmlBMPs:XMLList)
		{
			main=m_main;
			fillConfig(xmlConfig);
			fillCards(xmlCards)
			fillAssets(xmlAssets);
			fillBMPs(xmlBMPs);
		}
		
		private function fillBMPs(xmlBMPs:XMLList):void
		{
			bmpVector = new Vector.<BMP>();
			for (var i:int = 0; i < xmlBMPs.length(); i++) 
			{
				var bmp:BMP = new BMP(xmlBMPs[i].@id, verifyLoads);
				load(xmlBMPs[i].@bmpurl, bmp.onBMPLoaded);
				bmpVector.push(bmp);
			}
		}
		public function verifyLoads():void
		{
			var rdy:Boolean = true;
			for (var i:int = 0; i < bmpVector.length; i++) 
			{
				if (!bmpVector[i].ready)
				{
					rdy = false;
					break;
				}
			}
			if (rdy) main.onDataReady();
		}
		private function fillAssets(xmlAssets:XMLList):void
		{
			for (var i:int = 0; i < xmlAssets.length(); i++) 
			{
				var id	:int 	= xmlAssets[i].@id;
				var card:Card = getCardById(id);
				var url	:String = xmlAssets[i].@img;
				load(url,card.onImgLoaded);
			}
		}
		public function getBMPById(id:int):BitmapData
		{
			var bdata:BitmapData;
			for (var i:int = 0; i < bmpVector.length; i++) 
			{
				if(id == bmpVector[i].id)
				{
					bdata = bmpVector[i].bmp.clone();
					break;
				}
			}
			return bdata;
		}
		private function fillCards(xmlCards:XMLList):void
		{
			cardVector = new Vector.<Card>();
			for each (var card:XML in xmlCards) 
			{
				var crd:Card = new Card(card, paramsNumber, paramsNames);
				cardVector.push(crd);
			}
		}
		private function fillConfig(xmlConfig:XMLList):void
		{
			paramsNames  = new Vector.<String>();
			paramsIntera = new Vector.<String>();
			paramsNumber = xmlConfig.@paramsNumber;
			for (var i:int = 1; i <= paramsNumber; i++) 
			{
				paramsNames.push(xmlConfig.@["params"+i]);
				paramsIntera.push(xmlConfig.@["iparams"+i]);
			}
		}
		private function load(url:String, onComplete:Function):void
		{
			var loader	:Loader = new Loader();
			if (url!="")
			{
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, 	onComplete);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
				var req		:URLRequest = new URLRequest(url);
				loader.load(req);
			}
		}
		
		private function onIOError(e:IOErrorEvent):void
		{
			trace("Card.onIOError(e) " + e.text);
		}
		public function getCardById(id:int):Card
		{
			var card:Card;
			for (var i:int = 0; i < cardVector.length; i++) 
			{
				if (cardVector[i].id == id)
				{
					card = cardVector[i];
					break;
				}
			}
			return card;
		}
		public function clone(source:Object):* 
		{ 
			var myBA:ByteArray = new ByteArray(); 
			myBA.writeObject(source); 
			myBA.position = 0; 
			return(myBA.readObject()); 
		}
		public function getRandomizedIds(num:int):Vector.<int>
		{
			var vec:Vector.<int> = new Vector.<int>();
			for (var i:int = 1; i <= num; i++) 
			{
				vec.push([i]);
				vec.sort(randomSort);
			}
			return vec;
		}
		private function randomSort(a:*, b:*):Number
		{
			if (Math.random() < 0.5) return -1;
			return 1;
		}
		private function checkIfCardsNumberMatchPlayers(param:int, vec:Vector.<int>):Vector.<int>
		{
			var remainder:int = vec.length % param; 
			if (remainder != 0)
			{
				var random:int = Math.floor(Math.random()*vec.length);
				if (random + remainder > vec.length) 
				{
					trace ("Index a remover mais resto supera tamanho do baralho", random, remainder, vec.length);
					random -= remainder;
				}
				vec.splice(random, remainder);
			}
			return vec;
		}
		public function splitDeck(param0:int, test:Boolean = false, length:int = 0):Vector.<Vector.<int>>
		{
			if (!test) length = cardVector.length;
			var toReturn	:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
			var transfer	:Vector.<int> = checkIfCardsNumberMatchPlayers(param0, getRandomizedIds(length));
			if(transfer.length % param0 != 0) trace ("CARTA SOBRANDO QUANDO NAO DEVERIA", transfer.length % param0);
			if (param0 == 4 && transfer.length < 8) throw new Error("Quantidade insuficiente de cartas para o numero de jogadores");
			var p1			:Vector.<int>;
			var p2			:Vector.<int>;
			var p3			:Vector.<int>;
			var p4			:Vector.<int>;
			var quantity	:int = transfer.length / param0;
			switch(param0)
			{
				case 2:
					p1 = transfer.slice(0, quantity);
					p2 = transfer.slice(quantity, quantity * 2);
					break;
				case 3:
					p1 = transfer.slice(0, quantity);
					p2 = transfer.slice(quantity, quantity*2);
					p3 = transfer.slice((quantity*2), transfer.length);
					break;
				case 4:
					p1 = transfer.slice(0, quantity);
					p2 = transfer.slice(quantity,  quantity*2);
					p3 = transfer.slice((quantity*2), quantity*3);
					p4 = transfer.slice((quantity*3), transfer.length);
					break;
			}
			//trace ("Total Depois:",transfer.length);
			if (p3) 
			{
				if (p3.length!=p2.length || p3.length!=p1.length)
				{
					trace ("com erro p3");
				}
				trace ("p3:", p3.length);
			}
			if (p4)
			{
				if (p4.length!=p3.length || p4.length!=p2.length || p4.length!=p1.length)
				{
					trace ("om err p4");
				}
				trace ("p4:", p4.length);
			}
			if (p1.length != p2.length)
			{
				trace ("Nao deu!");
			}
			//trace ("\n",p1,"\n",p2,"\n",p3,"\n",p4);
			toReturn.push(p1,p2,p3,p4);
			return toReturn;
		}
	}
}