package com.scenes.abstract
{
	public class InputObject
	{
		public var m_name 	:String;
		public var m_email	:String;
		public var m_data 	:String;
		public var m_hour 	:String;
		public var m_type 	:String;
		public function InputObject(p_name:String = "", p_email:String = "", p_data:String = "", p_hour:String = "", p_type:String="")
		{
			this.m_name = p_name;
			this.m_email = p_email;
			this.m_data = p_data;
			this.m_hour = p_hour;
			this.m_type = p_type;
		}
		public function getStatus():Boolean
		{
			return (this.m_name != "" && this.m_email != "" && this.m_data != "" && this.m_hour != "");
		}
		public function traceIt():void
		{
			trace ("Nome:", m_name);
			trace ("Mail:", m_email);
			trace ("Data:", m_data);
			trace ("Hora:", m_hour);
			trace ("Tipo:", m_type);
		}
	}
}