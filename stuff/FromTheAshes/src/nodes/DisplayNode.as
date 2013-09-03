package nodes
{
	import ash.core.Node;
	import comp.DisplayComp;
	import comp.PosComp;
	
	public class DisplayNode extends Node
	{
		public var position 		:PosComp;
		public var displayObject	:DisplayComp;
		public function DisplayNode(){}
	}
}