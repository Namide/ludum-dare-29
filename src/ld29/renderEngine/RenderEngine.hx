package ld29.renderEngine;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.PixelSnapping;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;
import ld29.entities.Entity;
import ld29.entities.Ground;
import ld29.renderEngine.RenderEngine.BGBD;
import ld29.settings.StageSettings;

@:bitmap("ld29/assets/bg.png")
class BGBD extends flash.display.BitmapData
{
    
}

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
		_bg = new BGBD( StageSettings.W, StageSettings.H, false );//new BitmapData( StageSettings.W, StageSettings.H, false, 0xCC00CC );
		
		
		
		_renderBD = new BitmapData( StageSettings.W, StageSettings.H, false, 0x000000 );
		super( _renderBD, PixelSnapping.NEVER, false );
	}
	
	public function refresh( entities:Iterable<Entity>, ground:Ground )
	{
		var m:Matrix = new Matrix();
		var p:Point = new Point();
		_renderBD.copyPixels( _bg, _bg.rect, p );
		
		var groundDrawed:Bool = false;
		
		for ( entity in entities )
		{
			if ( !groundDrawed && entity.type != Entity.TYPE_GRAPHIC_UNDER )
			{
				groundDrawed = drawGround(ground, m);
			}
			
			p.setTo( entity.x, entity.y );
			var bd:BitmapData = entity.graphic.bd;
			_renderBD.copyPixels( bd, bd.rect, p, bd.transparent );
		}
		bitmapData = _renderBD;
	}
	
	private function drawGround(ground:Ground, m:Matrix)
	{
		m.createBox(1, 1, 0, ground.x, ground.y );
		_renderBD.draw( ground.shape, m );
		return true;
	}
	
	
}