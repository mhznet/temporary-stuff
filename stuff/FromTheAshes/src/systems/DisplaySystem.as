package systems
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	import nodes.DisplayNode;
	import comp.DisplayComp;
	import comp.PosComp;

	public class DisplaySystem extends System
	{
		public var displayContainer 	:DisplayObjectContainer;
		private var displayNodes 		:NodeList;
		public function DisplaySystem(dispContainer:DisplayObjectContainer)
		{
			displayContainer = dispContainer;
		}
		override public function addToEngine(engine:Engine):void
		{
			displayNodes = engine.getNodeList(DisplayNode);
			for( var node : DisplayNode = displayNodes.head; node; node = node.next )
			{
				addToDisplay(node);
			}
			displayNodes.nodeAdded.add(addToDisplay);
			displayNodes.nodeRemoved.add(removeFromDisplay);
		}
		private function addToDisplay(node:DisplayNode):void
		{
			displayContainer.addChild(node.displayObject.display);
		}
		private function removeFromDisplay(node:DisplayNode):void
		{
			displayContainer.removeChild(node.displayObject.display);
		}
		override public function update( time : Number ) : void
		{
			var node:DisplayNode;
			var position:PosComp;
			var display:DisplayComp;
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