package nodes
{
	import ash.core.Node;
	
	import comp.Comp_Display;
	import comp.Comp_PlayerControl;
	import comp.Comp_PlayerFlipper;
	import comp.Comp_Position;

	public class Node_PlayerFlipper extends Node
	{
		public var control	:Comp_PlayerControl;
		public var display	:Comp_Display;
		public var animation:Comp_PlayerFlipper;
		public var position:Comp_Position;
		public function Node_PlayerFlipper(){}
	}
}