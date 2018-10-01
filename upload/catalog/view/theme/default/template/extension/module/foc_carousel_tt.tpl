tttt
<div id="carousel<?php echo $module; ?>" class="owl-carousel">
  <?php foreach ($slides as $slide) { ?>
  <div class="item text-center">
    <?php if (isset($slide['type'])) : ?>
      <?php if ($slide['type'] == 'image') : ?>
        <img src="<?php echo $slide['thumb']; ?>" alt="">
      <?php elseif ($slide['type'] == 'youtube') : ?>
        <iframe src="<?php echo html_entity_decode($slide['content']); ?>" frameborder="0"></iframe>
      <?php elseif ($slide['type'] == 'html') : ?>
        <?php echo html_entity_decode($slide['content']); ?>
      <?php endif; ?>
    <?php endif; ?>
  </div>
  <?php } ?>
</div>

<script type="text/javascript"><!--
$('#carousel<?php echo $module; ?>').owlCarousel({
	items: <?php echo $slides_count; ?>,
	autoPlay: 3000,
	navigation: true,
	navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
	pagination: true
});
--></script>