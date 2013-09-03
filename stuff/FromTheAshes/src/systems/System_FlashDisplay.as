package systems
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	import nodes.Node_FlashDisplay;
	import comp.Comp_FlashDisplay;
	import comp.Comp_Position;

	public class System_FlashDisplay extends System
	{
		public var displayContainer 	:DisplayObjectContainer;
		private var displayNodes 		:NodeList;
		public function System_FlashDisplay(dispContainer:DisplayObjectContainer)
		{
			displayContainer = dispContainer;
		}
		override public function addToEngine(engine:Engine):void
		{
			displayNodes = engine.getNodeList(Node_FlashDisplay);
			for( var node : Node_FlashDisplay = displayNodes.head; node; node = node.next )
			{
				addToDisplay(node);
			}
			displayNodes.nodeAdded.add(addToDisplay);
			displayNodes.nodeRemoved.add(removeFromDisplay);
		}
		private function addToDisplay(node:Node_FlashDisplay):void
		{
			displayContainer.addChild(node.displayObject.display);
		}
		private function removeFromDisplay(node:Node_FlashDisplay):void
		{
			displayContainer.removeChild(node.displayObject.display);
		}
		override public function update( time : Number ) : void
		{
			var node:Node_FlashDisplay;
			var position:Comp_Position;
			var display:Comp_FlashDisplay;
			var displayObject:DisplayObject;
			for( node = displayNodes.head; node; node = node.next )
			{
				display = node.displayObject;
				displayObject = display.display;
				position = node.position;
				
				displayObject.x = position.X;
				displayObject.y = position.Y;
			}
		}
		override public function removeFromEngine( engine : Engine ) : void
		{
			displayNodes = null;
		}
	}
}