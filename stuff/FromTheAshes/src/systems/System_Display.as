package systems
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	import nodes.Node_Display;
	import comp.Comp_Display;
	import comp.Comp_Position;

	public class System_Display extends System
	{
		public var displayContainer 	:DisplayObjectContainer;
		private var displayNodes 		:NodeList;
		public function System_Display(dispContainer:DisplayObjectContainer)
		{
			displayContainer = dispContainer;
		}
		override public function addToEngine(engine:Engine):void
		{
			displayNodes = engine.getNodeList(Node_Display);
			for( var node : Node_Display = displayNodes.head; node; node = node.next )
			{
				addToDisplay(node);
			}
			displayNodes.nodeAdded.add(addToDisplay);
			displayNodes.nodeRemoved.add(removeFromDisplay);
		}
		private function addToDisplay(node:Node_Display):void
		{
			displayContainer.addChild(node.displayObject.display);
		}
		private function removeFromDisplay(node:Node_Display):void
		{
			displayContainer.removeChild(node.displayObject.display);
		}
		override public function update( time : Number ) : void
		{
			var node:Node_Display;
			var position:Comp_Position;
			var display:Comp_Display;
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