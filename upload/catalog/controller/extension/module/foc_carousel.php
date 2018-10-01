<?php

class ControllerExtensionModuleFocCarousel extends Controller {

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

        $data['slides'][$i]['thumb'] = $this->model_tool_image->resize($thumb, 100, 100);
      }
    }

    $route = 'extension/module/foc_carousel';
    $theme = $this->config->get('config_template');
    $theme_tpl = DIR_TEMPLATE . $theme . '/template/' . $route . '_' . $module_info['template_postfix'] . '.tpl';
    $default_tpl = DIR_TEMPLATE . 'default/template/' . $route . '_' . $module_info['template_postfix'] . '.tpl';

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