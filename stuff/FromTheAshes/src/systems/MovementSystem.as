package systems
{
	import ash.tools.ListIteratingSystem;
	
	import comp.PosComp;
	import comp.SpeedComp;
	import nodes.MovementNode;

	public class MovementSystem extends ListIteratingSystem
	{
		public function MovementSystem()
		{
			super(MovementNode, updateNode);
		}
		private function updateNode(node:MovementNode, time:Number):void
		{
			var speed	:SpeedComp = node.speed;
			var pos		:PosComp = node.position;
			pos.X += speed.X;
			pos.Y += speed.Y;
		}
	}
}