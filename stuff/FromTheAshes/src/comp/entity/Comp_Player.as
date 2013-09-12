package comp.entity
{
	public class Comp_Player
	{
		public var left		:uint;
		public var right	:uint;
		public var down		:uint;
		public var up		:uint;
		public var space_bar:uint;
		public function Comp_Player(left:uint, right:uint,down:uint,up:uint,space_bar:uint)
		{
			this.left = left;
			this.right = right;
			this.down = down;
			this.up = up;
			this.space_bar = space_bar;
		}
	}
}