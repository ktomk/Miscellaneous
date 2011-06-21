<?php
/**
 * Get image-information from PNG file
 *
 * php's getimagesize does not support additional image information
 * from PNG files like channels or bits.
 *
 * get_png_imageinfo() can be used to obtain this information
 * from PNG files.
 *
 * @author Tom Klingenberg <lastflood.net>
 * @license Apache 2.0
 * @version 0.1.0
 * @link http://www.libpng.org/pub/png/spec/iso/index-object.html#11IHDR
 *
 * @param string $file filename
 * @return array|bool image information, FALSE on error
 */
function get_png_imageinfo($file) {
	if (empty($file)) return false;

	$info = unpack('A8sig/Nchunksize/A4chunktype/Nwidth/Nheight/Cbit-depth/'.
        'Ccolor/Ccompression/Cfilter/Cinterface', 
		file_get_contents($file,0,null,0,29))
		;

	if (empty($info)) return false;

	if ("\x89\x50\x4E\x47\x0D\x0A\x1A\x0A"!=array_shift($info))
		return false; // no PNG signature.

	if (13 != array_shift($info))
		return false; // wrong length for IHDR chunk.

	if ('IHDR'!==array_shift($info))
		return false; // a non-IHDR chunk singals invalid data.

	$color = $info['color'];

	$type = array(0=>'Greyscale', 2=>'Truecolour', 3=>'Indexed-colour',
	4=>'Greyscale with alpha', 6=>'Truecolour with alpha');

	if (empty($type[$color]))
		return false; // invalid color value

	$info['color-type'] = $type[$color];

	$samples = ((($color%4)%3)?3:1)+($color>3);

	$info['channels'] = $samples;
	$info['bits'] = $info['bit-depth'];

	return $info;
}