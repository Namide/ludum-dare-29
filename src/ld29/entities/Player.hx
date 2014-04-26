package ld29.entities;
import flash.ui.Keyboard;
import ld29.core.KeyboardHandler;
import ld29.renderEngine.components.Graphic;
import ld29.settings.StageSettings;

/**
 * ...
 * @author namide.com
 */
class Player extends Entity
{

	private var vxMax:Float = 10;
	private var vyMax:Float = 16;
	
	public function new(width:UInt, height:UInt) 
	{
		super(width, height);
		
		type = Entity.TYPE_PLAYER;
		
		graphic = new Graphic( width, height, true );
		graphic.bd.fillRect( graphic.bd.rect, 0xFFFF0000 );
		
		x = StageSettings.W * 0.5;
		y = StageSettings.H * 0.5;
	}
	
	public override function updateInputs():Void
	{
		var kh:KeyboardHandler = KeyboardHandler.getInstance();
		
		if ( kh.getKeyPressed( Keyboard.LEFT ) )
		{
			vX = -vxMax;
			if ( onGround ) vY = 100;
		}
		else if ( kh.getKeyPressed( Keyboard.RIGHT ) ) vX = vxMax;
		
		if ( onGround && kh.getKeyPressed( Keyboard.SPACE ) ) vY = -vyMax;
	}
	
}