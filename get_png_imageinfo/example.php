<?php
/**
 * get_png_imageinfo example
 * 
 * open in browser or execute in shell. 
 */

// load function
include('get_png_imageinfo.php');

// display info for all PNG images in directory
$files = glob('*.png', GLOB_NOSORT);
foreach($files as $file) {
	$info = get_png_imageinfo($file);
	render_info($file, $info);
}

// that's it.
return;

/**
 * Render image info, CLI or browser, a
 * plain helper function;
 */
function render_info($file, $info) {

	$info && ksort($info);

	if (PHP_SAPI == 'cli') {
		$info ? printf("File: %s\n%s", $file, print_r($info, 1)): printf("ERROR: Not a PNG file: %s\n", $file);
		print "---------------------------\n";
		return;
	}

	if (!$info) {
		printf('<h1>ERROR: Not a PNG file: %s</h1>', htmlspecialchars($file));
	} else {
	
		printf('<h1>%1$s</h1><img src="%s" width="%d" height="%d" align="left">
			<ul style="float:left;">', htmlspecialchars($file), $info['width'], $info['height']);
	
		foreach($info as $key=>$value) {
			printf('<li><b>%s:</b> %s</li>', $key, $value);
		}
		
		print('</ul><br clear="all">');
	}
	
	printf('<hr>');
}
