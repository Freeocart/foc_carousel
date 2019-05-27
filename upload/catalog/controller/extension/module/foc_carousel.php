<?php

class ControllerExtensionModuleFocCarousel extends Controller {

  protected function isOpencart3 () {
    $version_chars = explode('.', VERSION);
    return (int)$version_chars[0] === 3;
  }

  public function index ($module_info) {
    static $module = 0;

    $this->load->model('tool/image');

    $data['name'] = $module_info['name'];
    $data['module'] = ++$module;

    $data['slides_count'] = $module_info['slides_count'];

		$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.carousel.css');
		$this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js');

    $language_id = $this->config->get('config_language_id');
    $data['slides'] = array();
    $data['settings'] = array(
      'crop_horizontal' => 0,
      'crop_vertical' => 0
    );

    if (isset($module_info['foc_carousel_settings'][$language_id])) {
      $data['settings'] = array_replace($data['settings'], $module_info['foc_carousel_settings'][$language_id]);
    }

    if (isset($module_info['foc_carousel'][$language_id])) {
      $data['slides'] = $module_info['foc_carousel'][$language_id];
    }

    foreach ($data['slides'] as $i => $slide) {
      if ($slide['type'] == 'image') {
        if (is_file(DIR_IMAGE . $slide['content'])) {
          $image = $slide['content'];
          $thumb = $slide['content'];
        } else {
          $image = '';
          $thumb = 'no_image.png';
        }

        $crop_horizontal = $this->config->get($this->config->get('config_theme') . '_image_thumb_width');
        $crop_vertical = $this->config->get($this->config->get('config_theme') . '_image_thumb_height');

        if ($data['settings']['crop_horizontal'] && $data['settings']['crop_vertical']) {
          $crop_horizontal = $data['settings']['crop_horizontal'];
          $crop_vertical = $data['settings']['crop_vertical'];
        }
        $data['slides'][$i]['thumb'] = $this->model_tool_image->resize($thumb, $crop_horizontal, $crop_vertical);
      }
    }

    $route = 'extension/module/foc_carousel';
    $theme = $this->config->get('config_theme');
    if ($theme == 'theme_default') {
      $theme = $this->config->get('theme_default_directory');
    }
    else {
      $theme = $this->config->get('config_theme');
    }

    $theme_tpl = DIR_TEMPLATE . $theme . '/template/' . $route . '_' . $module_info['template_postfix'];
    $default_tpl = DIR_TEMPLATE . 'default/template/' . $route . '_' . $module_info['template_postfix'];

    if ($this->isOpencart3()) {
      $theme_tpl .= '.twig';
      $default_tpl .= '.twig';
    }
    else {
      $theme_tpl .= '.tpl';
      $default_tpl .= '.tpl';
    }

    if ($module_info['template_postfix']) {
      if (($theme && is_file($theme_tpl)) || is_file($default_tpl)) {
        $route .= '_' . $module_info['template_postfix'];
      }
    }

    try {
      return $this->load->view($route, $data);
    }
    catch (Exception $e) {
      echo 'not ok!';
    }
  }

}