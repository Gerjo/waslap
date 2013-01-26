package entities  {
	import core.Entity;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.*;
	
	public class Text extends Entity {
		protected var textbox:TextField     = new TextField();
		protected var textFormat:TextFormat = new TextFormat();
		
		public function Text(initText:String = "", formatFlags:Object = null) {
			this.x 	   = 0;
			this.y     = 0;
			
			setText(initText);
			
			textFormat.font  = "arial";
			textFormat.size  = 35;
			textFormat.color = 0xffffff;
			textFormat.align = TextFormatAlign.CENTER;
			
			if (formatFlags != null) {
				for (var k:String in formatFlags) {
					textFormat[k] = formatFlags[k];
				}
			}
			
			textbox.setTextFormat(textFormat);
			textbox.antiAliasType = AntiAliasType.ADVANCED;
			
			textbox.autoSize      = TextFieldAutoSize.LEFT;
            addChild(textbox);
        }
		
		public function setText(text:String) : void {
			textbox.text = text;
			textbox.setTextFormat(textFormat);
		}
	}
}