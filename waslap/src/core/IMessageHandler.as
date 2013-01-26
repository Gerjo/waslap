package core 
{
	import flash.events.Event;
	public interface IMessageHandler 
	{
		function handleMessage(e:Message) : void;
	}
}