package ld29.renderEngine;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;
import ld29.entities.Entity;
import ld29.entities.Ground;
import ld29.settings.StageSettings;

/**
 * ...
 * @author namide.com
 */
class RenderEngine extends Bitmap
{
	
	private var _bg:BitmapData;
	private var _renderBD:BitmapData;
	
	public function new() 
	{
		_bg = new BitmapData( StageSettings.W, StageSettings.H, false, 0xCC00CC );
		_renderBD = new BitmapData( StageSettings.W, StageSettings.H, false, 0x000000 );
		super( _renderBD, PixelSnapping.NEVER, false );
	}
	
	public function refresh( entities:Array<Entity>, ground:Ground )
	{
		var m:Matrix = new Matrix();
		var p:Point = new Point();
		_renderBD.copyPixels( _bg, _bg.rect, p );
		
		m.createBox(1, 1, 0, ground.getX(), ground.getY() );
		_renderBD.draw( ground.shape, m );
		
		for ( entity in entities )
		{
			p.setTo( entity.x, entity.y );
			var bd:BitmapData = entity.graphic.bd;
			_renderBD.copyPixels( bd, bd.rect, p, bd.transparent );
		}
		bitmapData = _renderBD;
	}
	
}