package ld29.core;

import flash.errors.Error;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;

/**
 * ...
 * @author namide.com
 */
class SimpleSound
{
	
	private var _volume:Float = 0.5;
	private var _loop:Bool;
	
	private var _sound:Sound;
	private var _soundChannel:SoundChannel;
	private var _soundTransform:SoundTransform;
	
	private var _autoPlay:Bool;
	
	private var _src:String;
	private var _pauseTime:UInt = 0;
	
	public function new( src:String, loop:Bool = false ) 
	{
		_loop = loop;
		_autoPlay = _loop;
		_soundTransform = new SoundTransform( _volume, 0 );
		setSrcAndLoad( src );
	}
	
	
	private function onLoaded(e:Event):Void
	{
		try
		{
			if ( _autoPlay )	play();
			else 				pause();
		}
		catch (e:Error)
		{
			
		}
	}
	
	private function setSrcAndLoad( src:String ):Void
	{
		_src = src;
		_sound = new Sound();
		_sound.addEventListener( Event.COMPLETE , onLoaded );
		_soundTransform = new SoundTransform( _volume );
		_sound.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
		
		var request:URLRequest = new URLRequest(_src);
		
		try
		{
			_sound.load( request );
		}
		catch (e:Error)
		{
			//trace( e.message );
		}
	}
	
	private function onIOError(e:IOErrorEvent):Void
	{
		//trace( e.text );
	}
	
	public function play(time:Int = 0):Void 
	{
		if ( time < 0 ) time = 0;
		
		if ( _sound != null )
		{
			_soundChannel = _sound.play( time, (_loop)?9999:0, _soundTransform );
		}
		else
		{
			_pauseTime = time;
			_autoPlay = true;
		}
		
	}

	public function pause():Void 
	{
		_autoPlay = false;
		
		if ( _soundChannel != null )
		{
			_soundChannel.stop();
		}
	}

	public function stop():Void 
	{
		_autoPlay = false;
		_pauseTime = 0;
		
		if ( _soundChannel != null )
		{
			_soundChannel.stop();
		}
	}

	public function getVolume():Float 
	{
		//if ( _soundTransform != null ) _volume = _soundTransform.volume;
		return _volume;
	}
	public function setVolume(val:Float):Void 
	{
		_volume = val;
		_soundTransform = new SoundTransform( _volume );
		
		if ( _soundChannel != null )
		{
			_soundChannel.soundTransform = _soundTransform;
		}
		
	}

	
	
}


		