package com
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	
	public class Questionario
	{
		private var picRequest:URLRequest;
		private var picLoader:Loader;
		
		private var pergunta:String;
		private var valor:int;
		private var opcaoCerta:String;
		private var opcaoA:String;
		private var opcaoB:String;
		private var opcaoC:String;
		private var opcaoD:String;
		private var rodapeTxt:String;
		
		private var bandeiraA:MovieClip;
		private var bandeiraB:MovieClip;
		private var bandeiraC:MovieClip;
		private var bandeiraD:MovieClip;
		
		private var optBandeiraA:String;
		private var optBandeiraB:String;
		private var optBandeiraC:String;
		private var optBandeiraD:String;
		
		public function Questionario():void
		{
		}
		
		public function loadBandeiras(nome:String):void
		{
			picRequest = new URLRequest("xml/cidades/bandeiras/" + nome);
			//trace("loadBandeiras: " + nome);
			picLoader = new Loader();
			picLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, fillBandeiras, false, 0, true);
			picLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress, false, 0, true);
			picLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			picLoader.load(picRequest);
		}
		
		private function ioErrorHandler(e:Event):void {}
		private function onProgress(e:ProgressEvent):void
		{
			//trace("onProgress: ",e.bytesLoaded, e.bytesTotal);
		}
		
		private function fillBandeiras(e:Event):void 
		{
			var objLoaderInfo:LoaderInfo = LoaderInfo(e.currentTarget);
			var urlArray:Array = objLoaderInfo.url.split("/");;
			var bandeiraNome:String = urlArray[(urlArray.length - 1)];
			var movieClip:MovieClip = new MovieClip();
			movieClip.x = 80;
			movieClip.y = 0;
			movieClip.name = bandeiraNome;
			movieClip.addChild(objLoaderInfo.content);
			//trace(objLoaderInfo.content.name, objLoaderInfo.content, objLoaderInfo.contentType, objLoaderInfo.url.split);
			switch (bandeiraNome)
			{
				case optBandeiraA:
					this.setBandeira("A", movieClip);
				break;
				case optBandeiraB:
					this.setBandeira("B", movieClip);
				break;
				case optBandeiraC:
					this.setBandeira("C", movieClip);
				break;
				case optBandeiraD:
					this.setBandeira("D", movieClip);
				break;
			}
		}
		
		public function setBandeira(opt:String, value:MovieClip):void
		{
			//trace (["bandeira" + opt], value.numChildren);
			this["bandeira" + opt] = value;
		}
		
		public function getBandeira(opt:String):MovieClip
		{
			return this["bandeira" + opt];
		}
		
		public function setOpcaoCerta(value:String):void
		{
			opcaoCerta = value;
		}
		
		public function getOpcaoCerta():String
		{
			return opcaoCerta;
		}
		
		public function setRodapeTxt(value:String):void
		{
			if (value != null)
			{
				rodapeTxt = value;
			}
			else 
			{
				rodapeTxt = "";
			}
		}
		
		public function getRodape():String
		{
			return rodapeTxt;
		}
		
		public function setValor(value:int):void
		{
			valor = value;
		}
		
		public function getValor():int
		{
			return valor;
		}
		
		public function setPergunta(value:String):void
		{
			pergunta = value;
		}
		
		public function getPergunta():String
		{
			return pergunta;
		}
		
		public function setOpcao(opt:String, value:String):void
		{
			if ((value.substr((value.length - 4), value.length)) == ".png")
			{
				this["optBandeira" + opt] = value;
				this.loadBandeiras(value);
			}
			this["opcao" + opt] = value;
		}
		
		public function getOpcao(opt:String):String
		{
			return this["opcao" + opt];
		}
	}
}