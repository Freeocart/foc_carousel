
<?php echo $header; ?>
<?php if (isset($column_left)) { echo $column_left; } ?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <div class="pull-right">
          <button type="submit" form="foc_add2cart_box_form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
          <a href="" data-toggle="tooltip" title="" class="btn btn-default" data-original-title="<?php echo $button_cancel; ?>"><i class="fa fa-reply"></i></a></div>
        </div>

        <h1><?php echo $heading_title; ?></h1>

        <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) : ?>
          <li><a href="<?php echo $breadcrumb["href"]; ?>"><?php echo $breadcrumb["text"]; ?></a></li>
        <?php endforeach; ?>
        </ul>
    </div>
  </div>

  <div class="container-fluid">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
      </div>
      <div class="panel-body">
        <form id="foc_add2cart_box_form" class="form form-horizontal" action="<?php $action; ?>" method="POST">

          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" class="form-control">
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_slides_count; ?></label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="slides_count" value="<?php echo $slides_count; ?>">
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_template_postfix; ?></label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="template_postfix" value="<?php echo $template_postfix; ?>">
            </div>
          </div>

          <ul class="nav nav-tabs">
            <?php foreach ($languages as $language) : ?>
            <li <?php if ($language['language_id'] == $language_id) : ?>class="active"<?php endif; ?>>
              <a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
            </li>
            <?php endforeach; ?>
            <li>
              <a href="#tab-info" data-toggle="tab">
                <i class="fa fa-info-circle"></i> <?php echo $labels['foc_add2cart_box_info_tab_name']; ?>
              </a>
            </li>
          </ul>

          <div class="tab-content">
            <?php foreach ($languages as $language) : ?>
            <?php $lang_id = $language['language_id']; ?>
            <div class="tab-pane <?php if ($lang_id == $language_id) : ?>active<?php endif; ?>" id="language<?php echo $lang_id; ?>">

              <div class="form-group">
                <div class="col-sm-2">
                  <label for=""><?php echo $entry_crop_horizontal; ?></label>
                </div>
                <div class="col-sm-2">
                  <input name="foc_carousel_settings[<?php echo $lang_id; ?>][crop_horizontal]" type="text" class="form-control" value="<?php echo $settings[$lang_id]['crop_horizontal']; ?>">
                </div>

                <div class="col-sm-2">
                  <label for=""><?php echo $entry_crop_vertical; ?></label>
                </div>
                <div class="col-sm-2">
                  <input name="foc_carousel_settings[<?php echo $lang_id; ?>][crop_vertical]" type="text" class="form-control" value="<?php echo $settings[$lang_id]['crop_vertical']; ?>">
                </div>
              </div>

              <div class="btn-group">
                <a href="#" class="btn btn-primary b-slides__add" data-language-id="<?php echo $language['language_id']; ?>"><i class="fa fa-plus"></i> <?php echo $button_add_slide; ?></a>
              </div>

              <div class="form-group b-slides__container">

                <?php if (isset($slides[$lang_id]) && count($slides[$lang_id]) > 0) : ?>
                  <?php foreach ($slides[$lang_id] as $i => $slide) : ?>
                  <div class="b-slides__slide">
                    <div class="col-sm-2">
                      <select class="form-control b-slide__type_select">
                        <option <?php if (!isset($slide['type'])) : ?>selected<?php endif; ?> disabled>Not selected</option>
                        <option <?php if (isset($slide['type']) && $slide['type'] == 'image') : ?>selected<?php endif; ?> value="image">Image upload</option>
                        <option <?php if (isset($slide['type']) && $slide['type'] == 'youtube') : ?>selected<?php endif; ?>  value="youtube">Youtube link</option>
                        <option <?php if (isset($slide['type']) && $slide['type'] == 'html') : ?>selected<?php endif; ?>  value="html">Custom html</option>
                      </select>
                    </div>

                    <div class="col-sm-2">
                      <a href="" class="btn btn-danger b-slide__delete"><i class="fa fa-trash"></i> <?php echo $button_remove_slide; ?></a>
                    </div>

                    <div class="col-sm-1">
                      <input type="hidden" class="form-control b-slide__weight" placeholder="Weight" name="foc_carousel[<?php echo $lang_id; ?>][<?php echo $i; ?>][weight]" value="<?php echo $i; ?>">
                    </div>

                    <div class="b-slides__slide_handle">
                      <span class="ui-icon ui-icon-arrow-4-diag"></span>
                    </div>

                    <div class="b-slide__content col-sm-12">
                    <?php if (isset($slide['type'])) : ?>
                      <?php if ($slide['type'] == 'html') : ?>
                        <input type="hidden" name="foc_carousel[<?php echo $lang_id; ?>][<?php echo $i; ?>][type]" value="html">
                        <textarea name="foc_carousel[<?php echo $lang_id; ?>][<?php echo $i; ?>][content]" rows="3" class="form-control summernote"><?php echo $slide['content']; ?></textarea>
                      <?php elseif ($slide['type'] == 'image') : ?>
                        <input type="hidden" name="foc_carousel[<?php echo $lang_id; ?>][<?php echo $i; ?>][type]" value="image">
                        <div>
                          <a href="#" id="thumb-image-<?php echo $lang_id; ?>-<?php echo $i; ?>" data-toggle="image" class="img-thumbnail">
                            <img src="<?php echo $slide['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
                          </a>
                          <input type="text" class="form-control" placeholder="<?php echo $entry_carousel_image_link; ?>" name="foc_carousel[<?php echo $lang_id; ?>][<?php echo $i; ?>][link]" value="<?php echo $slide['link']; ?>" />
                          <input type="hidden" name="foc_carousel[<?php echo $lang_id; ?>][<?php echo $i; ?>][content]" value="<?php echo $slide['content']; ?>" id="input-image-<?php echo $lang_id; ?>-<?php echo $i; ?>" />
                        </div>
                      <?php elseif ($slide['type'] == 'youtube') : ?>
                        <input type="hidden" name="foc_carousel[<?php echo $lang_id; ?>][<?php echo $i; ?>][type]" value="youtube">
                        <input name="foc_carousel[<?php echo $lang_id; ?>][<?php echo $i; ?>][content]" class="form-control" value="<?php echo $slide['content']; ?>"/>

                        <div class="form-inline">
                          <input type="text" name="foc_carousel[<?php echo $lang_id; ?>][<?php echo $i; ?>][width]" class="form-control" value="<?php echo isset($slide['width']) ? $slide['width'] : ''; ?>" placeholder="<?php echo $entry_carousel_youtube_width; ?>">
                          <input type="text" name="foc_carousel[<?php echo $lang_id; ?>][<?php echo $i; ?>][height]" class="form-control" value="<?php echo isset($slide['height']) ? $slide['height'] : ''; ?>" placeholder="<?php echo $entry_carousel_youtube_height; ?>">
                        </div>
                      <?php endif; ?>
                    <?php endif; ?>
                    </div>
                  </div>
                  <?php endforeach; ?>
                <?php endif; ?>
                  <!-- slides here -->
              </div>
            </div>
            <?php endforeach; ?>

            <div id="tab-info" class="tab-pane">
              <h3><?php echo $labels['foc_add2cart_box_info_tab_title']; ?></h3>
              <hr>
              <div>
                <?php echo $labels['foc_add2cart_box_info_tab_content']; ?>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
<link href="view/javascript/summernote/summernote.css" rel="stylesheet" />
<script type="text/javascript" src="view/javascript/summernote/opencart.js"></script>

<style>
.b-slides__slide {
  position: relative;
  padding: 1em;
  border-bottom: 1px solid #dfdfdf;
  background-color: #fff;
}
.b-slides__slide:first-child {
  border-top: 1px solid #dfdfdf;
}
.b-slides__slide.ui-sortable-helper {
  border: 1px solid #dfdfdf;
}
.b-slides__slide:before,
.b-slides__slide:after {
  content: "";
  display: table;
  clear: both;
}
.b-slides__slide_handle {
  display: block;
  position: absolute;
  right: 0;
  top: 0;
  width: 40px;
  height: 40px;
  background-color: #dfdfdf;
}
.b-slides__slide_handle .ui-icon {
  display: inline-block;
  margin: 12px;
}
</style>
<script>
$(function () {

  var recalculatePositions = function (event, ui) {
    var $el = ui.item;
    var holder = $el.parents('.b-slides__container');
    holder.find('.b-slides__slide').each(function (iter, item) {
      var $item = $(item);
      $item.find('.b-slide__weight').val($item.index());
    });
  }

  $('.b-slides__container').sortable({
    items: '.b-slides__slide',
    stop: recalculatePositions,
    handle: '.b-slides__slide_handle'
  });

  var FocCarousel = function (settings) {
    this.language_id = settings.language_id;
    this.counter = !!settings.counter ? settings.counter : 0;
    this.rootContext = settings.rootContext;
    this.imgPlaceholder = settings.imgPlaceholder;

    this.init();
  }

  FocCarousel.prototype.init = function () {

    var self = this;

    this.rootContext.on('click', '.b-slides__add', function (e) {
      e.preventDefault();
      self.addSlide();
    });

    this.rootContext.on('change', '.b-slide__type_select', function (e) {
      var type = $(this).find(':selected').val();
      var context = $(this).parents('.b-slides__slide');
      self.addSlide(type, context);
    });

    this.rootContext.on('click', '.b-slide__delete', function (e) {
      e.preventDefault();
      $(this).parents('.b-slides__slide').remove();
    })
  }

  FocCarousel.prototype.addSlide = function (type, context) {
    if (this.slideTypes.hasOwnProperty(type)
        && this.slideTypes[type] instanceof Function)
    {
      var counter = this.counter;

      if (!context) {
        context = this._createSlideContext();
        ++this.counter;
        counter = this.counter;
      }
      else {
        this._clearSlide(context);
        counter = context.find('.b-slide__weight').val();
      }

      var place = context.find('.b-slide__content')

      this.slideTypes[type].call(this, place, counter)
    }
    else {
      ++this.counter;
      this._createSlideContext();
    }
  }

  FocCarousel.prototype._clearSlide = function (slide) {
    slide.find('.b-slide__content').html(' ');
  }

  FocCarousel.prototype._createSlideContext = function () {
    var html = '<div class="b-slides__slide">'
        html += '<div class="col-sm-2">'
        html += '<select class="form-control b-slide__type_select">'
        html += '<option disabled selected>Not selected</option>'
        html += '<option value="image">Image upload</option>'
        html += '<option value="youtube">Youtube link</option>'
        html += '<option value="html">Custom html</option>'
        html += '</select>'
        html += '</div>'
        html += '<div class="col-sm-2">'
        html += '<a href="" class="btn btn-danger b-slide__delete"><i class="fa fa-trash"></i> <?php echo $button_remove_slide; ?></a>'
        html += '</div>'
        html += '<div class="col-sm-1">'
        html += '<input type="hidden" class="form-control b-slide__weight" placeholder="Weight" name="foc_carousel[' + this.language_id + '][' + this.counter + '][weight]" value="' + this.counter + '">'
        html += '</div>'
        html += '<div class="b-slides__slide_handle"></div>'
        html += '<div class="b-slide__content col-sm-12"></div>'
        html += '</div>'

    var ctx = $(html);
    this.rootContext.find('.b-slides__container').append(ctx);

    return ctx;
  }

  FocCarousel.prototype.slideTypes = {
    html: function (context, counter) {
      var html = '<input type="hidden" name="foc_carousel[' + this.language_id + '][' + counter + '][type]" value="html">';
          html += '<textarea name="foc_carousel['+ this.language_id + '][' + counter + '][content]" rows="3" class="form-control summernote"></textarea>';

      context.append(html);
      context.find('.summernote').summernote();
    },
    youtube: function (context, counter) {
      var html = '<input type="hidden" name="foc_carousel[' + this.language_id + '][' + counter + '][type]" value="youtube">';
          html += '<input name="foc_carousel['+ this.language_id + '][' + counter + '][content]" class="form-control"/>';
          html += '<div class="form-inline">';
          html += '<input type="text" name="foc_carousel[' + this.language_id + '][' + counter + '][width]" class="form-control" value="" placeholder="<?php echo $entry_carousel_youtube_width; ?>">';
          html += '<input type="text" name="foc_carousel[' + this.language_id + '][' + counter + '][height]" class="form-control" value="" placeholder="<?php echo $entry_carousel_youtube_height; ?>">';
          html += '</div>';

      context.append(html);
    },
    image: function (context, counter) {
      var html = '<input type="hidden" name="foc_carousel[' + this.language_id + '][' + counter + '][type]" value="image">';
          html += '<div>';
          html += '<a href="#" id="thumb-image-' + this.language_id + '-' + counter + '" data-toggle="image" class="img-thumbnail">';
          html += '<img src="' + this.imgPlaceholder + '" alt="" title="" data-placeholder="' + this.imgPlaceholder + '" />';
          html += '</a>';
          html += '<input type="hidden" name="foc_carousel['+ this.language_id + '][' + counter + '][content]" value="" id="input-image-' + this.language_id + '-' + counter + '" />';
          html += '<input type="text" class="form-control" placeholder="url" name="foc_carousel[' + this.language_id + '][' + counter + '][link]" value="" />'
          html += '</div>';

      context.append(html);
    }
  }

  <?php foreach ($languages as $language) : ?>
  new FocCarousel({
    language_id: '<?php echo $language['language_id']; ?>',
    counter: '<?php echo $counter[$language['language_id']]; ?>',
    rootContext: $('#language<?php echo $language['language_id']; ?>'),
    imgPlaceholder: '<?php echo $placeholder; ?>'
  });
  <?php endforeach; ?>
});
</script>

<?php echo $footer; ?>
